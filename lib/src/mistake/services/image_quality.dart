import 'dart:io';
import 'dart:math' as math;

import 'package:image/image.dart' as img;

/// 图片质量检查结果（本地、确定性、非 AI）。
class ImageQualityReport {
  const ImageQualityReport({
    required this.width,
    required this.height,
    required this.blurScore,
    required this.exposureScore,
    required this.qualityScore,
    required this.lowResolution,
  });

  final int width;
  final int height;

  /// Laplacian 方差（越大越清晰）。
  final double blurScore;

  /// 曝光分 0~100，越高越接近正常曝光。
  final double exposureScore;

  /// 综合质量 0~100。
  final double qualityScore;

  /// 有效分辨率是否偏低（打印可能不清晰）。
  final bool lowResolution;

  bool get isGood =>
      qualityScore >= 55 && !lowResolution && blurScore >= 40;

  String get summary {
    if (isGood) return '图片质量良好';
    final problems = <String>[];
    if (blurScore < 40) {
      problems.add('照片较模糊，小字打印后可能不清晰');
    }
    if (exposureScore < 55) {
      problems.add(blurScore >= 40 ? '存在过曝或欠曝' : '');
    }
    if (lowResolution) {
      problems.add('分辨率偏低');
    }
    return '建议重新拍摄：${problems.where((e) => e.isNotEmpty).join('；')}';
  }
}

/// 使用传统图像指标做图片质量门禁。
///
/// 只做确定性统计指标，不使用任何 AI/OCR 模型。
/// 注意：本模块目前【不】检测透视/倾斜，[ImageQualityReport] 也没有
/// perspectiveWarning 输出——调用方不得据此伪造已检测结果。
///
/// TODO(phase2): 大图解码与像素统计迁移到后台 isolate，避免阻塞 UI isolate；
/// 并加入真实透视/倾斜几何检测后，再在 UI 上展示对应警示。
class MistakeImageQuality {
  const MistakeImageQuality();

  Future<ImageQualityReport> analyze(String path) async {
    final bytes = await File(path).readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      throw StateError('无法解码图片: $path');
    }
    final baked = img.bakeOrientation(decoded);
    final width = baked.width;
    final height = baked.height;

    // 缩小到短边 256 计算，保证速度与稳定性。
    final scale = 256.0 / math.min(width, height);
    final smallW = math.max(1, (width * scale).round());
    final smallH = math.max(1, (height * scale).round());
    final small = img.copyResize(baked,
        width: smallW, height: smallH, interpolation: img.Interpolation.average);

    // 灰度数组
    final w = small.width;
    final h = small.height;
    final gray = List<double>.generate(w * h, (i) {
      final p = small.getPixel(i % w, i ~/ w);
      return 0.299 * p.r + 0.587 * p.g + 0.114 * p.b;
    });

    // Laplacian 方差（清晰度）
    var sum = 0.0;
    var sumSq = 0.0;
    var over = 0;
    var under = 0;
    const overThreshold = 245.0;
    const underThreshold = 18.0;
    for (var y = 1; y < h - 1; y++) {
      for (var x = 1; x < w - 1; x++) {
        final i = y * w + x;
        final center = gray[i];
        final lap = 4 * center -
            gray[i - 1] -
            gray[i + 1] -
            gray[i - w] -
            gray[i + w];
        sum += lap;
        sumSq += lap * lap;
        if (center > overThreshold) over++;
        if (center < underThreshold) under++;
      }
    }
    final n = math.max(1, (w - 2) * (h - 2));
    final mean = sum / n;
    final variance = math.max(0.0, sumSq / n - mean * mean);

    // 过曝/欠曝：亮部或暗部被削顶的比例
    final overRatio = over / n;
    final underRatio = under / n;
    var exposureScore =
        100 - overRatio * 100 - underRatio * 140;
    exposureScore = exposureScore.clamp(0.0, 100.0).toDouble();

    // 综合分：清晰度+曝光。
    final blurScore = math.min(variance, 5000.0);
    final blurPart = (blurScore / 300.0 * 100).clamp(0.0, 100.0);
    final quality = (blurPart * 0.6 + exposureScore * 0.4)
        .clamp(0.0, 100.0)
        .toDouble();

    final lowResolution =
        math.min(width, height) < 900 && width * height < 900 * 1200;

    return ImageQualityReport(
      width: width,
      height: height,
      blurScore: blurScore,
      exposureScore: exposureScore,
      qualityScore: quality,
      lowResolution: lowResolution,
    );
  }
}

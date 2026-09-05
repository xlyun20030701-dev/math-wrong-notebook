import 'dart:math' as math;
import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// AI 标记出的待清理区域（归一化）。
class MaskRegion {
  const MaskRegion({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });
  final double x;
  final double y;
  final double width;
  final double height;
}

/// 本地传统图像清理（确定性算法）。
///
/// TODO(phase): 大图请经 [Isolate.run] 调用，勿在 UI isolate 直接跑全尺寸图。
class CleaningEngine {
  const CleaningEngine();

  /// 基础清理：灰度→背景/亮度均衡→对比度→轻锐化→裁白边。
  Uint8List basicClean(
    Uint8List input, {
    int maxDim = 3200,
  }) {
    var image = img.decodeImage(input);
    if (image == null) throw StateError('无法解码图片');
    image = img.bakeOrientation(image);

    if (image.width > maxDim || image.height > maxDim) {
      final scale = maxDim / math.max(image.width, image.height);
      image = img.copyResize(image,
          width: (image.width * scale).round(),
          height: (image.height * scale).round(),
          interpolation: img.Interpolation.average);
    }

    var gray = img.grayscale(image);

    // 背景增白 + 亮度均衡（线性映射，不做局部自适应以保数学笔画稳定）。
    final lut = _levelLut(gray);
    for (final p in gray) {
      final v = lut[p.r.toInt()].toInt();
      gray.setPixelRgb(p.x, p.y, v, v, v);
    }

    // 轻度对比度增强
    _contrastInPlace(gray, amount: 1.12);

    // 轻锐化（unsharp），轻度提清晰度
    gray = _unsharp(gray, amount: 0.3);

    // 裁白边
    gray = _cropWhiteBorder(gray);

    return Uint8List.fromList(img.encodeJpg(gray, quality: 90));
  }

  /// 在指定区域弱化彩色批注/污迹（区域外像素不动，公式符号不受影响）。
  Uint8List suppressRegions(
    Uint8List input,
    List<MaskRegion> regions, {
    int maxDim = 3200,
  }) {
    var image = img.decodeImage(input);
    if (image == null) throw StateError('无法解码图片');
    image = img.bakeOrientation(image);
    if (image.width > maxDim || image.height > maxDim) {
      final scale = maxDim / math.max(image.width, image.height);
      image = img.copyResize(image,
          width: (image.width * scale).round(),
          height: (image.height * scale).round(),
          interpolation: img.Interpolation.average);
    }
    final out = img.Image.from(image);
    for (final r in regions) {
      final x0 = (r.x * out.width).floor().clamp(0, out.width - 1);
      final y0 = (r.y * out.height).floor().clamp(0, out.height - 1);
      final x1 = ((r.x + r.width) * out.width).floor().clamp(x0, out.width - 1);
      final y1 = ((r.y + r.height) * out.height).floor().clamp(y0, out.height - 1);
      for (var y = y0; y <= y1; y++) {
        for (var x = x0; x <= x1; x++) {
          final p = out.getPixel(x, y);
          final r0 = p.r.toInt();
          final g = p.g.toInt();
          final b = p.b.toInt();
          final maxC = math.max(r0, math.max(g, b));
          final minC = math.min(r0, math.min(g, b));
          final sat = maxC - minC;
          if (sat > 24 || minC < 90) {
            out.setPixelRgb(x, y, 248, 248, 248);
          }
        }
      }
    }
    return Uint8List.fromList(img.encodeJpg(out, quality: 90));
  }

  void _contrastInPlace(img.Image src, {required double amount}) {
    for (final p in src) {
      final v = ((p.r - 128) * amount + 128).clamp(0, 255);
      final c = v.toInt();
      src.setPixelRgb(p.x, p.y, c, c, c);
    }
  }

  img.Image _unsharp(img.Image src, {required double amount}) {
    final blurred = img.gaussianBlur(src, radius: 2);
    final out = img.Image.from(src);
    for (final p in out) {
      final b = blurred.getPixel(p.x, p.y);
      final v = (p.r + amount * (p.r - b.r)).clamp(0, 255);
      final c = v.toInt();
      out.setPixelRgb(p.x, p.y, c, c, c);
    }
    return out;
  }

  img.Image _cropWhiteBorder(img.Image image) {
    var top = image.height;
    var bottom = 0;
    var left = image.width;
    var right = 0;
    const th = 226;
    for (var y = 0; y < image.height; y += 2) {
      for (var x = 0; x < image.width; x += 2) {
        final p = image.getPixel(x, y);
        if (p.r.toInt() < th || p.g.toInt() < th || p.b.toInt() < th) {
          if (y < top) top = y;
          if (y > bottom) bottom = y;
          if (x < left) left = x;
          if (x > right) right = x;
        }
      }
    }
    if (bottom <= top || right <= left) return image;
    const margin = 6;
    final x0 = math.max(0, left - margin);
    final y0 = math.max(0, top - margin);
    final x1 = math.min(image.width, right + margin + 1);
    final y1 = math.min(image.height, bottom + margin + 1);
    return img.copyCrop(image, x: x0, y: y0, width: x1 - x0, height: y1 - y0);
  }

  List<int> _levelLut(img.Image src) {
    final samples = <int>[];
    for (var y = 0; y < src.height; y += 4) {
      for (var x = 0; x < src.width; x += 4) {
        final p = src.getPixel(x, y);
        samples.add((p.r + p.g + p.b) ~/ 3);
      }
    }
    if (samples.isEmpty) return List<int>.generate(256, (i) => i);
    samples.sort();
    final bg = samples[samples.length ~/ 2];
    final black = math.max(0, bg - 170);
    final white = math.min(255, bg + 30);
    final span = math.max(1, white - black);
    return List<int>.generate(256, (i) {
      if (i <= black) return 18;
      if (i >= white) return 248;
      return 18 + (((i - black) * 230) / span).round();
    });
  }
}

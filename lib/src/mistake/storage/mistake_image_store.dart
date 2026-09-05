import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:smart_wrong_notebook/src/mistake/services/block_geometry.dart';
import 'package:uuid/uuid.dart';

/// 本地图片文件存储。
///
/// 目录结构：
///   <doc>/math_wrong_notebook/papers/<paperId>/original/<uuid>.<ext>
///   <doc>/math_wrong_notebook/papers/<paperId>/blocks/<uuid>.jpg
///
/// 原图永不修改；裁剪产物写入独立文件。
///
/// TODO(phase2): 把 [decodeBaked]/[cropBaked] 的大图解码与像素处理迁移到
/// 后台 isolate（compute/Isolate.run），并加入“按页面一次解码、多次裁剪”
/// 的内存缓存，避免在 UI isolate 上反复整图解码。
class MistakeImageStore {
  const MistakeImageStore({this.baseDir});

  /// 测试时可注入临时目录；为 null 时使用应用文档目录。
  final String? baseDir;

  Future<Directory> _paperDirectory(int paperId) async {
    final String base;
    if (baseDir != null) {
      base = baseDir!;
    } else {
      final docs = await getApplicationDocumentsDirectory();
      base = docs.path;
    }
    final dir = Directory(
      p.join(base, 'math_wrong_notebook', 'papers', '$paperId'),
    );
    await dir.create(recursive: true);
    return dir;
  }

  /// 把用户拍摄/选择的原始照片复制到原图目录并返回新路径。
  Future<String> copyOriginal(int paperId, File source) async {
    final dir = await _paperDirectory(paperId);
    final originals = Directory(p.join(dir.path, 'original'));
    await originals.create(recursive: true);
    final ext = _extOf(source.path);
    final dest = p.join(originals.path, '${const Uuid().v4()}$ext');
    await source.copy(dest);
    return dest;
  }

  /// 保存派生文件（processed/masks/answers/generated）到 papers/<paperId>/<sub>。
  Future<String> saveDerived(
    int paperId,
    Uint8List bytes,
    String subfolder,
    String ext,
  ) async {
    final dir = await _paperDirectory(paperId);
    final sub = Directory(p.join(dir.path, subfolder));
    await sub.create(recursive: true);
    final dest = p.join(sub.path, '${const Uuid().v4()}.$ext');
    await File(dest).writeAsBytes(bytes, flush: true);
    return dest;
  }

  /// 解码并应用 EXIF 方向后的整页图（不修改磁盘上的原图）。
  Future<img.Image> decodeBaked(String originalPath) async {
    final bytes = await File(originalPath).readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      throw StateError('无法解码图片: $originalPath');
    }
    return img.bakeOrientation(decoded);
  }

  /// 依据归一化矩形把整页图裁剪为独立 jpg（不修改原图）。
  ///
  /// 每次调用会做一次完整解码；同一页面连续框选时建议先 [decodeBaked] 一次，
  /// 再调用 [cropBaked] 复用已解码图像，避免重复整图解码。
  Future<String> cropBlock(
    int paperId,
    String originalPath, {
    required double x,
    required double y,
    required double width,
    required double height,
  }) async {
    final baked = await decodeBaked(originalPath);
    return cropBaked(paperId, baked,
        x: x, y: y, width: width, height: height);
  }

  /// 用已解码（已应用方向）的图像裁剪出区块。
  ///
  /// 与 [cropBlock] 相同的归一化语义，但不会重复解码整图。
  Future<String> cropBaked(
    int paperId,
    img.Image baked, {
    required double x,
    required double y,
    required double width,
    required double height,
  }) async {
    final iw = baked.width;
    final ih = baked.height;
    if (iw <= 0 || ih <= 0) {
      throw ArgumentError('无效图片尺寸: ${iw}x$ih');
    }
    final r = _clampNormalized(x, y, width, height, iw, ih);
    final crop = img.copyCrop(
      baked,
      x: r.$1,
      y: r.$2,
      width: r.$3,
      height: r.$4,
    );
    final jpg = img.encodeJpg(crop, quality: 92);
    final dir = await _paperDirectory(paperId);
    final blocks = Directory(p.join(dir.path, 'blocks'));
    await blocks.create(recursive: true);
    final dest = p.join(blocks.path, '${const Uuid().v4()}.jpg');
    await File(dest).writeAsBytes(jpg, flush: true);
    return dest;
  }

  /// 校验并计算裁剪像素矩形。
  ///
  /// 抛 [ArgumentError]（而不是悄悄生成 1px 图片）当且仅当：
  /// - 归一化坐标越界；
  /// - 选区为退化的零面积；
  /// - 裁剪出的实际像素边长小于 [kMinBlockCropPixels]。
  (int, int, int, int) _clampNormalized(
      double x, double y, double width, double height, int iw, int ih) {
    if (x.isNaN ||
        y.isNaN ||
        width.isNaN ||
        height.isNaN ||
        width <= 0 ||
        height <= 0) {
      throw ArgumentError('无效的选区坐标');
    }
    if (x < -1e-6 || y < -1e-6 || x + width > 1.0 + 1e-6 || y + height > 1.0 + 1e-6) {
      throw ArgumentError('选区超出图片范围，请重新框选');
    }
    final cx = (x * iw).floor().clamp(0, iw - 1);
    final cy = (y * ih).floor().clamp(0, ih - 1);
    final cw = (width * iw).round();
    final ch = (height * ih).round();
    if (cw < kMinBlockCropPixels || ch < kMinBlockCropPixels) {
      throw ArgumentError(
        '选区过小（约 ${cw}x$ch 像素），打印会不清晰，请重新框选',
      );
    }
    // 裁到图片边界以内，防止浮点误差造成越界。
    final actualW = math.min(cw, iw - cx);
    final actualH = math.min(ch, ih - cy);
    if (actualW < kMinBlockCropPixels || actualH < kMinBlockCropPixels) {
      throw ArgumentError('选区过小，请重新框选');
    }
    return (cx, cy, actualW, actualH);
  }

  Future<void> deleteImage(String? imagePath) async {
    if (imagePath == null || imagePath.isEmpty) return;
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {
      // 删除失败不影响主流程。
    }
  }

  Future<void> deletePaperDirectory(int paperId) async {
    try {
      final dir = await _paperDirectory(paperId);
      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
    } catch (_) {
      // 忽略删除错误。
    }
  }

  String _extOf(String path) {
    final dot = path.lastIndexOf('.');
    if (dot < 0 || dot == path.length - 1) return '.jpg';
    return path.substring(dot);
  }
}

import 'dart:io';
import 'dart:math' as math;

import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// 本地图片文件存储。
///
/// 目录结构：
///   <doc>/math_wrong_notebook/papers/<paperId>/original/<uuid>.<ext>
///   <doc>/math_wrong_notebook/papers/<paperId>/blocks/<uuid>.jpg
///
/// 原图永不修改；裁剪产物写入独立文件。
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

  /// 依据归一化矩形把原始照片裁剪为独立 jpg（不修改原图）。
  Future<String> cropBlock(
    int paperId,
    String originalPath, {
    required double x,
    required double y,
    required double width,
    required double height,
  }) async {
    final dir = await _paperDirectory(paperId);
    final blocks = Directory(p.join(dir.path, 'blocks'));
    await blocks.create(recursive: true);
    final dest = p.join(blocks.path, '${const Uuid().v4()}.jpg');

    final bytes = await File(originalPath).readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      throw StateError('无法解码图片: $originalPath');
    }
    final baked = img.bakeOrientation(decoded);
    final iw = baked.width;
    final ih = baked.height;
    final sx = math.max(0.0, math.min(1.0, x));
    final sy = math.max(0.0, math.min(1.0, y));
    final sw = math.max(0.0, math.min(1.0 - sx, width));
    final sh = math.max(0.0, math.min(1.0 - sy, height));
    final crop = img.copyCrop(
      baked,
      x: (sx * iw).floor().clamp(0, iw - 1),
      y: (sy * ih).floor().clamp(0, ih - 1),
      width: math.max(1, (sw * iw).round()),
      height: math.max(1, (sh * ih).round()),
    );
    final jpg = img.encodeJpg(crop, quality: 92);
    await File(dest).writeAsBytes(jpg, flush: true);
    return dest;
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

import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// 解码并应用 EXIF 方向。
img.Image bakeDecoded(Uint8List bytes) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) throw StateError('无法解码图片');
  return img.bakeOrientation(decoded);
}

/// 顺时针旋转 k 个 90°（k 任意整数）。
img.Image rotateCWQuarter(img.Image src, int k) {
  var result = src;
  final turns = ((k % 4) + 4) % 4;
  for (var i = 0; i < turns; i++) {
    result = _cw90(result);
  }
  return result;
}

img.Image _cw90(img.Image src) {
  final w = src.height;
  final h = src.width;
  final out = img.Image(width: w, height: h);
  for (var y = 0; y < h; y++) {
    for (var x = 0; x < w; x++) {
      final p = src.getPixel(y, w - 1 - x);
      out.setPixel(x, y, p);
    }
  }
  return out;
}

Uint8List encodeJpgBytes(img.Image image, {int quality = 92}) =>
    Uint8List.fromList(img.encodeJpg(image, quality: quality));

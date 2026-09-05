import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:smart_wrong_notebook/src/mistake/services/bitmap_util.dart';

void main() {
  test('rotateCWQuarter swaps dims and moves top-left pixel to top-right',
      () {
    final image = img.Image(width: 3, height: 2);
    img.fill(image, color: img.ColorRgb8(200, 200, 200));
    image.setPixelRgb(0, 0, 0, 0, 0); // 原图左上角

    final r1 = rotateCWQuarter(image, 1);
    expect(r1.width, 2);
    expect(r1.height, 3);
    // 顺时针旋转后，原左上角应落在新图的右上角 (x=width-1, y=0)
    expect(r1.getPixel(r1.width - 1, 0).r.toInt(), lessThan(10));

    final r4 = rotateCWQuarter(image, 4);
    expect(r4.width, 3);
    expect(r4.height, 2);
    expect(r4.getPixel(0, 0).r.toInt(), lessThan(10));

    final r3 = rotateCWQuarter(image, 3);
    expect(r3.getPixel(0, r3.height - 1).r.toInt(), lessThan(10),
        reason: '逆时针一次后原左上角应在左下角');
  });

  test('encode/bake roundtrip keeps orientation-consistent jpeg', () {
    final image = img.Image(width: 8, height: 8);
    img.fill(image, color: img.ColorRgb8(180, 180, 180));
    final bytes = encodeJpgBytes(image);
    final baked = bakeDecoded(Uint8List.fromList(bytes));
    expect(baked.width, 8);
    expect(baked.height, 8);
  });
}

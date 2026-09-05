import 'dart:io';
import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:smart_wrong_notebook/src/mistake/services/image_quality.dart';

void main() {
  test('analyzes a synthetic image with stable, in-range metrics', () async {
    final dir = await Directory.systemTemp.createTemp('quality_test');
    addTearDown(() => dir.delete(recursive: true));

    final image = img.Image(width: 240, height: 360);
    img.fill(image, color: img.ColorRgb8(235, 235, 235));
    final rng = math.Random(7);
    for (var i = 0; i < 800; i++) {
      final x = rng.nextInt(240);
      final y = rng.nextInt(360);
      final v = 40 + rng.nextInt(80);
      image.setPixelRgb(x, y, v, v, v);
    }
    final file = File('${dir.path}/sample.jpg');
    await file.writeAsBytes(img.encodeJpg(image, quality: 90));

    final report = await const MistakeImageQuality().analyze(file.path);

    expect(report.width, 240);
    expect(report.height, 360);
    expect(report.blurScore, greaterThanOrEqualTo(0));
    expect(report.exposureScore, inInclusiveRange(0, 100));
    expect(report.qualityScore, inInclusiveRange(0, 100));
    expect(report.summary, isNotEmpty);
  });

  test('throws on undecodable file', () async {
    final dir = await Directory.systemTemp.createTemp('quality_test_bad');
    addTearDown(() => dir.delete(recursive: true));
    final file = File('${dir.path}/bad.jpg');
    await file.writeAsString('not an image');
    expect(
      const MistakeImageQuality().analyze(file.path),
      throwsStateError,
    );
  });
}

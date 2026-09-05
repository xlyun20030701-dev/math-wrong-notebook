import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:smart_wrong_notebook/src/mistake/storage/mistake_image_store.dart';

void main() {
  test('copyOriginal preserves file and cropBlock crops normalized rect',
      () async {
    final base = await Directory.systemTemp.createTemp('store_test');
    addTearDown(() => base.delete(recursive: true));
    final store = MistakeImageStore(baseDir: base.path);

    // 400x300 源图
    final sourceImage = img.Image(width: 400, height: 300);
    img.fill(sourceImage, color: img.ColorRgb8(120, 120, 120));
    for (var x = 0; x < 400; x++) {
      for (var y = 0; y < 300; y++) {
        if (x % 40 < 10) sourceImage.setPixelRgb(x, y, 0, 0, 0);
      }
    }
    final source = File('${base.path}/source.jpg');
    await source.writeAsBytes(img.encodeJpg(sourceImage, quality: 90));

    const paperId = 7;
    final originalPath =
        await store.copyOriginal(paperId, File(source.path));
    expect(originalPath, contains(p.join('papers', '7', 'original')));
    expect(await File(originalPath).exists(), isTrue);

    final cropPath = await store.cropBlock(
      paperId,
      originalPath,
      x: 0.25,
      y: 0.25,
      width: 0.5,
      height: 0.5,
    );
    expect(cropPath, contains(p.join('papers', '7', 'blocks')));
    final decoded = img.decodeImage(await File(cropPath).readAsBytes());
    expect(decoded, isNotNull);
    expect(decoded!.width, inInclusiveRange(180, 220));
    expect(decoded.height, inInclusiveRange(130, 170));

    // 原图仍然存在且尺寸未变
    final original = img.decodeImage(await File(originalPath).readAsBytes())!;
    expect(original.width, 400);
    expect(original.height, 300);

    await store.deleteImage(cropPath);
    expect(await File(cropPath).exists(), isFalse);

    // 防御：过小选区抛错，绝不悄悄生成 1px 图片。
    await expectLater(
      store.cropBlock(paperId, originalPath,
          x: 0.5, y: 0.5, width: 0.001, height: 0.2),
      throwsArgumentError,
    );
    // 防御：越界选区抛错。
    await expectLater(
      store.cropBlock(paperId, originalPath,
          x: 0.6, y: 0.1, width: 0.5, height: 0.5),
      throwsArgumentError,
    );

    await store.deletePaperDirectory(paperId);
    expect(await Directory('${base.path}/math_wrong_notebook/papers/7').exists(),
        isFalse);
  });
}

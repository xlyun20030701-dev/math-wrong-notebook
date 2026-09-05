import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:smart_wrong_notebook/src/mistake/cleaning/cleaning_engine.dart';
import 'package:smart_wrong_notebook/src/mistake/cleaning/cleaning_service.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/storage/mistake_image_store.dart';

void main() {
  test('basicClean returns decodable image, keeps content, crops border',
      () async {
    final engine = const CleaningEngine();
    final image = img.Image(width: 400, height: 500);
    img.fill(image, color: img.ColorRgb8(242, 242, 242));
    // 中间画黑色笔画块
    for (var y = 210; y < 250; y++) {
      for (var x = 150; x < 260; x++) {
        image.setPixelRgb(x, y, 0, 0, 0);
      }
    }
    final out = engine.basicClean(Uint8List.fromList(img.encodeJpg(image)));
    expect(out, isNotEmpty);
    final decoded = img.decodeJpg(out);
    expect(decoded, isNotNull);
    expect(decoded!.width, lessThanOrEqualTo(400));
    // 仍有内容（不是全白）
    var dark = 0;
    for (var y = 0; y < decoded.height; y += 4) {
      for (var x = 0; x < decoded.width; x += 4) {
        if (decoded.getPixel(x, y).r.toInt() < 120) dark++;
      }
    }
    expect(dark, greaterThan(0));
  });

  test('suppressRegions whitens colored marks inside region', () async {
    final engine = const CleaningEngine();
    final image = img.Image(width: 200, height: 200);
    img.fill(image, color: img.ColorRgb8(245, 245, 245));
    for (var y = 70; y < 130; y++) {
      for (var x = 70; x < 130; x++) {
        image.setPixelRgb(x, y, 220, 20, 20);
      }
    }
    final out = engine.suppressRegions(
      Uint8List.fromList(img.encodeJpg(image)),
      const <MaskRegion>[MaskRegion(x: 0.25, y: 0.25, width: 0.4, height: 0.4)],
    );
    final decoded = img.decodeJpg(out)!;
    var red = 0;
    for (var y = 70; y < 130; y++) {
      for (var x = 70; x < 130; x++) {
        final p = decoded.getPixel(x, y);
        if (p.r.toInt() > 200 && p.g.toInt() > 200 && p.b.toInt() > 200) {
          red++;
        }
      }
    }
    expect(red, greaterThan((60 * 60) ~/ 2),
        reason: '区域内应主要被增白');
  });

  test('CleaningService writes traditional version row and printable path',
      () async {
    final base = await Directory.systemTemp.createTemp('clean_svc');
    addTearDown(() => base.delete(recursive: true));
    final store = MistakeImageStore(baseDir: base.path);
    final db = MistakeDatabase.memory();
    addTearDown(db.close);

    final pid = await db.insertPaper(title: 'p');
    final pageId = await db.insertPage(
        paperId: pid, originalImagePath: 'x', pageIndex: 1);
    final qid = await db.insertQuestion(paperId: pid, originalQuestionNumber: '3');
    final crop = await store.cropBlock(
      pid,
      await _writeImage('${base.path}/src.jpg'),
      x: 0,
      y: 0,
      width: 1,
      height: 1,
    );
    final blockId = await db.insertBlock(
      questionId: qid,
      pageId: pageId,
      blockType: 'stem',
      x: 0,
      y: 0,
      width: 1,
      height: 1,
      processedImagePath: crop,
    );

    final service = CleaningService(db: db, store: store);
    final versionId = await service.cleanTraditional(blockId);
    final versions = await db.watchBlockVersions(blockId).first;
    expect(versions, hasLength(1));
    expect(versions.first.method, 'traditional');
    expect(versions.first.id, versionId);
    expect(await File(versions.first.processedImagePath!).exists(), isTrue);

    final printPath = await service.printablePathOf(blockId);
    expect(printPath, versions.first.processedImagePath);
  });
}

Future<String> _writeImage(String path) async {
  final image = img.Image(width: 200, height: 260);
  img.fill(image, color: img.ColorRgb8(240, 240, 240));
  for (var x = 40; x < 160; x++) {
    image.setPixelRgb(x, 120, 0, 0, 0);
  }
  final f = File(path);
  await f.writeAsBytes(img.encodeJpg(image, quality: 92));
  return path;
}

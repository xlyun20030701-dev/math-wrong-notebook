import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:smart_wrong_notebook/src/mistake/backup/backup_service.dart';

void main() {
  Future<Directory> seed() async {
    final dir = await Directory.systemTemp.createTemp('bk_test');
    final root = dir.path;
    final dbFile = File(p.join(root, 'math.db'));
    await dbFile.writeAsBytes(List<int>.generate(64, (i) => i));
    final imgDir = Directory(p.join(root, 'papers', '1', 'original'));
    await imgDir.create(recursive: true);
    await File(p.join(imgDir.path, 'a.jpg')).writeAsBytes(<int>[1, 2, 3]);
    return dir;
  }

  BackupService service(Directory dir) =>
      BackupService(dataRoot: dir.path, dbFilePath: p.join(dir.path, 'math.db'));

  test('export creates valid zip containing manifest + db + papers', () async {
    final dir = await seed();
    addTearDown(() => dir.delete(recursive: true));
    final zipPath = await service(dir).exportZip();
    expect(File(zipPath).existsSync(), isTrue);

    final extracted = await service(dir).extractAndValidate(zipPath);
    addTearDown(() => extracted.delete(recursive: true));
    expect(
        File(p.join(extracted.path, 'manifest.json')).existsSync(), isTrue);
    expect(
        File(p.join(extracted.path, 'database.sqlite')).existsSync(), isTrue);
    expect(
        File(p.join(extracted.path, 'papers', '1', 'original', 'a.jpg'))
            .existsSync(),
        isTrue);
  });

  test('stageRestore + applyPendingRestore replaces data', () async {
    final dir = await seed();
    addTearDown(() => dir.delete(recursive: true));

    // 准备“备份源”（另一个目录），内容与当前不同
    final backupSeed = await seed();
    addTearDown(() => backupSeed.delete(recursive: true));
    await File(p.join(backupSeed.path, 'papers', '1', 'original', 'a.jpg'))
        .writeAsBytes(<int>[9, 9, 9]);

    final svc = service(dir);
    final zip = await service(backupSeed).exportZip();
    await svc.stageRestore(zip);

    expect(await svc.applyPendingRestore(), isTrue);
    expect(await File(p.join(dir.path, 'math.db')).readAsBytes(),
        isNotEmpty);
    final restoredImg =
        await File(p.join(dir.path, 'papers', '1', 'original', 'a.jpg'))
            .readAsBytes();
    expect(restoredImg, <int>[9, 9, 9]);
    expect(Directory(p.join(dir.path, 'pending_restore')).existsSync(), isFalse);

    // 无暂存包 → 返回 false
    expect(await svc.applyPendingRestore(), isFalse);
  });

  test('future schema version rejected on restore', () async {
    final dir = await seed();
    addTearDown(() => dir.delete(recursive: true));
    final svc = service(dir);
    final zip = await svc.exportZip();
    final extracted = await svc.extractAndValidate(zip);
    // 改高版本并重新打成 zip
    final mf = File(p.join(extracted.path, 'manifest.json'));
    await mf.writeAsString(
        '{"backupVersion":1,"schemaVersion":99,"createdAt":"x"}');
    final archive = Archive();
    await for (final f in Directory(extracted.path).list(recursive: true)) {
      if (f is File) {
        final rel = f.path.substring(extracted.path.length + 1).replaceAll('\\', '/');
        archive.addFile(
            ArchiveFile(rel, await f.length(), await f.readAsBytes()));
      }
    }
    final rezip = p.join(extracted.path, 'high.zip');
    await File(rezip).writeAsBytes(ZipEncoder().encode(archive));

    await expectLater(svc.stageRestore(rezip), throwsA(isA<BackupError>()));
    await extracted.delete(recursive: true);
  });
}

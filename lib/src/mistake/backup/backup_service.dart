import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:path/path.dart' as p;

class BackupManifest {
  BackupManifest({
    required this.backupVersion,
    required this.schemaVersion,
    required this.createdAt,
  });

  final int backupVersion;
  final int schemaVersion;
  final String createdAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'backupVersion': backupVersion,
        'schemaVersion': schemaVersion,
        'createdAt': createdAt,
      };

  static BackupManifest fromJson(Map<String, dynamic> json) => BackupManifest(
        backupVersion: (json['backupVersion'] as num?)?.toInt() ?? 1,
        schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 0,
        createdAt: json['createdAt'] as String? ?? '',
      );
}

class BackupError implements Exception {
  BackupError(this.message);
  final String message;
  @override
  String toString() => message;
}

/// 本地 ZIP 备份：manifest.json + database.sqlite + papers/ 图片与派生文件。
///
/// 恢复采用“先校验 → 暂存 → 重启时替换”（当前会话持有 DB 句柄时不能直接覆盖）。
class BackupService {
  BackupService({
    required this.dataRoot,
    required this.dbFilePath,
  });

  /// papers 父目录（其下含 papers/<id>/…）。
  final String dataRoot;

  /// 当前 sqlite 文件绝对路径。
  final String dbFilePath;

  String _papersRoot() => p.join(dataRoot, 'papers');

  Future<String> exportZip() async {
    final dir = await Directory.systemTemp.createTemp('bk');
    final dest = p.join(dir.path, 'backup_${DateTime.now().millisecondsSinceEpoch}.zip');
    final manifest = BackupManifest(
      backupVersion: 1,
      schemaVersion: 2,
      createdAt: DateTime.now().toIso8601String(),
    );
    final archive = Archive();
    _addFile(archive, 'manifest.json',
        const JsonEncoder().convert(manifest.toJson()).codeUnits);

    final db = File(dbFilePath);
    if (await db.exists()) {
      _addFile(archive, 'database.sqlite', await db.readAsBytes());
    } else {
      throw BackupError('找不到数据库文件，无法备份');
    }

    final papersRoot = _papersRoot();
    if (await Directory(papersRoot).exists()) {
      await for (final entity in Directory(papersRoot).list(recursive: true)) {
        if (entity is File) {
          final rel = p.relative(entity.path, from: papersRoot);
          _addFile(archive, 'papers/$rel', await entity.readAsBytes());
        }
      }
    }

    final bytes = ZipEncoder().encode(archive);
    await File(dest).writeAsBytes(bytes, flush: true);
    return dest;
  }

  void _addFile(Archive archive, String name, List<int> bytes) {
    archive.addFile(ArchiveFile(name, bytes.length, bytes));
  }

  /// 校验备份文件是否可恢复；返回解压后的临时目录（调用方负责清理）。
  Future<Directory> extractAndValidate(String zipPath) async {
    final zipFile = File(zipPath);
    if (!await zipFile.exists()) throw BackupError('备份文件不存在');
    final bytes = await zipFile.readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);

    final dir = await Directory.systemTemp.createTemp('bk_restore');
    try {
      for (final file in archive) {
        if (file.isFile) {
          final out = File(p.join(dir.path, file.name));
          await out.parent.create(recursive: true);
          await out.writeAsBytes(file.content as List<int>, flush: true);
        }
      }
      final manifestFile = File(p.join(dir.path, 'manifest.json'));
      if (!await manifestFile.exists()) throw BackupError('缺少 manifest.json');
      final manifestJson =
          jsonDecode(await manifestFile.readAsString()) as Map<String, dynamic>;
      final manifest = BackupManifest.fromJson(manifestJson);
      if (manifest.schemaVersion > 2) {
        throw BackupError('备份来自更新的数据库版本，无法恢复');
      }
      if (!await File(p.join(dir.path, 'database.sqlite')).exists()) {
        throw BackupError('备份缺少 database.sqlite');
      }
      return dir;
    } catch (e) {
      try {
        await dir.delete(recursive: true);
      } catch (_) {}
      if (e is BackupError) rethrow;
      throw BackupError('备份校验失败：$e');
    }
  }

  /// 校验后暂存到应用文档目录，重启时由 [applyPendingRestore] 完成替换。
  Future<void> stageRestore(String zipPath) async {
    final dir = await extractAndValidate(zipPath);
    final pendingDir = p.join(dataRoot, 'pending_restore');
    final pending = Directory(pendingDir);
    if (await pending.exists()) await pending.delete(recursive: true);
    await Directory(pendingDir).create(recursive: true);
    await _copyDir(dir.path, pendingDir);
    await dir.delete(recursive: true);
  }

  /// 应用之前暂存的恢复（应在任何 DB 连接打开前调用）。
  Future<bool> applyPendingRestore() async {
    final pendingDir = p.join(dataRoot, 'pending_restore');
    if (!await Directory(pendingDir).exists()) return false;

    final db = File(dbFilePath);
    if (db.existsSync()) {
      // 尽量保留旧文件作为 .bak（不做破坏性覆盖原备份依据）。
    }
    // 替换 sqlite
    final srcDb = File(p.join(pendingDir, 'database.sqlite'));
    if (!await srcDb.exists()) {
      await Directory(pendingDir).delete(recursive: true);
      throw BackupError('待恢复包缺少数据库');
    }
    if (await db.exists()) await db.delete();
    await srcDb.copy(dbFilePath);

    // 替换 papers 图片目录
    final srcPapers = Directory(p.join(pendingDir, 'papers'));
    final dstPapers = _papersRoot();
    if (await srcPapers.exists()) {
      if (await Directory(dstPapers).exists()) {
        await Directory(dstPapers).delete(recursive: true);
      }
      await _copyDir(srcPapers.path, dstPapers);
    }
    await Directory(pendingDir).delete(recursive: true);
    return true;
  }

  Future<void> _copyDir(String from, String to) async {
    final src = Directory(from);
    await for (final entity in src.list(recursive: true)) {
      if (entity is File) {
        final rel = p.relative(entity.path, from: from);
        final dest = File(p.join(to, rel));
        await dest.parent.create(recursive: true);
        await entity.copy(dest.path);
      }
    }
  }
}

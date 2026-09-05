import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:smart_wrong_notebook/src/mistake/cleaning/cleaning_engine.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/storage/mistake_image_store.dart';

/// 顶层纯函数：可被 Isolate.run 调度（只捕获可发送的字节/坐标数组）。
Uint8List cleanBasicIsolate(Uint8List bytes) =>
    const CleaningEngine().basicClean(bytes);

Uint8List suppressRegionsIsolate(Uint8List bytes, List<List<double>> regions) =>
    const CleaningEngine().suppressRegions(
      bytes,
      regions
          .map((r) => MaskRegion(
                x: r[0],
                y: r[1],
                width: r[2],
                height: r[3],
              ))
          .toList(),
    );

/// 图片清理/版本服务：产物全部是派生文件，Original 永不修改。
class CleaningService {
  CleaningService({
    required MistakeDatabase db,
    required MistakeImageStore store,
  })  : _db = db,
        _store = store;

  final MistakeDatabase _db;
  final MistakeImageStore _store;

  /// 基础清理（traditional）。返回 BlockVersion id。
  Future<int> cleanTraditional(int blockId) async {
    final block = await _db.blockById(blockId);
    if (block == null) throw StateError('区块不存在');
    final paperId = await _paperIdOf(block);
    final source = block.processedImagePath;
    if (source == null || !await File(source).exists()) {
      throw StateError('区块没有可处理的图片，请先裁剪');
    }
    final bytes = await File(source).readAsBytes();
    final out = await Isolate.run(() => cleanBasicIsolate(bytes));
    final dest = await _store.saveDerived(paperId, out, 'processed', 'jpg');
    return _db.insertBlockVersion(BlockVersionsCompanion.insert(
      blockId: blockId,
      method: 'traditional',
      sourceImagePath: Value(source),
      processedImagePath: Value(dest),
      model: const Value(null),
      verified: const Value(false),
    ));
  }

  /// AI 识别区域 + 本地擦除（aiMaskLocal）。regions=[x,y,w,h] 由 AI 提供。
  Future<int> cleanWithRegions(
    int blockId,
    List<List<double>> regions, {
    String? model,
  }) async {
    if (regions.isEmpty) throw StateError('没有可清理的区域');
    final block = await _db.blockById(blockId);
    if (block == null) throw StateError('区块不存在');
    final paperId = await _paperIdOf(block);
    final source = block.processedImagePath;
    if (source == null || !await File(source).exists()) {
      throw StateError('区块没有可处理的图片，请先裁剪');
    }
    final bytes = await File(source).readAsBytes();
    final coords = regions
        .map((r) => <double>[r[0].clamp(0, 1), r[1].clamp(0, 1), r[2].clamp(0, 1), r[3].clamp(0, 1)])
        .toList();
    final out = await Isolate.run(() => suppressRegionsIsolate(bytes, coords));
    final dest = await _store.saveDerived(paperId, out, 'processed', 'jpg');
    return _db.insertBlockVersion(BlockVersionsCompanion.insert(
      blockId: blockId,
      method: 'aiMaskLocal',
      sourceImagePath: Value(source),
      processedImagePath: Value(dest),
      model: Value(model),
      verified: const Value(false),
    ));
  }

  /// 记录“裁剪原图”为可打印候选版本（original）。
  Future<int> addOriginalVersion(int blockId) async {
    final block = await _db.blockById(blockId);
    if (block == null) throw StateError('区块不存在');
    final source = block.processedImagePath;
    if (source == null || !await File(source).exists()) {
      throw StateError('区块没有可处理的图片，请先裁剪');
    }
    return _db.insertBlockVersion(BlockVersionsCompanion.insert(
      blockId: blockId,
      method: 'original',
      sourceImagePath: Value(source),
      processedImagePath: Value(source),
      model: const Value(null),
      verified: const Value(true),
    ));
  }

  /// 区块“打印用”图片路径：useForPrint 版本优先，其次最近版本，最后原裁剪图。
  Future<String?> printablePathOf(int blockId) async {
    final versions = await _db.watchBlockVersions(blockId).first;
    for (final v in versions) {
      if (v.useForPrint && v.processedImagePath != null) {
        return v.processedImagePath;
      }
    }
    if (versions.isNotEmpty && versions.first.processedImagePath != null) {
      return versions.first.processedImagePath;
    }
    final block = await _db.blockById(blockId);
    return block?.processedImagePath;
  }

  Future<int> _paperIdOf(Block block) async {
    final page = await _db.pageById(block.pageId);
    return page?.paperId ?? 0;
  }

  Future<String> saveManualMask(int paperId, Uint8List pngBytes) =>
      _store.saveDerived(paperId, pngBytes, 'masks', 'png');
}

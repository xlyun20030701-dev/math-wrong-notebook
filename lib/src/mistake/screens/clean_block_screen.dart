// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_wrong_notebook/src/mistake/cleaning/cleaning_service.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/providers.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/mask_editor_screen.dart';

const Map<String, String> versionMethodLabels = <String, String>{
  'original': '原图',
  'traditional': '基础清理',
  'aiMaskLocal': 'AI 识别+本地擦除',
  'aiEdit': 'AI 重绘净化（实验）',
  'manual': '手动橡皮擦',
};

/// 单 Block 图片清理与版本管理页。
class CleanBlockScreen extends ConsumerStatefulWidget {
  const CleanBlockScreen({required this.blockId, super.key});

  final int blockId;

  @override
  ConsumerState<CleanBlockScreen> createState() => _CleanBlockScreenState();
}

class _CleanBlockScreenState extends ConsumerState<CleanBlockScreen> {
  bool _busy = false;
  bool _showOriginal = false;

  CleaningService get _svc => ref.read(cleaningServiceProvider);

  @override
  Widget build(BuildContext context) {
    final versions = ref.watch(watchBlockVersionsProvider(widget.blockId));
    final block =
        ref.watch(watchBlockByIdProvider(widget.blockId)).value;
    if (block == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('图片清理')),
        body: const Center(child: Text('区块不存在')),
      );
    }
    final list = versions.value ?? const <BlockVersion>[];
    final currentPath = list.where((v) => v.useForPrint).isNotEmpty
        ? list.firstWhere((v) => v.useForPrint).processedImagePath
        : (list.isNotEmpty
            ? list.first.processedImagePath
            : block.processedImagePath);

    return Scaffold(
      appBar: AppBar(
        title: const Text('图片清理'),
        actions: <Widget>[
          IconButton(
            tooltip: '原图 / 处理图切换',
            onPressed: () => setState(() => _showOriginal = !_showOriginal),
            icon: Icon(_showOriginal
                ? CupertinoIcons.checkmark_alt
                : CupertinoIcons.eye),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: <Widget>[
          if (currentPath != null)
            AspectRatio(
              aspectRatio: _aspectOf(currentPath),
              child: Container(
                color: Colors.black12,
                child: Image.file(
                  File(_showOriginal
                      ? block.processedImagePath ?? currentPath
                      : currentPath),
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Center(
                      child: Icon(CupertinoIcons.photo)),
                ),
              ),
            ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: <Widget>[
              FilledButton.icon(
                onPressed: _busy ? null : () => _clean(block),
                icon: const Icon(CupertinoIcons.wand_stars),
                label: const Text('基础清理'),
              ),
              OutlinedButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => MaskEditorScreen(blockId: block.id),
                  ),
                ),
                icon: const Icon(CupertinoIcons.paintbrush),
                label: const Text('手动橡皮擦'),
              ),
              OutlinedButton.icon(
                onPressed: _busy ? null : () => _aiClean(block),
                icon: const Icon(CupertinoIcons.sparkles),
                label: const Text('AI 识别+本地擦除'),
              ),
              OutlinedButton.icon(
                onPressed: () => _note(
                    'AI 重绘净化（实验）需要图像编辑能力返回整张重绘图，'
                    '且必须核对数字/公式/图形后才能使用；尚未接线。'),
                icon: const Icon(CupertinoIcons.info_circle),
                label: const Text('AI 重绘（待接线）'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('版本（点选设为打印图，核对后可标记 verified）',
              style: Theme.of(context).textTheme.titleSmall),
          for (final v in list)
            Card(
              child: ListTile(
                title: Text(versionMethodLabels[v.method] ?? v.method),
                subtitle: Text(
                    '${v.model ?? ''} ${v.verified ? '✓已核对' : '未核对'}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Checkbox(
                      value: v.useForPrint,
                      onChanged: _busy
                          ? null
                          : (val) async {
                              if (val == true) {
                                await ref
                                    .read(mistakeDbProvider)
                                    .setPrintVersion(widget.blockId, v.id);
                              }
                            },
                    ),
                    const Text('打印'),
                    IconButton(
                      tooltip: '标记已核对',
                      icon: Icon(
                        v.verified
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                      ),
                      onPressed: _busy
                          ? null
                          : () async {
                              await ref
                                  .read(mistakeDbProvider)
                                  .setBlockVersionVerified(
                                      v.id, !v.verified);
                            },
                    ),
                  ],
                ),
              ),
            ),
          if (list.isEmpty)
            Text('暂无处理版本，原图始终保留。',
                style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  double _aspectOf(String path) {
    // 简单兜底，避免 Image.file 未加载时报 0。
    return 1.4;
  }

  Future<void> _clean(Block block) async {
    setState(() => _busy = true);
    try {
      await _svc.cleanTraditional(block.id);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('清理失败：$e')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _note(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _aiClean(Block block) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AI 识别+本地擦除'),
        content: const Text('将调用 OpenAI API 定位手写/批注区域，再由本地算法清理。'
            '原图永久保留，结果需人工核对后再设为打印图。是否继续？'),
        actions: <Widget>[
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('继续')),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    setState(() => _busy = true);
    try {
      final regions =
          await ref.read(aiActionsProvider).detectHandwriting(block.id);
      await _svc.cleanWithRegions(block.id, regions);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('已生成 ${regions.length} 个区域的清理版本，请人工核对')));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('失败：$e')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}

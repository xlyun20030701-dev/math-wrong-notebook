import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_wrong_notebook/src/mistake/cleaning/cleaning_service.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/providers.dart';

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
                onPressed: () => _note(
                    'AI 识别手写区域 + 本地擦除 与 AI 重绘净化需要视觉模型返回掩码/编辑图，'
                    '将在验证后接线；原图永久保留。'),
                icon: const Icon(CupertinoIcons.info_circle),
                label: const Text('AI 去手写（待接线）'),
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
}

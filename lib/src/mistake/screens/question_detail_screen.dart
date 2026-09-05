import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/labels.dart';
import 'package:smart_wrong_notebook/src/mistake/providers.dart';

/// 错题详情：Block 预览、拖动排序、删除、编辑元信息。
class QuestionDetailScreen extends ConsumerStatefulWidget {
  const QuestionDetailScreen({required this.questionId, super.key});

  final int questionId;

  @override
  ConsumerState<QuestionDetailScreen> createState() =>
      _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends ConsumerState<QuestionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final qAsync = ref.watch(questionByIdProvider(widget.questionId));
    final blocksAsync =
        ref.watch(watchBlocksOfQuestionProvider(widget.questionId));

    return qAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('加载失败：$e'))),
      data: (question) {
        if (question == null) {
          return const Scaffold(body: Center(child: Text('错题不存在')));
        }
        final blocks = blocksAsync.value ?? const <Block>[];
        return Scaffold(
          appBar: AppBar(
            title: Text(questionDisplayLabel(question),
                maxLines: 1, overflow: TextOverflow.ellipsis),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (v) {
                  if (v == 'edit') _editMeta(context, question);
                  if (v == 'delete') _deleteQuestion(question);
                },
                itemBuilder: (_) => const <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(value: 'edit', child: Text('编辑题号/标题')),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Text('删除错题', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
          body: blocks.isEmpty
              ? const Center(child: Text('还没有区块。\n回到试卷页框选区域加入此错题。'))
              : ReorderableListView.builder(
                  padding: const EdgeInsets.all(12),
                  buildDefaultDragHandles: false,
                  itemCount: blocks.length,
                  onReorderItem: (oldIndex, newIndex) =>
                      _reorder(blocks, oldIndex, newIndex),
                  itemBuilder: (context, index) {
                    final block = blocks[index];
                    return Card(
                      key: ValueKey<int>(block.id),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: ReorderableDragStartListener(
                          index: index,
                          child: const Icon(CupertinoIcons.bars),
                        ),
                        title: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: SizedBox(
                            width: 120,
                            height: 70,
                            child: block.processedImagePath != null
                                ? Image.file(
                                    File(block.processedImagePath!),
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) => const Icon(
                                        CupertinoIcons.photo, size: 30),
                                  )
                                : const Icon(CupertinoIcons.photo, size: 30),
                          ),
                        ),
                        subtitle: Text(
                          '${blockTypeLabels[block.blockType] ?? block.blockType} · 位置 ${index + 1}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: IconButton(
                          tooltip: '删除区块',
                          icon: const Icon(CupertinoIcons.trash),
                          onPressed: () => _deleteBlock(block),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  Future<void> _reorder(List<Block> blocks, int oldIndex, int newIndex) async {
    final updated = List<Block>.of(blocks);
    final moved = updated.removeAt(oldIndex);
    updated.insert(newIndex, moved);
    await ref
        .read(mistakeDbProvider)
        .reorderBlocks(widget.questionId, updated.map((b) => b.id).toList());
  }

  Future<void> _deleteBlock(Block block) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除区块'),
        content: Text('删除「${blockTypeLabels[block.blockType] ?? block.blockType}」区块？'),
        actions: <Widget>[
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('取消')),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    await ref.read(mistakeImageStoreProvider).deleteImage(block.processedImagePath);
    await ref.read(mistakeDbProvider).deleteBlock(block.id);
  }

  Future<void> _deleteQuestion(Question question) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除错题'),
        content: Text('确定删除「${questionDisplayLabel(question)}」？'),
        actions: <Widget>[
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('取消')),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    final blocks =
        await ref.read(mistakeDbProvider).blocksOfQuestion(question.id);
    final store = ref.read(mistakeImageStoreProvider);
    for (final b in blocks) {
      await store.deleteImage(b.processedImagePath);
    }
    await ref.read(mistakeDbProvider).deleteQuestion(question.id);
    if (mounted) context.pop();
  }

  Future<void> _editMeta(BuildContext context, Question question) async {
    final number = TextEditingController(text: question.originalQuestionNumber ?? '');
    final title = TextEditingController(text: question.title ?? '');
    final kp = TextEditingController(text: question.knowledgePoint ?? '');
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('编辑错题'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(controller: number,
                  decoration: const InputDecoration(labelText: '原题号')),
              TextField(controller: title,
                  decoration: const InputDecoration(labelText: '标题')),
              TextField(controller: kp,
                  decoration: const InputDecoration(labelText: '知识点')),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('保存')),
        ],
      ),
    );
    if (result != true || !mounted) return;
    await ref.read(mistakeDbProvider).updateQuestion(
          question.id,
          QuestionsCompanion(
            originalQuestionNumber:
                Value(number.text.trim().isEmpty ? null : number.text.trim()),
            title: Value(title.text.trim().isEmpty ? null : title.text.trim()),
            knowledgePoint:
                Value(kp.text.trim().isEmpty ? null : kp.text.trim()),
          ),
        );
  }
}

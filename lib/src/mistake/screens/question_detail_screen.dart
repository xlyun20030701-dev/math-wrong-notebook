// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_wrong_notebook/src/mistake/ai/ai_actions.dart';
import 'package:smart_wrong_notebook/src/mistake/ai/ai_chat_client.dart';
import 'package:smart_wrong_notebook/src/mistake/ai/ai_models.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/db/tables.dart';
import 'package:smart_wrong_notebook/src/mistake/labels.dart';
import 'package:smart_wrong_notebook/src/mistake/providers.dart';


const Map<String, String> errorTypeLabels = <String, String>{
  'calculation': '计算错误',
  'concept': '概念不清',
  'sign': '符号错误',
  'reading': '审题不清',
  'formula': '公式错误',
  'careless': '粗心',
  'unknown': '待确认',
};

const Map<String, String> difficultyLabels = <String, String>{
  'easy': '基础',
  'same': '同等',
  'hard': '提高',
  '基础': '基础',
  '中等': '中等',
  '困难': '困难',
};

class QuestionDetailScreen extends ConsumerStatefulWidget {
  const QuestionDetailScreen({required this.questionId, super.key});

  final int questionId;

  @override
  ConsumerState<QuestionDetailScreen> createState() =>
      _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends ConsumerState<QuestionDetailScreen> {
  bool _busy = false;

  Future<AiActions> get _ai async => ref.read(aiActionsProvider);

  @override
  Widget build(BuildContext context) {
    final qAsync = ref.watch(questionByIdProvider(widget.questionId));
    final understanding = ref.watch(watchUnderstandingProvider(widget.questionId));
    final mistake = ref.watch(watchMistakeProvider(widget.questionId));
    final exercises =
        ref.watch(watchGeneratedOfQuestionProvider(widget.questionId));
    return qAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('加载失败：$e'))),
      data: (question) {
        if (question == null) {
          return const Scaffold(body: Center(child: Text('错题不存在')));
        }
        return _build(
          context,
          question,
          understanding.value,
          mistake.value,
          exercises.value ?? const <GeneratedExercise>[],
        );
      },
    );
  }

  Widget _build(BuildContext context, Question q, AiUnderstanding? u,
      AiMistake? m, List<GeneratedExercise> exercises) {
    return Scaffold(
      appBar: AppBar(
        title: Text(questionDisplayLabel(q), maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: <Widget>[
          IconButton(
            tooltip: '加入打印',
            icon: const Icon(CupertinoIcons.printer),
            onPressed: _busy ? null : () => _addToPrint(q),
          ),
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'edit') _editMeta(q);
              if (v == 'delete') _deleteQuestion(q);
            },
            itemBuilder: (_) => const <PopupMenuEntry<String>>[
              PopupMenuItem<String>(value: 'edit', child: Text('编辑题目信息')),
              PopupMenuItem<String>(
                value: 'delete',
                child: Text('删除错题', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: <Widget>[
          _metaChips(q),
          const SizedBox(height: 8),
          _aiButtons(q),
          const SizedBox(height: 8),
          if (u != null && u.status == 'ok') _understandingCard(u),
          if (m != null && m.status == 'ok') _mistakeCard(m),
          if (exercises.isNotEmpty) _exercisesCard(exercises),
          const Divider(height: 24),
          Text('区域块（拖动排序，点类型可改）', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 6),
          _BlockList(question: q, onChanged: () {}),
        ],
      ),
    );
  }

  Widget _metaChips(Question q) {
    final chips = <Widget>[
      if ((q.knowledgePoint ?? '').isNotEmpty) _chip('知识点 ${q.knowledgePoint}'),
      if ((q.questionType ?? '').isNotEmpty) _chip('题型 ${q.questionType}'),
      if ((q.difficulty ?? '').isNotEmpty) _chip('难度 ${q.difficulty}'),
      if ((q.note ?? '').isNotEmpty) _chip('备注 ${q.note}'),
    ];
    if (chips.isEmpty) chips.add(_chip('暂无元信息，点右上角“编辑题目信息”'));
    return Wrap(spacing: 6, runSpacing: 6, children: chips);
  }

  Widget _chip(String text) => Chip(label: Text(text, style: const TextStyle(fontSize: 12)));

  Widget _aiButtons(Question q) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: FilledButton.icon(
                onPressed: _busy ? null : () => _run(q, 'understand'),
                icon: const Icon(CupertinoIcons.sparkles),
                label: const Text('AI 识题'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FilledButton.icon(
                onPressed: _busy ? null : () => _run(q, 'mistake'),
                icon: const Icon(CupertinoIcons.exclamationmark_circle),
                label: const Text('AI 分析错因'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _busy ? null : () => _run(q, 'exercise'),
                icon: const Icon(CupertinoIcons.tray_full),
                label: const Text('举一反三'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _busy ? null : () => _cleanMenu(q),
                icon: const Icon(CupertinoIcons.wand_stars),
                label: const Text('图片清理'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _run(Question q, String kind) async {
    setState(() => _busy = true);
    try {
      final actions = await _ai;
      if (kind == 'understand') {
        await actions.understand(q.id);
      } else if (kind == 'mistake') {
        await actions.analyzeMistake(q.id);
      } else if (kind == 'exercise') {
        final diff = await _askExerciseOptions();
        if (diff != null) {
          await actions.generateExercises(q.id,
              difficulty: diff.$1, count: diff.$2);
        }
      }
    } on AiApiException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('操作失败：$e')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<(String, int)?> _askExerciseOptions() async {
    var diff = 'same';
    var count = 3;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, set) => AlertDialog(
          title: const Text('举一反三'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SegmentedButton<String>(
                showSelectedIcon: false,
                segments: const <ButtonSegment<String>>[
                  ButtonSegment<String>(value: 'easy', label: Text('基础')),
                  ButtonSegment<String>(value: 'same', label: Text('同等')),
                  ButtonSegment<String>(value: 'hard', label: Text('提高')),
                ],
                selected: <String>{diff},
                onSelectionChanged: (s) => set(() => diff = s.first),
              ),
              const SizedBox(height: 8),
              SegmentedButton<int>(
                showSelectedIcon: false,
                segments: const <ButtonSegment<int>>[
                  ButtonSegment<int>(value: 1, label: Text('1 题')),
                  ButtonSegment<int>(value: 3, label: Text('3 题')),
                  ButtonSegment<int>(value: 5, label: Text('5 题')),
                ],
                selected: <int>{count},
                onSelectionChanged: (s) => set(() => count = s.first),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('取消')),
            FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('生成')),
          ],
        ),
      ),
    );
    return ok == true ? (diff, count) : null;
  }

  Widget _understandingCard(AiUnderstanding u) => Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('AI 识题 · ${u.model ?? ''}',
                  style: Theme.of(context).textTheme.labelLarge),
              if (u.summary != null) Text(u.summary!),
              if (u.answer != null) Text('答案：${u.answer}'),
              if (u.solution != null) Text('解析：${u.solution}'),
              if (u.approach != null) Text('思路：${u.approach}'),
            ],
          ),
        ),
      );

  Widget _mistakeCard(AiMistake m) => Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('AI 错因分析',
                  style: Theme.of(context).textTheme.labelLarge),
              Text('类型：${errorTypeLabels[m.errorType] ?? m.errorType}'),
              if (m.reason != null) Text('原因：${m.reason}'),
              if (m.errorStep != null) Text('错误步骤：${m.errorStep}'),
              if (m.reviewSuggestion != null)
                Text('建议：${m.reviewSuggestion}'),
            ],
          ),
        ),
      );

  Widget _exercisesCard(List<GeneratedExercise> list) => Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('举一反三（${list.length}）',
                  style: Theme.of(context).textTheme.labelLarge),
              for (var i = 0; i < list.length; i++)
                ListTile(
                  dense: true,
                  title: Text(AiExerciseFields.fromStoredJson(list[i].contentJson)?.question ?? ''),
                  subtitle: Text('难度：${difficultyLabels[list[i].difficulty] ?? list[i].difficulty}'),
                  trailing: IconButton(
                    icon: const Icon(CupertinoIcons.printer, size: 18),
                    onPressed: () => _addExerciseToPrint(list[i]),
                  ),
                ),
            ],
          ),
        ),
      );

  Future<void> _cleanMenu(Question q) async {
    final blocks = await ref.read(mistakeDbProvider).blocksOfQuestion(q.id);
    if (blocks.isEmpty) return;
    if (!context.mounted) return;
    context.push('/clean/${blocks.first.id}');
  }

  Future<void> _addToPrint(Question q) async {
    final db = ref.read(mistakeDbProvider);
    final exists = await db.printItemExists(questionId: q.id);
    if (exists) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('已在打印列表')));
      return;
    }
    await db.appendPrintItem(PrintItemsCompanion.insert(
      kind: const Value('question'),
      questionId: Value(q.id),
    ));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已加入打印列表')));
  }

  Future<void> _addExerciseToPrint(GeneratedExercise g) async {
    final db = ref.read(mistakeDbProvider);
    final exists = await db.printItemExists(exerciseId: g.id);
    if (exists) return;
    await db.appendPrintItem(PrintItemsCompanion.insert(
      kind: const Value('exercise'),
      exerciseId: Value(g.id),
      answerSpaceMm: const Value(60),
    ));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('已加入打印列表')));
    }
  }

  Future<void> _editMeta(Question q) async {
    final number = TextEditingController(text: q.originalQuestionNumber ?? '');
    final title = TextEditingController(text: q.title ?? '');
    final kp = TextEditingController(text: q.knowledgePoint ?? '');
    final type = TextEditingController(text: q.questionType ?? '');
    final diff = TextEditingController(text: q.difficulty ?? '');
    final note = TextEditingController(text: q.note ?? '');
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('编辑题目信息'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(controller: number, decoration: const InputDecoration(labelText: '原题号')),
              TextField(controller: title, decoration: const InputDecoration(labelText: '标题')),
              TextField(controller: kp, decoration: const InputDecoration(labelText: '知识点')),
              TextField(controller: type, decoration: const InputDecoration(labelText: '题型')),
              TextField(controller: diff, decoration: const InputDecoration(labelText: '难度')),
              TextField(controller: note, decoration: const InputDecoration(labelText: '备注'), maxLines: 2),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('取消')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('保存')),
        ],
      ),
    );
    if (saved != true || !mounted) return;
    await ref.read(mistakeDbProvider).updateQuestion(
          q.id,
          QuestionsCompanion(
            originalQuestionNumber: Value(number.text.trim().isEmpty ? null : number.text.trim()),
            title: Value(title.text.trim().isEmpty ? null : title.text.trim()),
            knowledgePoint: Value(kp.text.trim().isEmpty ? null : kp.text.trim()),
            questionType: Value(type.text.trim().isEmpty ? null : type.text.trim()),
            difficulty: Value(diff.text.trim().isEmpty ? null : diff.text.trim()),
            note: Value(note.text.trim().isEmpty ? null : note.text.trim()),
          ),
        );
  }

  Future<void> _deleteQuestion(Question question) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除错题'),
        content: Text('确定删除「${questionDisplayLabel(question)}」？'),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('取消')),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    final db = ref.read(mistakeDbProvider);
    final blocks = await db.blocksOfQuestion(question.id);
    final store = ref.read(mistakeImageStoreProvider);
    for (final b in blocks) {
      await store.deleteImage(b.processedImagePath);
    }
    await db.deleteQuestion(question.id);
    if (mounted) context.pop();
  }
}

class _BlockList extends ConsumerWidget {
  const _BlockList({required this.question, required this.onChanged});

  final Question question;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blocks = ref.watch(watchBlocksOfQuestionProvider(question.id));
    final data = blocks.value ?? const <Block>[];
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: false,
      itemCount: data.length,
      onReorderItem: (a, b) async {
        final updated = List<Block>.of(data);
        final moved = updated.removeAt(a);
        updated.insert(b, moved);
        await ref
            .read(mistakeDbProvider)
            .reorderBlocks(question.id, updated.map((x) => x.id).toList());
      },
      itemBuilder: (context, index) {
        final block = data[index];
        return Card(
          key: ValueKey<int>(block.id),
          margin: const EdgeInsets.symmetric(vertical: 3),
          child: ListTile(
            dense: true,
            leading: ReorderableDragStartListener(
              index: index,
              child: const Icon(CupertinoIcons.bars, size: 18),
            ),
            title: SizedBox(
              height: 60,
              child: block.processedImagePath == null
                  ? const Icon(CupertinoIcons.photo)
                  : Image.file(File(block.processedImagePath!),
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                          const Icon(CupertinoIcons.photo)),
            ),
            subtitle: Text('${blockTypeLabels[block.blockType] ?? block.blockType} · ${index + 1}'),
            onTap: () => _changeType(context, ref, block),
            trailing: IconButton(
              icon: const Icon(CupertinoIcons.trash, size: 18),
              onPressed: () async {
                await ref
                    .read(mistakeImageStoreProvider)
                    .deleteImage(block.processedImagePath);
                await ref.read(mistakeDbProvider).deleteBlock(block.id);
              },
            ),
          ),
        );
      },
    );
  }

  void _changeType(BuildContext context, WidgetRef ref, Block block) async {
    final type = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('修改区块类型'),
        children: <Widget>[
          for (final t in kBlockTypes)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, t),
              child: Text(blockTypeLabels[t] ?? t),
            ),
        ],
      ),
    );
    if (type == null) return;
    await ref.read(mistakeDbProvider).updateBlockType(block.id, type);
  }
}



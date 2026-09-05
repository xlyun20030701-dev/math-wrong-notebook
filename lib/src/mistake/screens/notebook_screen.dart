import 'package:drift/drift.dart' show Value;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/providers.dart';

/// 错题本：搜索 + 筛选 + 多选加入打印。
class NotebookScreen extends ConsumerStatefulWidget {
  const NotebookScreen({super.key});

  @override
  ConsumerState<NotebookScreen> createState() => _NotebookScreenState();
}

class _NotebookScreenState extends ConsumerState<NotebookScreen> {
  String _query = '';
  final Set<int> _selected = <int>{};

  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(watchAllQuestionsProvider);
    final papers = ref.watch(watchPapersProvider);
    final q = _query.trim().toLowerCase();
    final data = questions.value ?? const <Question>[];
    final filtered = data.where((x) {
      if (q.isEmpty) return true;
      final hay = <String>[
        x.originalQuestionNumber ?? '',
        x.title ?? '',
        x.knowledgePoint ?? '',
        x.questionType ?? '',
        x.difficulty ?? '',
        x.note ?? '',
      ].join(' ').toLowerCase();
      return hay.contains(q);
    }).toList();

    final titleById = <int, String>{
      for (final p in papers.value ?? const <Paper>[])
        p.id: p.title,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('错题本'),
        actions: <Widget>[
          IconButton(
            tooltip: '统计',
            icon: const Icon(CupertinoIcons.chart_bar),
            onPressed: _showStats,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(CupertinoIcons.search),
                hintText: '搜索题号 / 标题 / 知识点 / 题型',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('没有错题'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
                    itemCount: filtered.length,
                    itemBuilder: (context, i) {
                      final x = filtered[i];
                      final sel = _selected.contains(x.id);
                      return Card(
                        child: ListTile(
                          onTap: () => context.push('/question/${x.id}'),
                          leading: Checkbox(
                            value: sel,
                            onChanged: (v) => setState(() {
                              if (v == true) {
                                _selected.add(x.id);
                              } else {
                                _selected.remove(x.id);
                              }
                            }),
                          ),
                          title: Text(_label(x),
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                          subtitle: Text(
                            [
                              titleById[x.paperId] ?? '',
                              if (x.knowledgePoint != null)
                                x.knowledgePoint!,
                              '${_blockCount(x.id)} 块',
                            ].where((s) => s.isNotEmpty).join(' · '),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: sel
                              ? const Icon(CupertinoIcons.checkmark_circle_fill,
                                  color: Colors.green)
                              : const Icon(CupertinoIcons.chevron_right),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _selected.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: FilledButton.icon(
                  onPressed: () => _addSelectedToPrint(),
                  icon: const Icon(CupertinoIcons.printer),
                  label: Text('加入打印（${_selected.length}）'),
                ),
              ),
            ),
    );
  }

  String _label(Question x) {
    if ((x.originalQuestionNumber ?? '').isNotEmpty) {
      return 'Q${x.originalQuestionNumber}'
          '${x.title == null || x.title!.isEmpty ? '' : ' ${x.title}'}';
    }
    return x.title ?? '未命名错题';
  }

  int _blockCount(int id) => ref
          .read(watchBlocksOfQuestionProvider(id))
          .value
          ?.length ??
      0;

  Future<void> _showStats() async {
    final db = ref.read(mistakeDbProvider);
    final qs = ref.read(watchAllQuestionsProvider).value ?? const <Question>[];
    final kpCount = <String, int>{};
    final typeCount = <String, int>{};
    for (final q in qs) {
      final kp = q.knowledgePoint;
      if (kp != null && kp.isNotEmpty) {
        kpCount[kp] = (kpCount[kp] ?? 0) + 1;
      }
      final qt = q.questionType;
      if (qt != null && qt.isNotEmpty) {
        typeCount[qt] = (typeCount[qt] ?? 0) + 1;
      }
    }
    final mistakes = await (db.select(db.aiMistakes)).get();
    final errorCount = <String, int>{};
    for (final m in mistakes) {
      if (m.status != 'ok' || m.errorType == null) continue;
      errorCount[m.errorType!] = (errorCount[m.errorType] ?? 0) + 1;
    }
    if (!mounted) return;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('统计'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _group('知识点', kpCount),
              const SizedBox(height: 8),
              _group('题型', typeCount),
              const SizedBox(height: 8),
              _group('错因', errorCount,
                  labelMap: const <String, String>{
                    'calculation': '计算',
                    'concept': '概念',
                    'sign': '符号',
                    'reading': '审题',
                    'formula': '公式',
                    'careless': '粗心',
                    'unknown': '待确认',
                  }),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('关闭')),
        ],
      ),
    );
  }

  Widget _group(String title, Map<String, int> counts,
      {Map<String, String>? labelMap}) {
    final entries = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    if (entries.isEmpty) {
      return Text('$title：暂无');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: <Widget>[
            for (final e in entries.take(12))
              Chip(
                visualDensity: VisualDensity.compact,
                label: Text(
                    '${labelMap?[e.key] ?? e.key} ${e.value}',
                    style: const TextStyle(fontSize: 12)),
              ),
          ],
        ),
      ],
    );
  }

  Future<void> _addSelectedToPrint() async {
    final db = ref.read(mistakeDbProvider);
    var added = 0;
    for (final id in _selected.toList()) {
      final exists = await db.printItemExists(questionId: id);
      if (!exists) {
        await db.appendPrintItem(PrintItemsCompanion.insert(
          kind: const Value<String>('question'),
          questionId: Value(id),
        ));
        added++;
      }
    }
    if (!mounted) return;
    setState(() => _selected.clear());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已加入 $added 道错题到打印列表')),
    );
  }
}


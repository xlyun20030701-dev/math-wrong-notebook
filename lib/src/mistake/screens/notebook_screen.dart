import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/providers.dart';

/// 错题本：全部错题列表。
class NotebookScreen extends ConsumerWidget {
  const NotebookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(watchAllQuestionsProvider);
    final papers = ref.watch(watchPapersProvider);
    final paperTitles = <int, String>{};
    final paperList = papers.value ?? const <Paper>[];
    for (final p in paperList) {
      paperTitles[p.id] = p.title;
    }
    return Scaffold(
      appBar: AppBar(title: const Text('错题本')),
      body: questions.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('加载失败：$e')),
        data: (list) {
          if (list.isEmpty) {
            return const Center(child: Text('还没有错题。\n先在试卷页面框选错题区域。'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: list.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, i) {
              final q = list[i];
              return Card(
                child: ListTile(
                  onTap: () => context.push('/question/${q.id}'),
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    child: Text(
                      q.originalQuestionNumber ?? (q.title?.isNotEmpty == true ? '题' : '?'),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  title: Text(
                    q.title?.isNotEmpty == true ? q.title! : (q.originalQuestionNumber != null ? '第 ${q.originalQuestionNumber} 题' : '未命名错题'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (paperTitles[q.paperId] != null)
                        Text(paperTitles[q.paperId]!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall),
                      _BlockCountText(questionId: q.id),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _BlockCountText extends ConsumerWidget {
  const _BlockCountText({required this.questionId});

  final int questionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref
        .watch(watchBlocksOfQuestionProvider(questionId))
        .maybeWhen(data: (b) => b.length, orElse: () => 0);
    return Text('$count 个区域块', style: Theme.of(context).textTheme.bodySmall);
  }
}

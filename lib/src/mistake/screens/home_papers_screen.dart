import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/providers.dart';

/// 首页：试卷（Paper）列表。
class HomePapersScreen extends ConsumerWidget {
  const HomePapersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final papers = ref.watch(watchPapersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('试卷'),
        actions: <Widget>[
          IconButton(
            tooltip: '错题本',
            icon: const Icon(CupertinoIcons.book),
            onPressed: () => context.go('/notebook'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateSheet(context, ref),
        icon: const Icon(CupertinoIcons.add),
        label: const Text('新建试卷'),
      ),
      body: papers.when(
        data: (list) => list.isEmpty
            ? const _EmptyHint()
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 88),
                itemCount: list.length,
                itemBuilder: (context, i) => _PaperCard(
                  key: ValueKey<int>(list[i].id),
                  paper: list[i],
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('加载失败：$e')),
      ),
    );
  }

  Future<void> _showCreateSheet(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('新建试卷', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: '试卷名称',
                hintText: '例如：期中考试 / 数学周测 3',
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: const Text('创建'),
            ),
          ],
        ),
      ),
    );
    if (result == null || result.isEmpty || !context.mounted) return;
    final id = await ref.read(mistakeDbProvider).insertPaper(title: result);
    if (!context.mounted) return;
    context.push('/papers/$id');
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(CupertinoIcons.doc_plaintext, size: 64),
            const SizedBox(height: 12),
            const Text('还没有试卷'),
            const SizedBox(height: 6),
            Text(
              '点击右下角“新建试卷”，然后拍摄或导入试卷照片。',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _PaperCard extends ConsumerWidget {
  const _PaperCard({required this.paper, super.key});

  final Paper paper;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageCount = ref
        .watch(watchPagesOfPaperProvider(paper.id))
        .maybeWhen(data: (p) => p.length, orElse: () => 0);
    final questionCount = ref
        .watch(watchQuestionsOfPaperProvider(paper.id))
        .maybeWhen(data: (q) => q.length, orElse: () => 0);

    final sub = <String>[
      if ((paper.subject ?? '').isNotEmpty) paper.subject!,
      if (paper.school != null && paper.school!.isNotEmpty) paper.school!,
      if (paper.grade != null && paper.grade!.isNotEmpty) paper.grade!,
    ].join(' · ');

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: () => context.push('/papers/${paper.id}'),
        title: Text(paper.title,
            maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          '${sub.isEmpty ? '' : '$sub\n'}$pageCount 张照片 · $questionCount 道错题',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'delete') {
              final ok = await _confirmDelete(context);
              if (!ok || !context.mounted) return;
              await ref.read(mistakeDbProvider).deletePaper(paper.id);
              await ref
                  .read(mistakeImageStoreProvider)
                  .deletePaperDirectory(paper.id);
            }
          },
          itemBuilder: (_) => const <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'delete',
              child: Text('删除试卷', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除试卷'),
        content: Text('确定删除「${paper.title}」吗？\n将同时删除其下的页面与错题记录。'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

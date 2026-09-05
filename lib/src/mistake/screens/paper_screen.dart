import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/labels.dart';
import 'package:smart_wrong_notebook/src/mistake/providers.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/page_ai_select_screen.dart';
import 'package:smart_wrong_notebook/src/mistake/services/image_quality.dart';

/// 单张试卷页：页浏览、照片导入、错题篮。
class PaperScreen extends ConsumerStatefulWidget {
  const PaperScreen({required this.paperId, super.key});

  final int paperId;

  @override
  ConsumerState<PaperScreen> createState() => _PaperScreenState();
}

class _PaperScreenState extends ConsumerState<PaperScreen> {
  int _selectedPageIndex = 0;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final paperAsync = ref.watch(paperByIdProvider(widget.paperId));
    final pagesAsync = ref.watch(watchPagesOfPaperProvider(widget.paperId));
    final questionsAsync =
        ref.watch(watchQuestionsOfPaperProvider(widget.paperId));

    return paperAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('加载失败：$e'))),
      data: (paper) {
        if (paper == null) {
          return const Scaffold(body: Center(child: Text('试卷不存在')));
        }
        final pages = pagesAsync.value ?? const <PageRecord>[];
        final basket = questionsAsync.value ?? const <Question>[];
        final safeIndex =
            pages.isEmpty ? 0 : _selectedPageIndex.clamp(0, pages.length - 1);
        final current = pages.isEmpty ? null : pages[safeIndex];

        return Scaffold(
          appBar: AppBar(
            title: Text(paper.title, maxLines: 1, overflow: TextOverflow.ellipsis),
            actions: <Widget>[
              IconButton(
                tooltip: '编辑信息',
                icon: const Icon(CupertinoIcons.pencil),
                onPressed: () => _editPaper(context, paper),
              ),
            ],
          ),
          floatingActionButton: current == null
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    FloatingActionButton.extended(
                      heroTag: 'ai_detect',
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => PageAiSelectScreen(
                            pageId: current.id,
                            paperId: widget.paperId,
                          ),
                        ),
                      ),
                      icon: const Icon(CupertinoIcons.sparkles),
                      label: const Text('AI 框题'),
                    ),
                    const SizedBox(height: 12),
                    FloatingActionButton.extended(
                      heroTag: 'manual_crop',
                      onPressed: () => _openBlockSelect(current),
                      icon: const Icon(CupertinoIcons.crop),
                      label: const Text('框选错题'),
                    ),
                  ],
                ),
          body: Column(
            children: <Widget>[
              _buildAddRow(pages),
              Expanded(child: _buildPagesArea(pages, safeIndex)),
              _buildBasket(basket),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPagesArea(List<PageRecord> pages, int safeIndex) {
    if (pages.isEmpty) {
      return const Center(child: Text('点击上方按钮添加试卷照片'));
    }
    final current = pages[safeIndex];
    return Column(
      children: <Widget>[
        SizedBox(
          height: 96,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: pages.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final page = pages[i];
              final selected = i == safeIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedPageIndex = i),
                child: Container(
                  width: 66,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: SizedBox(
                            width: 62,
                            child: Image.file(
                              File(page.originalImagePath),
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(
                                CupertinoIcons.photo,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text('第${page.pageIndex}页',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => _openBlockSelect(current),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.file(
                      File(current.originalImagePath),
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Center(
                          child: Icon(CupertinoIcons.photo, size: 60)),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '第 ${current.pageIndex} 页 · 点击框选错题区域',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddRow(List<PageRecord> pages) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: <Widget>[
          OutlinedButton.icon(
            onPressed: () => _pickPages(ImageSource.camera),
            icon: const Icon(CupertinoIcons.camera),
            label: const Text('拍照'),
          ),
          const SizedBox(width: 8),
          OutlinedButton.icon(
            onPressed: () => _pickPages(ImageSource.gallery),
            icon: const Icon(CupertinoIcons.photo),
            label: const Text('相册'),
          ),
          const Spacer(),
          if (pages.isNotEmpty)
            Text('共 ${pages.length} 页', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildBasket(List<Question> basket) {
    return Material(
      elevation: 4,
      child: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('错题篮', style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '框选区域后加入已有错题，可跨页连续添加',
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              if (basket.isEmpty)
                Text('还没有错题。框选一块区域即可新建。',
                    style: Theme.of(context).textTheme.bodySmall)
              else
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: basket.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final q = basket[i];
                      return ActionChip(
                        avatar: _BasketBlockCounter(questionId: q.id),
                        label: Text(questionDisplayLabel(q),
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                        onPressed: () => context
                            .push('/question/${q.id}'),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _openBlockSelect(PageRecord page) {
    context.push('/pages/${page.id}/select', extra: widget.paperId);
  }

  Future<void> _pickPages(ImageSource source) async {
    try {
      final List<XFile> files = <XFile>[];
      if (source == ImageSource.camera) {
        final f = await _picker.pickImage(
            source: source, maxWidth: 4096, imageQuality: 92);
        if (f != null) files.add(f);
      } else {
        final picked =
            await _picker.pickMultiImage(maxWidth: 4096, imageQuality: 92);
        files.addAll(picked);
      }
      if (files.isEmpty) return;
      await _processImages(source, files);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('导入照片失败：$e')));
    }
  }

  Future<void> _processImages(
      ImageSource source, List<XFile> files) async {
    final db = ref.read(mistakeDbProvider);
    final store = ref.read(mistakeImageStoreProvider);
    final quality = ref.read(imageQualityProvider);
    // 基于当前最大 pageIndex + 1 起算，避免删除页后出现重复序号。
    var nextIndex = await db.nextPageIndex(widget.paperId);
    var i = 0;
    while (i < files.length) {
      final file = files[i];
      final copied = await store.copyOriginal(widget.paperId, File(file.path));
      ImageQualityReport report;
      try {
        report = await quality.analyze(copied);
      } catch (_) {
        report = const ImageQualityReport(
          width: 0,
          height: 0,
          blurScore: 0,
          exposureScore: 0,
          qualityScore: 0,
          lowResolution: true,
        );
      }
      if (report.isGood || !mounted) {
        await _insertPage(db, copied, nextIndex, report);
        nextIndex++;
        i++;
        continue;
      }
      // 质量不佳：询问用户。
      final action = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('图片质量提醒'),
          content: Text(report.summary),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'skip'),
              child: const Text('跳过'),
            ),
            OutlinedButton(
              onPressed: () => Navigator.pop(context, 'replace'),
              child: Text(source == ImageSource.camera ? '重新拍摄' : '重新选择'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, 'keep'),
              child: const Text('仍然使用'),
            ),
          ],
        ),
      );
      if (action == 'keep') {
        await _insertPage(db, copied, nextIndex, report);
        nextIndex++;
        i++;
      } else if (action == 'replace') {
        final XFile? f =
            await _picker.pickImage(source: source, maxWidth: 4096);
        if (f == null) {
          await store.deleteImage(copied);
          i++;
        } else {
          files[i] = f;
          await store.deleteImage(copied);
        }
      } else {
        await store.deleteImage(copied);
        i++;
      }
    }
    if (!mounted) return;
    final pages = ref.read(watchPagesOfPaperProvider(widget.paperId)).value ??
        const <PageRecord>[];
    setState(() {
      if (pages.isNotEmpty && _selectedPageIndex >= pages.length) {
        _selectedPageIndex = pages.length - 1;
      }
    });
  }

  Future<void> _insertPage(
    MistakeDatabase db,
    String copied,
    int pageNumber,
    ImageQualityReport report,
  ) async {
    await db.insertPage(
      paperId: widget.paperId,
      originalImagePath: copied,
      pageIndex: pageNumber,
      width: report.width == 0 ? null : report.width,
      height: report.height == 0 ? null : report.height,
      qualityScore: report.qualityScore,
      blurScore: report.blurScore,
      exposureScore: report.exposureScore,
    );
  }

  Future<void> _editPaper(BuildContext context, Paper paper) async {
    final title = TextEditingController(text: paper.title);
    final subject = TextEditingController(text: paper.subject ?? '');
    final note = TextEditingController(text: paper.note ?? '');
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('编辑试卷', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            TextField(
                controller: title,
                decoration: const InputDecoration(labelText: '试卷名称')),
            TextField(
                controller: subject,
                decoration: const InputDecoration(labelText: '科目（可选）')),
            TextField(
                controller: note,
                decoration: const InputDecoration(labelText: '备注（可选）'),
                maxLines: 2),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
    if (result != true || !mounted) return;
    await ref.read(mistakeDbProvider).updatePaper(
          paper.id,
          PapersCompanion(
            title: Value(title.text.trim()),
            subject: Value(subject.text.trim().isEmpty
                ? null
                : subject.text.trim()),
            note: Value(note.text.trim().isEmpty ? null : note.text.trim()),
          ),
        );
  }
}

class _BasketBlockCounter extends ConsumerWidget {
  const _BasketBlockCounter({required this.questionId});

  final int questionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref
        .watch(watchBlocksOfQuestionProvider(questionId))
        .maybeWhen(data: (b) => b.length, orElse: () => 0);
    return CircleAvatar(
      radius: 10,
      child: Text('$count',
          style: const TextStyle(fontSize: 11, color: Colors.white)),
    );
  }
}

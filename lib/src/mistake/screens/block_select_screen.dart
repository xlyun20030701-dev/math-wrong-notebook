import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/db/tables.dart';
import 'package:smart_wrong_notebook/src/mistake/labels.dart';
import 'package:smart_wrong_notebook/src/mistake/providers.dart';

import 'dart:io';
import 'dart:math' as math;

/// 在一张 Page 上手动框选矩形区域，并加入（新建/已有）错题。
class BlockSelectScreen extends ConsumerStatefulWidget {
  const BlockSelectScreen({required this.pageId, required this.paperId, super.key});

  final int pageId;
  final int paperId;

  @override
  ConsumerState<BlockSelectScreen> createState() => _BlockSelectScreenState();
}

class _BlockSelectScreenState extends ConsumerState<BlockSelectScreen> {
  Rect? _imageRect; // 在页面坐标系中的选择（规范化在保存时计算）
  Offset? _dragStart;
  Offset? _dragCurrent;
  String _blockType = 'stem';

  @override
  Widget build(BuildContext context) {
    final pageAsync = ref.watch(pageByIdProvider(widget.pageId));
    final basketAsync =
        ref.watch(watchQuestionsOfPaperProvider(widget.paperId));
    return pageAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('加载失败：$e'))),
      data: (page) {
        if (page == null) {
          return const Scaffold(body: Center(child: Text('页面不存在')));
        }
        final basket = basketAsync.value ?? const <Question>[];
        final selection = _selectionNormalized();
        return Scaffold(
          appBar: AppBar(
            title: Text('框选 · 第 ${page.pageIndex} 页'),
            actions: <Widget>[
              if (selection != null)
                IconButton(
                  tooltip: '清除选区',
                  icon: const Icon(CupertinoIcons.clear),
                  onPressed: () => setState(() {
                    _imageRect = null;
                    _dragStart = null;
                    _dragCurrent = null;
                  }),
                ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        for (final type in kBlockTypes)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: ChoiceChip(
                              label: Text(blockTypeLabels[type] ?? type),
                              selected: _blockType == type,
                              onSelected: (_) => setState(() => _blockType = type),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: selection == null
                          ? null
                          : () => _saveToQuestion(selection, basket),
                      icon: const Icon(CupertinoIcons.plus_rectangle_on_rectangle),
                      label: Text(selection == null
                          ? '拖拽框选题目区域'
                          : '保存区块到错题'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: SingleChildScrollView(
                  child: _buildSelectable(
                    context,
                    constraints.biggest,
                    page,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSelectable(
      BuildContext context, Size viewport, PageRecord page) {
    final imageAspect = _pageAspect(page);
    final areaW = math.max(1.0, viewport.width - 24);
    final areaH = math.max(1.0, viewport.height - 200);
    final fitW =
        areaH * imageAspect < areaW ? areaH * imageAspect : areaW;
    final fitH = areaW / imageAspect < areaH ? areaW / imageAspect : areaH;

    return SizedBox(
      width: fitW,
      height: fitH,
      child: GestureDetector(
        onPanStart: (d) => setState(() {
          _dragStart = d.localPosition;
          _dragCurrent = d.localPosition;
        }),
        onPanUpdate: (d) => setState(() {
          _dragCurrent = d.localPosition;
          _imageRect = _normalizedRect(d.localPosition);
        }),
        onPanEnd: (_) {
          _dragStart = null;
          _dragCurrent = null;
        },
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.file(
              File(page.originalImagePath),
              fit: BoxFit.fill,
              errorBuilder: (_, __, ___) => const ColoredBox(
                color: Colors.black12,
                child: Center(child: Icon(CupertinoIcons.photo, size: 64)),
              ),
            ),
            if (_imageRect != null)
              CustomPaint(
                painter: _SelectionPainter(
                  normalized: _imageRect!,
                  active: _dragCurrent != null,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            Positioned(
              left: 6,
              top: 6,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _imageRect == null ? '在此拖拽框选' : '已框选区域，点击下方按钮保存',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _pageAspect(PageRecord page) {
    final w = page.width;
    final h = page.height;
    if (w != null && h != null && w > 0 && h > 0) {
      return w / h;
    }
    return 3.0 / 4.0;
  }

  Rect? _selectionNormalized() {
    final r = _imageRect;
    if (r == null) return null;
    return Rect.fromLTRB(
      r.left.clamp(0.0, 1.0),
      r.top.clamp(0.0, 1.0),
      r.right.clamp(0.0, 1.0),
      r.bottom.clamp(0.0, 1.0),
    );
  }

  Rect _normalizedRect(Offset current) {
    final start = _dragStart ?? current;
    final left = math.min(start.dx, current.dx);
    final top = math.min(start.dy, current.dy);
    final right = math.max(start.dx, current.dx);
    final bottom = math.max(start.dy, current.dy);
    return Rect.fromLTRB(left, top, right, bottom);
  }

  Future<void> _saveToQuestion(
      Rect selection, List<Question> basket) async {
    final picked = await _pickTarget(basket);
    if (picked == null || !mounted) return;
    final db = ref.read(mistakeDbProvider);
    final store = ref.read(mistakeImageStoreProvider);
    final page = await db.pageById(widget.pageId);
    if (page == null) return;
    int questionId;
    try {
      if (picked.isNew) {
        final input = picked.newQuestion!;
        questionId = await db.insertQuestion(
          paperId: widget.paperId,
          originalQuestionNumber: input.number,
          title: input.title,
        );
      } else {
        questionId = picked.existingQuestionId!;
      }
      final cropped = await store.cropBlock(
        widget.paperId,
        page.originalImagePath,
        x: selection.left,
        y: selection.top,
        width: selection.width,
        height: selection.height,
      );
      final existing = await db.blocksOfQuestion(questionId);
      await db.insertBlock(
        questionId: questionId,
        pageId: widget.pageId,
        blockType: picked.blockType,
        x: selection.left,
        y: selection.top,
        width: selection.width,
        height: selection.height,
        sortOrder: existing.length,
        processedImagePath: cropped,
        processingStatus: 'cropped',
      );
      if (!mounted) return;
      final matched = basket.where((q) => q.id == questionId);
      final label = picked.isNew || matched.isEmpty
          ? '新错题'
          : questionDisplayLabel(matched.first);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('已保存到 $label')),
      );
      setState(() {
        _imageRect = null;
        _dragCurrent = null;
        _dragStart = null;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('保存失败：$e')));
    }
  }

  Future<_BlockTarget?> _pickTarget(List<Question> basket) async {
    return showModalBottomSheet<_BlockTarget>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final number = TextEditingController();
        final title = TextEditingController();
        var createMode = false;
        return StatefulBuilder(
          builder: (context, setSheetState) => Padding(
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('加入错题 · ${blockTypeLabels[_blockType] ?? _blockType}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  if (!createMode)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: <Widget>[
                        for (final q in basket)
                          ActionChip(
                            label: Text(
                                '${questionDisplayLabel(q)}（${_blockCount(q.id)}）'),
                            onPressed: () => Navigator.pop(context,
                                _BlockTarget(q.id, _blockType, null)),
                          ),
                        ActionChip(
                          avatar: const Icon(CupertinoIcons.add, size: 16),
                          label: const Text('新建错题'),
                          onPressed: () => setSheetState(() => createMode = true),
                        ),
                        if (basket.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text('本卷还没有错题，请新建。'),
                          ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextField(
                          controller: number,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(labelText: '原题号（如 3、7、11）'),
                        ),
                        TextField(
                          controller: title,
                          decoration: const InputDecoration(labelText: '题干简述（可选）'),
                        ),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: () {
                            final numberText = number.text.trim();
                            if (numberText.isEmpty && title.text.trim().isEmpty) {
                              return;
                            }
                            Navigator.pop(context, _BlockTarget(
                                null, _blockType,
                                NewQuestionInput(
                                    number: numberText.isEmpty
                                        ? null
                                        : numberText,
                                    title: title.text.trim().isEmpty
                                        ? null
                                        : title.text.trim())));
                          },
                          child: const Text('创建并保存'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  int _blockCount(int questionId) {
    return ref
            .read(watchBlocksOfQuestionProvider(questionId))
            .value
            ?.length ??
        0;
  }
}

class NewQuestionInput {
  const NewQuestionInput({this.number, this.title});
  final String? number;
  final String? title;
}

class _BlockTarget {
  const _BlockTarget(this.existingQuestionId, this.blockType, this.newQuestion);
  final int? existingQuestionId;
  final String blockType;
  final NewQuestionInput? newQuestion;

  int? get questionId => existingQuestionId;
  bool get isNew => newQuestion != null;
}

class _SelectionPainter extends CustomPainter {
  _SelectionPainter({
    required this.normalized,
    required this.active,
    required this.color,
  });

  final Rect normalized;
  final bool active;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(
      normalized.left * size.width,
      normalized.top * size.height,
      normalized.right * size.width,
      normalized.bottom * size.height,
    );
    canvas.drawRect(
      rect,
      Paint()
        ..color = color.withValues(alpha: active ? 0.25 : 0.20)
        ..style = PaintingStyle.fill,
    );
    canvas.drawRect(
      rect,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    for (final corner in <Offset>[
      rect.topLeft,
      rect.topRight,
      rect.bottomLeft,
      rect.bottomRight,
    ]) {
      canvas.drawCircle(corner, 5, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(covariant _SelectionPainter oldDelegate) =>
      oldDelegate.normalized != normalized ||
      oldDelegate.active != active ||
      oldDelegate.color != color;
}

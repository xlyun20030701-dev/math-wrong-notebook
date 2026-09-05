import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/db/tables.dart';
import 'package:smart_wrong_notebook/src/mistake/labels.dart';
import 'package:smart_wrong_notebook/src/mistake/providers.dart';
import 'package:smart_wrong_notebook/src/mistake/services/block_geometry.dart';
import 'package:smart_wrong_notebook/src/mistake/storage/mistake_image_store.dart';

/// 在一张 Page 上手动框选矩形区域，并加入（新建/已有）错题。
class BlockSelectScreen extends ConsumerStatefulWidget {
  const BlockSelectScreen({
    required this.pageId,
    required this.paperId,
    super.key,
  });

  final int pageId;
  final int paperId;

  @override
  ConsumerState<BlockSelectScreen> createState() => _BlockSelectScreenState();
}

class _BlockSelectScreenState extends ConsumerState<BlockSelectScreen> {
  /// 已归一化（0~1）的选择矩形。
  Rect? _imageRect;
  Offset? _dragStartPx;
  bool _dragging = false;
  String _blockType = 'stem';

  /// 当前页面的一次性解码缓存，避免连续框选同一页时反复整图解码。
  img.Image? _cachedBaked;
  String? _cachedBakedPath;

  @override
  void dispose() {
    _cachedBaked = null;
    _cachedBakedPath = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageAsync = ref.watch(pageByIdProvider(widget.pageId));
    final basketAsync =
        ref.watch(watchQuestionsOfPaperProvider(widget.paperId));
    return pageAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('加载失败：$e'))),
      data: (page) {
        if (page == null) {
          return const Scaffold(body: Center(child: Text('页面不存在')));
        }
        final basket = basketAsync.value ?? const <Question>[];
        final selection = _imageRect;
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
                    _dragStartPx = null;
                    _dragging = false;
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
                              onSelected: (_) =>
                                  setState(() => _blockType = type),
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
                      label: Text(
                        selection == null ? '拖拽框选题目区域' : '保存区块到错题',
                      ),
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
    final fitW = areaH * imageAspect < areaW ? areaH * imageAspect : areaW;
    final fitH = areaW / imageAspect < areaH ? areaW / imageAspect : areaH;
    final displaySize = Size(fitW, fitH);

    return SizedBox(
      width: fitW,
      height: fitH,
      child: GestureDetector(
        onPanStart: (d) => setState(() {
          _dragStartPx = d.localPosition;
          _dragging = true;
        }),
        onPanUpdate: (d) {
          final start = _dragStartPx;
          if (start == null) return;
          final pxRect = Rect.fromPoints(start, d.localPosition);
          setState(() {
            _imageRect = normalizeBlockRect(pxRect, displaySize);
          });
        },
        onPanEnd: (_) => setState(() {
          _dragging = false;
          _dragStartPx = null;
        }),
        onPanCancel: () => setState(() {
          _dragging = false;
          _dragStartPx = null;
        }),
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
                  active: _dragging,
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

  Future<void> _saveToQuestion(
      Rect selection, List<Question> basket) async {
    // 保存前防御：拒绝退化/过小选区，明确提示重新框选。
    if (!isValidBlockRect(selection)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('选区过小，请重新框选后再保存')),
      );
      return;
    }
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
      // 同一页面多次框选时复用一次解码结果，避免反复整图解码。
      final baked = await _bakedImageFor(page.originalImagePath, store);
      final cropped = await store.cropBaked(
        widget.paperId,
        baked,
        x: selection.left,
        y: selection.top,
        width: selection.width,
        height: selection.height,
      );
      final sortOrder = await db.nextSortOrder(questionId);
      await db.insertBlock(
        questionId: questionId,
        pageId: widget.pageId,
        blockType: picked.blockType,
        x: selection.left,
        y: selection.top,
        width: selection.width,
        height: selection.height,
        sortOrder: sortOrder,
        processedImagePath: cropped,
        processingStatus: 'cropped',
      );
      if (!mounted) return;
      final matched = basket.where((q) => q.id == questionId);
      final label = picked.isNew || matched.isEmpty
          ? '新错题'
          : questionDisplayLabel(matched.first);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('已保存到 $label')));
      setState(() {
        _imageRect = null;
        _dragStartPx = null;
        _dragging = false;
      });
    } catch (e) {
      if (!mounted) return;
      final message = e is ArgumentError || e is StateError
          ? '无法保存：${e.toString().replaceFirst('Invalid argument(s): ', '')}'
          : '保存失败：$e';
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<img.Image> _bakedImageFor(
      String path, MistakeImageStore store) async {
    if (_cachedBaked != null && _cachedBakedPath == path) {
      return _cachedBaked!;
    }
    final baked = await store.decodeBaked(path);
    _cachedBaked = baked;
    _cachedBakedPath = path;
    return baked;
  }

  /// 弹出“加入错题”选择面板。
  ///
  /// 面板使用独立 [State] 的 [NewBlockTargetSheet] 保存“新建错题”中间状态，
  /// 避免键盘弹出 / 焦点 / MediaQuery 变化触发 modal route 重建时，
  /// 把 createMode 与输入内容重置回初始状态（旧实现导致点输入框即退出新建）。
  Future<BlockTargetSelection?> _pickTarget(List<Question> basket) async {
    final counts = <int, int>{};
    for (final q in basket) {
      counts[q.id] =
          ref.read(watchBlocksOfQuestionProvider(q.id)).value?.length ?? 0;
    }
    return showModalBottomSheet<BlockTargetSelection>(
      context: context,
      isScrollControlled: true,
      builder: (context) => NewBlockTargetSheet(
        blockType: _blockType,
        basket: basket,
        blockCounts: counts,
      ),
    );
  }
}

class NewQuestionInput {
  const NewQuestionInput({this.number, this.title});
  final String? number;
  final String? title;
}

class BlockTargetSelection {
  const BlockTargetSelection({
    this.existingQuestionId,
    required this.blockType,
    this.newQuestion,
  });

  /// 为 null 且 [newQuestion] 非空时表示“新建错题”。
  final int? existingQuestionId;
  final String blockType;
  final NewQuestionInput? newQuestion;

  bool get isNew => newQuestion != null;
}

/// “加入错题”底部面板：选择已有错题，或进入“新建错题”填写题号/标题。
///
/// createMode 与两个 [TextEditingController] 保存在独立的 [State] 中，
/// 键盘弹出或焦点 / MediaQuery.viewInsets 变化导致 route 重建时不会丢失状态。
class NewBlockTargetSheet extends StatefulWidget {
  const NewBlockTargetSheet({
    required this.blockType,
    required this.basket,
    required this.blockCounts,
    super.key,
  });

  final String blockType;
  final List<Question> basket;
  final Map<int, int> blockCounts;

  @override
  State<NewBlockTargetSheet> createState() => _NewBlockTargetSheetState();
}

class _NewBlockTargetSheetState extends State<NewBlockTargetSheet> {
  final TextEditingController _number = TextEditingController();
  final TextEditingController _title = TextEditingController();
  bool _createMode = false;

  @override
  void dispose() {
    _number.dispose();
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '加入错题 · ${blockTypeLabels[widget.blockType] ?? widget.blockType}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            if (!_createMode)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (final q in widget.basket)
                    ActionChip(
                      label: Text(
                          '${questionDisplayLabel(q)}（${widget.blockCounts[q.id] ?? 0}）'),
                      onPressed: () => Navigator.pop(
                        context,
                        BlockTargetSelection(
                          existingQuestionId: q.id,
                          blockType: widget.blockType,
                        ),
                      ),
                    ),
                  ActionChip(
                    avatar: const Icon(CupertinoIcons.add, size: 16),
                    label: const Text('新建错题'),
                    onPressed: () => setState(() => _createMode = true),
                  ),
                  if (widget.basket.isEmpty)
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
                    controller: _number,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: '原题号（如 3、7、11）'),
                  ),
                  TextField(
                    controller: _title,
                    decoration: const InputDecoration(labelText: '题干简述（可选）'),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {
                      final numberText = _number.text.trim();
                      final titleText = _title.text.trim();
                      if (numberText.isEmpty && titleText.isEmpty) {
                        return;
                      }
                      Navigator.pop(
                        context,
                        BlockTargetSelection(
                          blockType: widget.blockType,
                          newQuestion: NewQuestionInput(
                            number: numberText.isEmpty ? null : numberText,
                            title: titleText.isEmpty ? null : titleText,
                          ),
                        ),
                      );
                    },
                    child: const Text('创建并保存'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
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
    final rect = Rect.fromLTWH(
      normalized.left * size.width,
      normalized.top * size.height,
      normalized.width * size.width,
      normalized.height * size.height,
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

import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/db/tables.dart';
import 'package:smart_wrong_notebook/src/mistake/labels.dart';
import 'package:smart_wrong_notebook/src/mistake/providers.dart';
import 'package:smart_wrong_notebook/src/mistake/services/bitmap_util.dart';
import 'package:smart_wrong_notebook/src/mistake/services/block_geometry.dart';
import 'package:smart_wrong_notebook/src/mistake/storage/mistake_image_store.dart';

enum _Tool { hand, box }

/// 在一张 Page 上手动框选矩形区域，并加入（新建/已有）错题。
///
/// 支持双指缩放、拖动平移、90° 旋转；选区在旋转位图坐标系（=旋转后所见）中
/// 归一化保存，保存时通过 [fromRotatedToOriginal] 还原到原图归一化坐标。
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
  final TransformationController _tc = TransformationController();
  _Tool _tool = _Tool.hand;
  int _rot = 0; // 顺时针 90° 次数
  img.Image? _baked; // 未旋转
  Uint8List? _bytes; // 当前旋转后 jpg
  bool _loading = true;

  Rect? _imageRect; // 当前旋转帧内的归一化选区
  _DragState? _drag;

  @override
  void dispose() {
    _tc.dispose();
    super.dispose();
  }

  Future<void> _load(PageRecord page) async {
    if (_baked != null) return;
    final store = ref.read(mistakeImageStoreProvider);
    _baked = await store.decodeBaked(page.originalImagePath);
    if (!mounted) return;
    setState(() {
      _bytes = encodeJpgBytes(_baked!);
      _loading = false;
    });
  }

  void _rotateClockwise() {
    final rect = _imageRect;
    setState(() {
      _rot = (_rot + 1) % 4;
      // 内容跟随旋转：选区同步变换到新的旋转帧。
      if (rect != null) {
        _imageRect = fromRotatedToOriginal(rect, 3);
      }
      _bytes = encodeJpgBytes(rotateCWQuarter(_baked!, _rot));
    });
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
        if (_loading) {
          _load(page);
        }
        final basket = basketAsync.value ?? const <Question>[];
        return Scaffold(
          appBar: AppBar(
            title: Text('框选 · 第 ${page.pageIndex} 页'),
            actions: <Widget>[
              IconButton(
                tooltip: '清除选区',
                onPressed: _imageRect == null
                    ? null
                    : () => setState(() => _imageRect = null),
                icon: const Icon(CupertinoIcons.clear),
              ),
              IconButton(
                tooltip: '顺时针旋转 90°',
                onPressed: _loading
                    ? null
                    : () => _rotateClockwise(),
                icon: const Icon(Icons.rotate_90_degrees_cw),
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
                  Row(
                    children: <Widget>[
                      SegmentedButton<_Tool>(
                        showSelectedIcon: false,
                        style: const ButtonStyle(
                          visualDensity: VisualDensity.compact,
                        ),
                        segments: const <ButtonSegment<_Tool>>[
                          ButtonSegment<_Tool>(
                            value: _Tool.hand,
                            icon: Icon(CupertinoIcons.hand_draw),
                          ),
                          ButtonSegment<_Tool>(
                            value: _Tool.box,
                            icon: Icon(CupertinoIcons.crop),
                          ),
                        ],
                        selected: <_Tool>{_tool},
                        onSelectionChanged: (s) =>
                            setState(() => _tool = s.first),
                      ),
                      const Spacer(),
                      FilledButton.icon(
                        onPressed: _imageRect == null
                            ? null
                            : () => _saveToQuestion(_imageRect!, basket),
                        icon: const Icon(CupertinoIcons.plus_rectangle_on_rectangle),
                        label: Text(_imageRect == null ? '先框选' : '保存区块'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: _loading
              ? const Center(child: CircularProgressIndicator())
              : _buildViewer(context, page),
        );
      },
    );
  }

  String _blockType = 'stem';

  Widget _buildViewer(BuildContext context, PageRecord page) {
    final rotAspect = _rotatedAspect(page);
    return LayoutBuilder(
      builder: (context, constraints) {
        final areaW = math.max(160.0, constraints.maxWidth - 24);
        final areaH = math.max(160.0, constraints.maxHeight - 24);
        final fitW =
            areaH * rotAspect < areaW ? areaH * rotAspect : areaW;
        final fitH = areaW / rotAspect < areaH ? areaW / rotAspect : areaH;
        final childSize = Size(fitW, fitH);

        return Center(
          child: ClipRect(
            child: SizedBox(
              width: areaW,
              height: areaH,
              child: InteractiveViewer(
                transformationController: _tc,
                minScale: 0.6,
                maxScale: 6,
                panEnabled: _tool == _Tool.hand,
                scaleEnabled: true,
                constrained: false,
                child: SizedBox(
                  width: fitW,
                  height: fitH,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.memory(
                        _bytes!,
                        fit: BoxFit.fill,
                        gaplessPlayback: true,
                      ),
                      if (_tool == _Tool.box)
                        _BoxOverlay(
                          rect: _imageRect,
                          size: childSize,
                          active: _drag != null,
                          onPanStart: (p) => _onBoxStart(p, childSize),
                          onPanUpdate: (p) =>
                              _onBoxUpdate(p, childSize),
                          onPanEnd: () => _drag = null,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double _rotatedAspect(PageRecord page) {
    final w = page.width;
    final h = page.height;
    if (w != null && h != null && w > 0 && h > 0) {
      return (_rot.isOdd) ? h / w : w / h;
    }
    return (_rot.isOdd) ? 4 / 3 : 3 / 4;
  }

  void _onBoxStart(Offset px, Size size) {
    final p = _toNorm(px, size);
    final rect = _imageRect;
    if (rect != null) {
      final corner = _hitCorner(rect, px, size);
      if (corner >= 0) {
        _drag = _DragState(kind: 'corner', corner: corner, base: rect)
          ..last = p;
        return;
      }
      if (rect.contains(p)) {
        _drag = _DragState(kind: 'move', base: rect)..last = p;
        return;
      }
    }
    _drag = _DragState(kind: 'new', start: p);
    _imageRect = _rectFromPoints(p, p);
  }

  void _onBoxUpdate(Offset px, Size size) {
    final d = _drag;
    if (d == null) return;
    final p = _toNorm(px, size);
    setState(() {
      final rect = _imageRect;
      if (rect == null) return;
      switch (d.kind) {
        case 'new':
          _imageRect = _rectFromPoints(d.start!, p);
        case 'move':
          final dx = p.dx - d.last!.dx;
          final dy = p.dy - d.last!.dy;
          final moved = Rect.fromLTWH(
            (d.base!.left + dx).clamp(0.0, 1.0 - d.base!.width),
            (d.base!.top + dy).clamp(0.0, 1.0 - d.base!.height),
            d.base!.width,
            d.base!.height,
          );
          _imageRect = moved;
        case 'corner':
          _imageRect = _resizeCorner(d.base!, d.corner!, p);
      }
      d.last = p;
    });
  }

  Rect _rectFromPoints(Offset a, Offset b) {
    final l = math.min(a.dx, b.dx);
    final t = math.min(a.dy, b.dy);
    final r = math.max(a.dx, b.dx);
    final bt = math.max(a.dy, b.dy);
    return Rect.fromLTRB(
      l.clamp(0.0, 1.0),
      t.clamp(0.0, 1.0),
      r.clamp(0.0, 1.0),
      bt.clamp(0.0, 1.0),
    );
  }

  Rect _resizeCorner(Rect base, int corner, Offset p) {
    const minSide = kMinBlockNormalizedSide;
    var l = base.left;
    var t = base.top;
    var r = base.right;
    var b = base.bottom;
    // corner: 0=tl 1=tr 2=bl 3=br
    if (corner == 0 || corner == 2) {
      l = math.min(p.dx, r - minSide);
    } else {
      r = math.max(p.dx, l + minSide);
    }
    if (corner == 0 || corner == 1) {
      t = math.min(p.dy, b - minSide);
    } else {
      b = math.max(p.dy, t + minSide);
    }
    return Rect.fromLTRB(
      l.clamp(0.0, 1.0),
      t.clamp(0.0, 1.0),
      r.clamp(0.0, 1.0),
      b.clamp(0.0, 1.0),
    );
  }

  int _hitCorner(Rect rect, Offset px, Size size) {
    const rPx = 26.0;
    final w = size.width;
    final h = size.height;
    final c0 = Offset(rect.left * w, rect.top * h);
    final c1 = Offset(rect.right * w, rect.top * h);
    final c2 = Offset(rect.left * w, rect.bottom * h);
    final c3 = Offset(rect.right * w, rect.bottom * h);
    final corners = <Rect>[
      Rect.fromCenter(center: c0, width: rPx, height: rPx),
      Rect.fromCenter(center: c1, width: rPx, height: rPx),
      Rect.fromCenter(center: c2, width: rPx, height: rPx),
      Rect.fromCenter(center: c3, width: rPx, height: rPx),
    ];
    for (var i = 0; i < 4; i++) {
      if (corners[i].contains(px)) return i;
    }
    return -1;
  }

  Offset _toNorm(Offset px, Size size) => Offset(
      (px.dx / size.width).clamp(0.0, 1.0),
      (px.dy / size.height).clamp(0.0, 1.0));

  Future<void> _saveToQuestion(
      Rect selectionInRotatedFrame, List<Question> basket) async {
    if (!isValidBlockRect(selectionInRotatedFrame)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('选区过小，请重新框选后再保存')),
      );
      return;
    }
    final picked = await _pickTarget(basket);
    if (picked == null || !mounted) return;
    // 还原到未旋转原帧坐标后再裁剪/入库。
    final selection = fromRotatedToOriginal(selectionInRotatedFrame, _rot);

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
        _drag = null;
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
    if (_baked != null) return _baked!;
    final baked = await store.decodeBaked(path);
    _baked = baked;
    return baked;
  }

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

class _DragState {
  _DragState({required this.kind, this.corner, this.base, this.start});

  final String kind;
  final int? corner;
  final Rect? base;
  final Offset? start;
  Offset? last;
}

/// 框选模式下的可拖拽选区覆盖层（子坐标系 = 旋转后位图的显示盒）。
class _BoxOverlay extends StatelessWidget {
  const _BoxOverlay({
    required this.rect,
    required this.size,
    required this.active,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.color,
  });

  final Rect? rect;
  final Size size;
  final bool active;
  final void Function(Offset) onPanStart;
  final void Function(Offset) onPanUpdate;
  final VoidCallback onPanEnd;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (d) => onPanStart(d.localPosition),
      onPanUpdate: (d) => onPanUpdate(d.localPosition),
      onPanEnd: (_) => onPanEnd(),
      onPanCancel: onPanEnd,
      child: CustomPaint(
        painter: rect == null
            ? null
            : _SelectionPainter(
                normalized: rect!,
                active: active,
                color: color,
              ),
        child: const SizedBox.expand(),
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
        ..color = color.withValues(alpha: active ? 0.22 : 0.18)
        ..style = PaintingStyle.fill,
    );
    canvas.drawRect(
      rect,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    final handlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final ring = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (final corner in <Offset>[
      rect.topLeft,
      rect.topRight,
      rect.bottomLeft,
      rect.bottomRight,
    ]) {
      canvas.drawCircle(corner, 8, handlePaint);
      canvas.drawCircle(corner, 8, ring);
    }
  }

  @override
  bool shouldRepaint(covariant _SelectionPainter oldDelegate) =>
      oldDelegate.normalized != normalized ||
      oldDelegate.active != active ||
      oldDelegate.color != color;
}


import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/providers.dart';

import 'package:drift/drift.dart' show Value;

enum EraseMode { erase, restore }

/// 手动橡皮擦：以 mask 笔刷方式对区块裁剪图做非破坏编辑，
/// 产物保存为新 BlockVersion（manual），原图/源图永不被修改。
class MaskEditorScreen extends ConsumerStatefulWidget {
  const MaskEditorScreen({required this.blockId, super.key});

  final int blockId;

  @override
  ConsumerState<MaskEditorScreen> createState() => _MaskEditorScreenState();
}

class _Stroke {
  _Stroke(this.mode, this.cx, this.cy, this.r);
  final EraseMode mode;
  final double cx; // normalized
  final double cy;
  final double r; // normalized
}

class _MaskEditorScreenState extends ConsumerState<MaskEditorScreen> {
  img.Image? _source; // 源图（被编辑对象）
  EraseMode _mode = EraseMode.erase;
  double _brushFrac = 0.03;
  final List<_Stroke> _strokes = <_Stroke>[];
  final List<_Stroke> _redo = <_Stroke>[];
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final block = await ref.read(mistakeDbProvider).blockById(widget.blockId);
    if (block == null || block.processedImagePath == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('区块没有可编辑图片')),
        );
        Navigator.of(context).pop();
      }
      return;
    }
    final bytes = await File(block.processedImagePath!).readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('图片无法解码')),
        );
      }
      return;
    }
    if (!mounted) return;
    setState(() => _source = img.bakeOrientation(decoded));
  }

  @override
  Widget build(BuildContext context) {
    final src = _source;
    return Scaffold(
      appBar: AppBar(
        title: const Text('手动橡皮擦'),
        actions: <Widget>[
          IconButton(
            tooltip: '撤销',
            onPressed: _strokes.isEmpty ? null : _undo,
            icon: const Icon(CupertinoIcons.arrow_uturn_left),
          ),
          IconButton(
            tooltip: '重做',
            onPressed: _redo.isEmpty ? null : _redoAction,
            icon: const Icon(CupertinoIcons.arrow_uturn_right),
          ),
          TextButton(onPressed: _busy ? null : _save, child: const Text('保存')),
        ],
      ),
      body: src == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final aspect = src.width / src.height;
                      final areaW = math.max(200.0, constraints.maxWidth - 8);
                      final areaH = math.max(200.0, constraints.maxHeight - 8);
                      final fitW =
                          areaH * aspect < areaW ? areaH * aspect : areaW;
                      final fitH =
                          areaW / aspect < areaH ? areaW / aspect : areaH;
                      return Center(
                        child: InteractiveViewer(
                          minScale: 1,
                          maxScale: 6,
                          child: SizedBox(
                            width: fitW,
                            height: fitH,
                            child: GestureDetector(
                              onPanStart: (d) =>
                                  _strokeAt(d.localPosition, Size(fitW, fitH)),
                              onPanUpdate: (d) =>
                                  _strokeAt(d.localPosition, Size(fitW, fitH)),
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  Image.memory(
                                    _jpeg(src),
                                    fit: BoxFit.fill,
                                    gaplessPlayback: true,
                                  ),
                                  _StrokeOverlay(strokes: _strokes),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                _toolbar(),
              ],
            ),
    );
  }

  Uint8List _jpeg(img.Image image) =>
      Uint8List.fromList(img.encodeJpg(image, quality: 90));

  void _strokeAt(Offset local, Size box) {
    final src = _source;
    if (src == null || box.width <= 0 || box.height <= 0) return;
    final sx = (local.dx / box.width).clamp(0.0, 1.0);
    final sy = (local.dy / box.height).clamp(0.0, 1.0);
    setState(() {
      _strokes.add(_Stroke(_mode, sx, sy, _brushFrac));
      _redo.clear();
    });
  }

  void _undo() {
    setState(() {
      if (_strokes.isNotEmpty) _redo.add(_strokes.removeLast());
    });
  }

  void _redoAction() {
    setState(() {
      if (_redo.isNotEmpty) _strokes.add(_redo.removeLast());
    });
  }

  Widget _toolbar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SegmentedButton<EraseMode>(
              showSelectedIcon: false,
              segments: const <ButtonSegment<EraseMode>>[
                ButtonSegment<EraseMode>(
                    value: EraseMode.erase,
                    icon: Icon(Icons.auto_fix_high),
                    label: Text('擦除')),
                ButtonSegment<EraseMode>(
                    value: EraseMode.restore,
                    icon: Icon(Icons.undo),
                    label: Text('恢复')),
              ],
              selected: <EraseMode>{_mode},
              onSelectionChanged: (s) => setState(() => _mode = s.first),
            ),
            const SizedBox(height: 4),
            Row(
              children: <Widget>[
                const Text('笔刷'),
                Expanded(
                  child: Slider(
                    value: _brushFrac,
                    min: 0.008,
                    max: 0.08,
                    onChanged: (v) => setState(() => _brushFrac = v),
                  ),
                ),
                Text('${(_brushFrac * 100).round()}%'),
              ],
            ),
            Text(
              '擦除=把笔迹涂白；恢复=从源图取回。保存后生成新的 manual 版本，原图不变。',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final src = _source;
    if (src == null || _strokes.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('没有编辑内容')));
      }
      return;
    }
    setState(() => _busy = true);
    try {
      final out = img.Image.from(src);
      final w = out.width;
      final h = out.height;
      for (final s in _strokes) {
        final cx = s.cx * w;
        final cy = s.cy * h;
        final r = math.max(2.0, s.r * w);
        final x0 = (cx - r).floor().clamp(0, w - 1);
        final x1 = (cx + r).ceil().clamp(0, w - 1);
        final y0 = (cy - r).floor().clamp(0, h - 1);
        final y1 = (cy + r).ceil().clamp(0, h - 1);
        for (var y = y0; y <= y1; y++) {
          for (var x = x0; x <= x1; x++) {
            if ((x - cx) * (x - cx) + (y - cy) * (y - cy) <= r * r) {
              if (s.mode == EraseMode.erase) {
                out.setPixelRgb(x, y, 250, 250, 250);
              } else {
                final p = src.getPixel(x, y);
                out.setPixel(x, y, p);
              }
            }
          }
        }
      }
      final bytes = Uint8List.fromList(img.encodeJpg(out, quality: 92));
      final block = await ref.read(mistakeDbProvider).blockById(widget.blockId);
      final store = ref.read(mistakeImageStoreProvider);
      final page = block == null ? null : await ref.read(mistakeDbProvider).pageById(block.pageId);
      final paperId = page?.paperId ?? 0;
      final dest = await store.saveDerived(paperId, bytes, 'processed', 'jpg');
      await ref.read(mistakeDbProvider).insertBlockVersion(
        BlockVersionsCompanion.insert(
          blockId: widget.blockId,
          method: 'manual',
          sourceImagePath: Value(block?.processedImagePath),
          processedImagePath: Value(dest),
          model: const Value(null),
          verified: const Value(false),
        ),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('已保存 manual 版本')));
      Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('保存失败：$e')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}

class _StrokeOverlay extends StatelessWidget {
  const _StrokeOverlay({required this.strokes});

  final List<_Stroke> strokes;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _StrokePainter(strokes));
  }
}

class _StrokePainter extends CustomPainter {
  _StrokePainter(this.strokes);
  final List<_Stroke> strokes;

  @override
  void paint(Canvas canvas, Size size) {
    for (final s in strokes) {
      final r = math.max(2.0, s.r * size.width);
      final center = Offset(s.cx * size.width, s.cy * size.height);
      canvas.drawCircle(
        center,
        r,
        Paint()
          ..color = s.mode == EraseMode.erase
              ? Colors.black.withValues(alpha: 0.35)
              : Colors.green.withValues(alpha: 0.3),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _StrokePainter oldDelegate) => true;
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_wrong_notebook/src/mistake/print/layout_engine.dart';

/// 用与 PDF 相同的 [PrintLayoutEngine] 结果渲染 A4 页面预览（mm→px 等比）。
class A4Preview extends StatelessWidget {
  const A4Preview({
    required this.pages,
    required this.options,
    super.key,
  });

  final List<A4PageLayout> pages;
  final LayoutOptions options;

  @override
  Widget build(BuildContext context) {
    if (pages.isEmpty) {
      return const Center(child: Text('没有可预览内容'));
    }
    return PageView.builder(
      itemCount: pages.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(12),
        child: Center(child: _PageSheet(page: pages[index], options: options)),
      ),
    );
  }
}

class _PageSheet extends StatelessWidget {
  const _PageSheet({required this.page, required this.options});

  final A4PageLayout page;
  final LayoutOptions options;

  @override
  Widget build(BuildContext context) {
    final aspect = options.pageWidthMm / options.pageHeightMm;
    return AspectRatio(
      aspectRatio: aspect,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black26),
          boxShadow: const <BoxShadow>[
            BoxShadow(blurRadius: 6, color: Colors.black26),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final f = constraints.maxWidth / options.pageWidthMm;
            final placed = const PrintLayoutEngine().placeOnPage(page, options);
            return ClipRect(
              child: Stack(
                children: <Widget>[
                  for (final item in placed)
                    Positioned(
                      left: item.xMm * f,
                      top: item.yMm * f,
                      width: item.widthMm * f,
                      height: item.heightMm * f,
                      child: _Item(item, f),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(this.item, this.f);
  final Placed item;
  final double f;

  @override
  Widget build(BuildContext context) {
    switch (item.type) {
      case 'text':
        return Text(
          item.text,
          style: TextStyle(fontSize: item.textSizePt * f),
          overflow: TextOverflow.clip,
        );
      case 'image':
        final path = item.imagePath;
        return path == null
            ? const ColoredBox(color: Colors.black12)
            : Image.file(File(path),
                fit: BoxFit.fill, errorBuilder: (_, __, ___) =>
                    const ColoredBox(color: Colors.black12));
      case 'answerSpace':
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: CustomPaint(painter: _RulerLines(color: Colors.grey.shade500)),
        );
      case 'cutline':
        return Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.black38,
                width: 0.5 * f,
              ),
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _RulerLines extends CustomPainter {
  _RulerLines({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;
    const spacing = 20.0;
    var y = spacing;
    while (y < size.height - 6) {
      canvas.drawLine(Offset(4, y), Offset(size.width - 4, y), paint);
      y += spacing;
    }
  }

  @override
  bool shouldRepaint(covariant _RulerLines old) => false;
}

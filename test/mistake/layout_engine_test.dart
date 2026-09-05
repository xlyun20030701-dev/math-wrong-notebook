import 'package:flutter_test/flutter_test.dart';
import 'package:smart_wrong_notebook/src/mistake/print/layout_engine.dart';

void main() {
  const engine = PrintLayoutEngine();
  const options = LayoutOptions();

  PrintDocQuestion doc(String no, {int space = 40, double aspect = 1.2}) =>
      PrintDocQuestion(
        displayNo: no,
        originalNumber: no,
        knowledgePoint: '函数',
        source: '期中卷',
        blocks: <PrintImageBlock>[PrintImageBlock(aspect: aspect)],
        answerSpaceMm: space,
      );

  List<A4PageLayout> build(int space) => engine.layout(
        questions: <PrintDocQuestion>[for (var i = 1; i <= 6; i++) doc('$i', space: space)],
        options: options,
      );

  test('places never exceed page bottom', () {
    final pages = build(40);
    expect(pages, isNotEmpty);
    for (final page in pages) {
      final placed = engine.placeOnPage(page, options);
      if (placed.isEmpty) continue;
      final bottom = placed.map((p) => p.yMm + p.heightMm).reduce((a, b) => a > b ? a : b);
      expect(bottom, lessThanOrEqualTo(297 - 10 + 0.2));
    }
  });

  test('larger answerSpaceMm repaginates into more pages', () {
    final small = build(20);
    final big = build(90);
    expect(big.length, greaterThanOrEqualTo(small.length));
  });

  test('exam mode adds answerSpace; images placed at usable width', () {
    final pages = engine.layout(
      questions: <PrintDocQuestion>[doc('1', space: 30)],
      options: const LayoutOptions(mode: PrintMode.exam),
    );
    final types = pages.first.places.map((p) => p.type).toList();
    expect(types, contains('answerSpace'));
    expect(types, contains('image'));
    final image = pages.first.places.firstWhere((p) => p.type == 'image');
    expect(image.widthMm, closeTo(210 - 2 * 10, 0.1));
  });

  test('cut-and-paste mode: optional dashed cutlines', () {
    final pages = engine.layout(
      questions: <PrintDocQuestion>[doc('1', space: 0), doc('2', space: 0)],
      options: const LayoutOptions(
          mode: PrintMode.cutAndPaste, cutLines: true),
    );
    final hasCut = pages.first.places.any((p) => p.type == 'cutline');
    expect(hasCut, isTrue);
  });
}

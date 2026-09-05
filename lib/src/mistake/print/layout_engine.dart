/// 打印模式。
enum PrintMode { cutAndPaste, exam }

/// 一道待打印的题（Question 或 AI 生成题）。
class PrintDocQuestion {
  const PrintDocQuestion({
    required this.displayNo,
    this.originalNumber,
    this.source,
    this.knowledgePoint,
    required this.blocks,
    this.answerText,
    required this.answerSpaceMm,
    this.scaleOverride,
    this.showSource = true,
    this.showOriginalNumber = true,
    this.showAnswer = false,
    this.keepTogether = true,
  });

  final String displayNo;
  final String? originalNumber;
  final String? source;
  final String? knowledgePoint;
  final List<PrintImageBlock> blocks;
  final String? answerText;
  final int answerSpaceMm;
  final double? scaleOverride;
  final bool showSource;
  final bool showOriginalNumber;
  final bool showAnswer;
  final bool keepTogether;
}

class PrintImageBlock {
  const PrintImageBlock({required this.aspect, this.imagePath});

  final double aspect;
  final String? imagePath;
}

/// 页面上放置的矩形单元（yMm 由 [PrintLayoutEngine.placeOnPage] 回填）。
class Placed {
  const Placed({
    required this.widthMm,
    required this.heightMm,
    required this.type,
    this.xMm = 0,
    this.yMm = 0,
    this.imagePath,
    this.text = '',
    this.textSizePt = 10,
    this.dash = false,
  });

  final double xMm;
  final double yMm;
  final double widthMm;
  final double heightMm;
  final String type;
  final String? imagePath;
  final String text;
  final double textSizePt;
  final bool dash;

  Placed atY(double y) => Placed(
        widthMm: widthMm,
        heightMm: heightMm,
        type: type,
        xMm: xMm,
        yMm: y,
        imagePath: imagePath,
        text: text,
        textSizePt: textSizePt,
        dash: dash,
      );
}

class A4PageLayout {
  const A4PageLayout({required this.places});

  final List<Placed> places;
}

class LayoutOptions {
  const LayoutOptions({
    this.pageWidthMm = 210,
    this.pageHeightMm = 297,
    this.marginMm = 10,
    this.itemGapMm = 4,
    this.paragraphGapMm = 3,
    this.mode = PrintMode.exam,
    this.cutLines = false,
  });

  final double pageWidthMm;
  final double pageHeightMm;
  final double marginMm;
  final double itemGapMm;
  final double paragraphGapMm;
  final PrintMode mode;
  final bool cutLines;
}

/// 纯分页引擎：同一分页/坐标规则用于 A4 预览与最终 PDF。
class PrintLayoutEngine {
  const PrintLayoutEngine();

  double get _headerLineMm => 5.2;

  List<A4PageLayout> layout({
    required List<PrintDocQuestion> questions,
    LayoutOptions options = const LayoutOptions(),
  }) {
    final usableW = options.pageWidthMm - 2 * options.marginMm;
    final usableH = options.pageHeightMm - 2 * options.marginMm;
    final pages = <A4PageLayout>[];
    var cursor = options.marginMm;
    var current = <Placed>[];

    void flush() {
      pages.add(A4PageLayout(places: current));
      current = <Placed>[];
      cursor = options.marginMm;
    }

    void pushItems(List<Placed> items) {
      for (final raw in items) {
        var item = raw;
        if (current.isNotEmpty && cursor + item.heightMm > options.marginMm + usableH + 0.1) {
          flush();
        }
        if (item.heightMm > usableH - 0.1) {
          // 单个超大图：放入单独一页并按页高缩排。
          if (current.isNotEmpty) flush();
          final scale = (usableH - 2 * options.paragraphGapMm) / item.heightMm;
          if (scale < 1) {
            item = Placed(
              widthMm: item.widthMm * scale,
              heightMm: item.heightMm * scale,
              type: item.type,
              xMm: item.xMm,
              imagePath: item.imagePath,
              text: item.text,
              textSizePt: item.textSizePt,
              dash: item.dash,
            );
          }
        }
        current.add(item);
        cursor += item.heightMm + options.itemGapMm;
      }
      // 题与题之间留段落间距
      cursor += options.paragraphGapMm;
      if (options.cutLines && options.mode == PrintMode.cutAndPaste) {
        final cutline = Placed(
          widthMm: usableW,
          heightMm: 0.4,
          type: 'cutline',
          xMm: options.marginMm,
          dash: true,
        );
        current.add(cutline);
        cursor += options.paragraphGapMm;
      }
    }

    for (final q in questions) {
      final items = _itemsOf(q, usableW, options);
      // 整题分块：允许同题内跨页（若块总高超出），但尽量不分。
      pushItems(items);
    }

    if (current.isNotEmpty) pages.add(A4PageLayout(places: current));
    if (pages.isEmpty) pages.add(const A4PageLayout(places: <Placed>[]));
    return pages;
  }

  /// 依据已分页结果，为每个 [Placed] 回填页内绝对 y（mm，自页顶 margin 起）。
  List<Placed> placeOnPage(A4PageLayout page, LayoutOptions options) {
    var y = options.marginMm;
    final out = <Placed>[];
    for (final raw in page.places) {
      out.add(raw.atY(y));
      y += raw.heightMm + options.itemGapMm;
    }
    return out;
  }

  List<Placed> _itemsOf(PrintDocQuestion q, double usableW, LayoutOptions options) {
    final items = <Placed>[];

    String header = '';
    if (options.mode == PrintMode.exam) {
      if (q.displayNo.isNotEmpty) header += q.displayNo;
      if (q.originalNumber != null &&
          q.originalNumber!.isNotEmpty &&
          q.showOriginalNumber) {
        header += header.isEmpty ? '原题 ${q.originalNumber}' : '（原 ${q.originalNumber}）';
      }
      if (q.knowledgePoint != null && q.knowledgePoint!.isNotEmpty) {
        header += header.isEmpty ? q.knowledgePoint! : '  ${q.knowledgePoint}';
      }
      if (q.showSource && q.source != null && q.source!.isNotEmpty) {
        header += header.isEmpty ? '来源：${q.source}' : '  来源：${q.source}';
      }
    } else {
      final parts = <String>[];
      if (q.showOriginalNumber &&
          q.originalNumber != null &&
          q.originalNumber!.isNotEmpty) {
        parts.add('第 ${q.originalNumber} 题');
      }
      if (q.showSource && q.source != null && q.source!.isNotEmpty) {
        parts.add(q.source!);
      }
      header = parts.join(' · ');
    }
    if (header.isNotEmpty) {
      items.add(Placed(
        widthMm: usableW,
        heightMm: _headerLineMm,
        type: 'text',
        xMm: options.marginMm,
        text: header,
        textSizePt: options.mode == PrintMode.exam ? 11 : 9,
      ));
    }

    for (final b in q.blocks) {
      final scale = (q.scaleOverride ?? 1.0).clamp(0.2, 1.0);
      final w = (usableW * scale).clamp(10.0, usableW);
      final h = b.aspect <= 0 ? 40.0 : w / b.aspect;
      items.add(Placed(
        widthMm: w,
        heightMm: h,
        type: 'image',
        xMm: options.marginMm + (usableW - w) / 2,
        imagePath: b.imagePath,
      ));
    }

    if (options.mode == PrintMode.exam && q.answerSpaceMm > 0) {
      items.add(Placed(
        widthMm: usableW,
        heightMm: q.answerSpaceMm.toDouble(),
        type: 'answerSpace',
        xMm: options.marginMm,
      ));
    }
    final answerText = q.showAnswer ? q.answerText : null;
    if (options.mode == PrintMode.exam &&
        answerText != null &&
        answerText.isNotEmpty) {
      final roughLines = (answerText.length / 34).ceil().clamp(1, 40);
      items.add(Placed(
        widthMm: usableW,
        heightMm: _headerLineMm * roughLines,
        type: 'text',
        xMm: options.marginMm,
        text: '答案：$answerText',
        textSizePt: 10,
      ));
    }
    return items;
  }
}

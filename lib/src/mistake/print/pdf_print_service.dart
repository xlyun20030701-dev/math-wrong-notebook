import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:smart_wrong_notebook/src/mistake/print/layout_engine.dart';const double _ptPerMm = 72 / 25.4;

pw.Font? _cachedCjkFont;

/// 在 Android 设备上查找系统 CJK 字体并加载（个人打印中文标题/答案用）。
Future<pw.Font?> loadDeviceCjkFont() async {
  if (_cachedCjkFont != null) return _cachedCjkFont;
  const candidates = <String>[
    '/system/fonts/NotoSansSC-Regular.otf',
    '/system/fonts/DroidSansFallback.ttf',
    '/system/fonts/NotoSansCJK-Regular.ttc',
  ];
  for (final path in candidates) {
    try {
      final file = File(path);
      if (!await file.exists()) continue;
      final bytes = await file.readAsBytes();
      final font = pw.Font.ttf(ByteData.sublistView(bytes));
      _cachedCjkFont = font;
      return font;
    } catch (_) {
      // 尝试下一个候选
    }
  }
  return null;
}

/// A4 PDF 导出：与 [PrintLayoutEngine] 共用分页结果。
class PdfPrintService {
  PdfPrintService({Future<List<int>> Function(String path)? imageReader})
      : _imageReader = imageReader;

  final Future<List<int>> Function(String path)? _imageReader;

  Future<Uint8List> build({
    required List<A4PageLayout> pages,
    LayoutOptions options = const LayoutOptions(),
    pw.Font? font,
  }) async {
    // 先统一读取图片字节，避免在 widget 树中使用 FutureBuilder。
    final images = <String, Uint8List>{};
    Future<Uint8List> load(String path) async =>
        Uint8List.fromList(await (_imageReader?.call(path) ??
            File(path).readAsBytes()));
    for (final page in pages) {
      for (final item in page.places) {
        if (item.type == 'image' &&
            item.imagePath != null &&
            !images.containsKey(item.imagePath)) {
          try {
            images[item.imagePath!] = await load(item.imagePath!);
          } catch (_) {
            images[item.imagePath!] = Uint8List(0);
          }
        }
      }
    }

    final doc = font == null
        ? pw.Document()
        : pw.Document(theme: pw.ThemeData.withFont(base: font));
    final pageFormat = PdfPageFormat(
      options.pageWidthMm * _ptPerMm,
      options.pageHeightMm * _ptPerMm,
      marginAll: 0,
    );

    for (final page in pages) {
      final placed = const PrintLayoutEngine().placeOnPage(page, options);
      doc.addPage(pw.Page(
        pageFormat: pageFormat,
        margin: const pw.EdgeInsets.all(0),
        build: (ctx) => pw.Stack(children: <pw.Widget>[
          for (final item in placed) _widget(item, images),
        ]),
      ));
    }
    return doc.save();
  }

  pw.Widget _widget(Placed item, Map<String, Uint8List> images) {
    final left = item.xMm * _ptPerMm;
    final top = item.yMm * _ptPerMm;
    final w = item.widthMm * _ptPerMm;
    final h = item.heightMm * _ptPerMm;

    pw.Positioned pos(pw.Widget child) =>
        pw.Positioned(left: left, top: top, child: child);

    switch (item.type) {
      case 'text':
        return pos(pw.SizedBox(
          width: w,
          height: h,
          child: pw.Text(
            item.text,
            textAlign: pw.TextAlign.left,
            style: pw.TextStyle(fontSize: item.textSizePt),
          ),
        ));
      case 'image':
        final bytes = item.imagePath == null
            ? Uint8List(0)
            : (images[item.imagePath] ?? Uint8List(0));
        return pos(pw.SizedBox(
          width: w,
          height: h,
          child: bytes.isEmpty
              ? pw.Container(color: PdfColors.grey300)
              : pw.Image(pw.MemoryImage(bytes), fit: pw.BoxFit.fill),
        ));
      case 'answerSpace':
        final lines = <pw.Widget>[];
        const spacingPt = 8.0 * _ptPerMm;
        var y = spacingPt;
        while (y < h - spacingPt) {
          lines.add(pw.Positioned(
            left: 4,
            right: 4,
            top: y,
            child: pw.Container(height: 0.6, color: PdfColors.grey500),
          ));
          y += spacingPt;
        }
        return pos(pw.SizedBox(
          width: w,
          height: h,
          child: pw.Stack(
            children:
                lines.isEmpty ? <pw.Widget>[pw.Container()] : lines,
          ),
        ));
      case 'cutline':
        return pos(pw.SizedBox(
          width: w,
          height: 0.5,
          child: pw.Container(height: 0.5, color: PdfColors.grey400),
        ));
      default:
        return pw.SizedBox();
    }
  }
}

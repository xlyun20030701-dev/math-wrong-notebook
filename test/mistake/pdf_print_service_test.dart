import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:smart_wrong_notebook/src/mistake/print/layout_engine.dart';
import 'package:smart_wrong_notebook/src/mistake/print/pdf_print_service.dart';

void main() {
  test('pdf builds from engine pages and starts with %PDF', () async {
    final dir = await Directory.systemTemp.createTemp('pdf_test');
    addTearDown(() => dir.delete(recursive: true));
    final f = File('${dir.path}/img.jpg');
    final image = img.Image(width: 400, height: 300);
    img.fill(image, color: img.ColorRgb8(230, 230, 230));
    for (var x = 20; x < 380; x++) {
      image.setPixelRgb(x, 150, 0, 0, 0);
    }
    await f.writeAsBytes(img.encodeJpg(image, quality: 90));

    const options = LayoutOptions(mode: PrintMode.exam);
    final pages = const PrintLayoutEngine().layout(
      questions: <PrintDocQuestion>[
        PrintDocQuestion(
          displayNo: '1.',
          originalNumber: '3',
          knowledgePoint: '二次函数',
          source: '期中卷',
          answerSpaceMm: 40,
          blocks: <PrintImageBlock>[
            PrintImageBlock(aspect: 400 / 300, imagePath: f.path),
          ],
        ),
      ],
      options: options,
    );

    final bytes = await PdfPrintService().build(pages: pages, options: options);
    expect(bytes.length, greaterThan(1000));
    expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
  });
}

import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:smart_wrong_notebook/src/mistake/ai/ai_models.dart';
import 'package:smart_wrong_notebook/src/mistake/cleaning/cleaning_service.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/print/layout_engine.dart';

/// 从数据库装载打印文档（Question 与 AI 生成题）。
Future<List<PrintDocQuestion>> loadPrintDocs(
  MistakeDatabase db,
  CleaningService cleaning, {
  bool includeAnswers = false,
  Map<int, int>? answerSpaceOverrideByItem,
}) async {
  final items = await db.listPrintItems();
  final docs = <PrintDocQuestion>[];
  var no = 1;
  for (final item in items) {
    final space = item.answerSpaceMm;
    if (item.kind == 'question' && item.questionId != null) {
      final q = await db.questionById(item.questionId!);
      if (q == null) continue;
      final understanding = await db.understandingOf(q.id);
      final paper = q.paperId != 0 ? await db.paperById(q.paperId) : null;
      final blocks = await db.blocksOfQuestion(q.id);
      final imgs = <PrintImageBlock>[];
      for (final b in blocks) {
        final path = await cleaning.printablePathOf(b.id);
        if (path == null) continue;
        final aspect = await imageAspect(path) ?? 1.3;
        imgs.add(PrintImageBlock(aspect: aspect, imagePath: path));
      }
      final number = q.originalQuestionNumber ?? '';
      docs.add(PrintDocQuestion(
        displayNo: '$no.',
        originalNumber: number,
        source: paper?.title,
        knowledgePoint: q.knowledgePoint ?? understanding?.knowledgePoint,
        blocks: imgs,
        answerText: understanding == null
            ? null
            : (_answerText(understanding.answer, understanding.solution)),
        answerSpaceMm: space,
        scaleOverride: item.scaleOverride,
        showSource: item.showSource,
        showOriginalNumber: item.showOriginalNumber,
        showAnswer: includeAnswers && item.showAnswer,
      ));
      no++;
    } else if (item.kind == 'exercise' && item.exerciseId != null) {
      final rows = await (db.select(db.generatedExercises)
            ..where((t) => t.id.equals(item.exerciseId!)))
          .get();
      if (rows.isEmpty) continue;
      final g = rows.single;
      final content = AiExerciseFields.fromStoredJson(g.contentJson);
      final src = await db.questionById(g.sourceQuestionId);
      docs.add(PrintDocQuestion(
        displayNo: '$no.',
        originalNumber: src?.originalQuestionNumber,
        source: '举一反三',
        knowledgePoint: content?.knowledgePoint,
        blocks: const <PrintImageBlock>[],
        answerText: content?.answer,
        answerSpaceMm: space,
        showAnswer: includeAnswers && item.showAnswer,
      ));
      no++;
    }
  }
  return docs;
}

String? _answerText(String? answer, String? solution) {
  final a = (answer ?? '').trim();
  final s = (solution ?? '').trim();
  if (a.isEmpty) return s.isEmpty ? null : s;
  if (s.isEmpty) return a;
  return '$a\n$s';
}

Future<double?> imageAspect(String path) async {
  try {
    final bytes = await File(path).readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) return null;
    return decoded.width / decoded.height;
  } catch (_) {
    return null;
  }
}

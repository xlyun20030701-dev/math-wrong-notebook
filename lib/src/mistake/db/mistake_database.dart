import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'mistake_database.g.dart';

/// 个人本地数学错题整理 App 的数据库。
///
/// 与旧的 AI 错题本数据库相互独立，不共享任何表。
@DriftDatabase(tables: [
  Papers,
  Pages,
  Questions,
  Blocks,
  AnswerResources,
])
class MistakeDatabase extends _$MistakeDatabase {
  MistakeDatabase._internal(super.e);

  /// 打开默认位于应用文档目录下的本地数据库。
  factory MistakeDatabase() {
    return MistakeDatabase._internal(_openConnection());
  }

  MistakeDatabase.memory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  // --- Paper ---

  Stream<List<Paper>> watchPapers() {
    final query = select(papers)
      ..orderBy([
        (t) => OrderingTerm.desc(t.updatedAt),
        (t) => OrderingTerm.desc(t.createdAt),
      ]);
    return query.watch();
  }

  Future<Paper?> paperById(int id) =>
      (select(papers)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<Paper?> watchPaper(int id) =>
      (select(papers)..where((t) => t.id.equals(id))).watchSingleOrNull();

  Future<int> insertPaper({
    required String title,
    String? subject,
    DateTime? examDate,
    String? school,
    String? grade,
    String? note,
  }) {
    final now = DateTime.now();
    return into(papers).insert(PapersCompanion.insert(
      title: title,
      subject: Value(subject),
      examDate: Value(examDate),
      school: Value(school),
      grade: Value(grade),
      note: Value(note),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));
  }

  Future<void> updatePaper(int id, PapersCompanion companion) =>
      (update(papers)..where((t) => t.id.equals(id)))
          .write(companion.copyWith(updatedAt: Value(DateTime.now())));

  Future<void> deletePaper(int id) =>
      (delete(papers)..where((t) => t.id.equals(id))).go();

  // --- Page ---

  Stream<List<PageRecord>> watchPagesOfPaper(int paperId) {
    final query = select(pages)
      ..where((t) => t.paperId.equals(paperId))
      ..orderBy([(t) => OrderingTerm.asc(t.pageIndex)]);
    return query.watch();
  }

  Future<PageRecord?> pageById(int id) =>
      (select(pages)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<PageRecord?> watchPage(int id) =>
      (select(pages)..where((t) => t.id.equals(id))).watchSingleOrNull();

  Future<int> insertPage({
    required int paperId,
    required String originalImagePath,
    required int pageIndex,
    int? width,
    int? height,
    double? qualityScore,
    double? blurScore,
    double? exposureScore,
    bool perspectiveWarning = false,
  }) =>
      into(pages).insert(PagesCompanion.insert(
        paperId: paperId,
        originalImagePath: originalImagePath,
        pageIndex: pageIndex,
        width: Value(width),
        height: Value(height),
        qualityScore: Value(qualityScore),
        blurScore: Value(blurScore),
        exposureScore: Value(exposureScore),
        perspectiveWarning: Value(perspectiveWarning),
      ));

  Future<void> deletePage(int pageId) =>
      (delete(pages)..where((t) => t.id.equals(pageId))).go();

  // --- Question ---

  Stream<List<Question>> watchQuestions() {
    final query = select(questions)
      ..orderBy([
        (t) => OrderingTerm.desc(t.updatedAt),
        (t) => OrderingTerm.desc(t.createdAt),
      ]);
    return query.watch();
  }

  Stream<List<Question>> watchQuestionsOfPaper(int paperId) {
    final query = select(questions)
      ..where((t) => t.paperId.equals(paperId))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    return query.watch();
  }

  Future<List<Question>> questionsOfPaper(int paperId) =>
      (select(questions)..where((t) => t.paperId.equals(paperId)))
          .get();

  Future<Question?> questionById(int id) =>
      (select(questions)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<Question?> watchQuestion(int id) =>
      (select(questions)..where((t) => t.id.equals(id))).watchSingleOrNull();

  Future<int> insertQuestion({
    required int paperId,
    String? originalQuestionNumber,
    String? title,
    String? knowledgePoint,
    List<String> tags = const <String>[],
    String? note,
  }) {
    final now = DateTime.now();
    return into(questions).insert(QuestionsCompanion.insert(
      paperId: paperId,
      originalQuestionNumber: Value(originalQuestionNumber),
      title: Value(title),
      knowledgePoint: Value(knowledgePoint),
      tags: Value(_encodeTags(tags)),
      note: Value(note),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));
  }

  Future<void> updateQuestion(int id, QuestionsCompanion companion) =>
      (update(questions)..where((t) => t.id.equals(id)))
          .write(companion.copyWith(updatedAt: Value(DateTime.now())));

  Future<void> deleteQuestion(int id) =>
      (delete(questions)..where((t) => t.id.equals(id))).go();

  // --- Block ---

  Stream<List<Block>> watchBlocksOfQuestion(int questionId) {
    final query = select(blocks)
      ..where((t) => t.questionId.equals(questionId))
      ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]);
    return query.watch();
  }

  Future<List<Block>> blocksOfQuestion(int questionId) =>
      (select(blocks)
            ..where((t) => t.questionId.equals(questionId))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .get();

  Future<int> insertBlock({
    required int questionId,
    required int pageId,
    required String blockType,
    required double x,
    required double y,
    required double width,
    required double height,
    int sortOrder = 0,
    String? processedImagePath,
    String processingStatus = 'cropped',
    double? printScaleOverride,
  }) =>
      into(blocks).insert(BlocksCompanion.insert(
        questionId: questionId,
        pageId: pageId,
        blockType: blockType,
        x: x,
        y: y,
        width: width,
        height: height,
        sortOrder: Value(sortOrder),
        processedImagePath: Value(processedImagePath),
        processingStatus: Value(processingStatus),
        printScaleOverride: Value(printScaleOverride),
      ));

  Future<void> deleteBlock(int blockId) =>
      (delete(blocks)..where((t) => t.id.equals(blockId))).go();

  /// 用新顺序整体重写题目的 block sortOrder。
  Future<void> reorderBlocks(int questionId, List<int> blockIds) async {
    await transaction(() async {
      for (var i = 0; i < blockIds.length; i++) {
        await (update(blocks)..where((t) => t.id.equals(blockIds[i])))
            .write(BlocksCompanion(sortOrder: Value(i)));
      }
      await (update(questions)..where((t) => t.id.equals(questionId)))
          .write(QuestionsCompanion(updatedAt: Value(DateTime.now())));
    });
  }

  // --- AnswerResource ---

  Stream<List<AnswerResource>> watchAnswersOfQuestion(int questionId) =>
      (select(answerResources)
            ..where((t) => t.questionId.equals(questionId)))
          .watch();

  Future<int> insertAnswerResource({
    required int questionId,
    String type = 'answer',
    String format = 'text',
    String sourceType = 'other',
    String? sourceDescription,
    String? contentText,
    String? imagePath,
    bool isVerified = false,
  }) =>
      into(answerResources).insert(AnswerResourcesCompanion.insert(
        questionId: questionId,
        type: Value(type),
        format: Value(format),
        sourceType: Value(sourceType),
        sourceDescription: Value(sourceDescription),
        contentText: Value(contentText),
        imagePath: Value(imagePath),
        isVerified: Value(isVerified),
      ));

  Future<void> deleteAnswerResource(int id) =>
      (delete(answerResources)..where((t) => t.id.equals(id))).go();

  // --- Helpers ---

  static List<String> decodeTags(String json) {
    if (json.isEmpty) return const <String>[];
    try {
      return (const JsonCodec().decode(json) as List<dynamic>)
          .cast<String>();
    } catch (_) {
      return const <String>[];
    }
  }

  static String _encodeTags(List<String> tags) =>
      const JsonCodec().encode(tags);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    try {
      final folder = await getApplicationDocumentsDirectory();
      final file = File(p.join(folder.path, 'math_wrong_notebook.db'));
      return NativeDatabase.createInBackground(file);
    } catch (_) {
      return NativeDatabase.memory();
    }
  });
}

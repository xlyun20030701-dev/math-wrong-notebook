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
  BlockVersions,
  AiUnderstandings,
  AiMistakes,
  GeneratedExercises,
  PrintItems,
])
class MistakeDatabase extends _$MistakeDatabase {
  MistakeDatabase._internal(super.e);

  /// 打开默认位于应用文档目录下的本地数据库。
  factory MistakeDatabase() {
    return MistakeDatabase._internal(_openConnection());
  }

  MistakeDatabase.memory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(questions, questions.questionType);
            await migrator.addColumn(questions, questions.difficulty);
            await migrator.createTable(blockVersions);
            await migrator.createTable(aiUnderstandings);
            await migrator.createTable(aiMistakes);
            await migrator.createTable(generatedExercises);
            await migrator.createTable(printItems);
          }
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

  // 注意：Phase 1 未实现透视/倾斜检测，[perspectiveWarning] 恒为 false
  // （含义是“尚未检测”，而非“已检测且无倾斜”）。
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

  /// 删除某一页后自动把同一试卷的 pageIndex 重排为 1..n，避免跳号/重复。
  Future<void> deletePageAndResequence(int pageId) async {
    final page = await pageById(pageId);
    if (page == null) return;
    await (delete(pages)..where((t) => t.id.equals(pageId))).go();
    await resequencePageIndexes(page.paperId);
  }

  /// 按 pageIndex（其次 createdAt）把某试卷页面重排为连续 1..n。
  Future<void> resequencePageIndexes(int paperId) async {
    final rows = await (select(pages)
          ..where((t) => t.paperId.equals(paperId))
          ..orderBy([
            (t) => OrderingTerm.asc(t.pageIndex),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .get();
    await transaction(() async {
      for (var i = 0; i < rows.length; i++) {
        if (rows[i].pageIndex != i + 1) {
          await (update(pages)..where((t) => t.id.equals(rows[i].id)))
              .write(PagesCompanion(pageIndex: Value(i + 1)));
        }
      }
    });
  }

  /// 新增页应使用的下一个 pageIndex（= 当前最大值 + 1，避免重复）。
  Future<int> nextPageIndex(int paperId) async {
    final rows =
        await (select(pages)..where((t) => t.paperId.equals(paperId))).get();
    var maxIndex = 0;
    for (final row in rows) {
      if (row.pageIndex > maxIndex) maxIndex = row.pageIndex;
    }
    return maxIndex + 1;
  }

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

  Future<Block?> blockById(int blockId) =>
      (select(blocks)..where((t) => t.id.equals(blockId))).getSingleOrNull();

  Stream<Block?> watchBlock(int blockId) =>
      (select(blocks)..where((t) => t.id.equals(blockId))).watchSingleOrNull();

  Future<void> updateBlockType(int blockId, String blockType) {
    if (!kBlockTypes.contains(blockType)) {
      throw ArgumentError.value(blockType, 'blockType', '未知的区块类型');
    }
    return (update(blocks)..where((t) => t.id.equals(blockId)))
        .write(BlocksCompanion(blockType: Value(blockType)));
  }

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
  }) {
    _validateBlock(
      blockType: blockType,
      x: x,
      y: y,
      width: width,
      height: height,
      processingStatus: processingStatus,
      printScaleOverride: printScaleOverride,
    );
    return into(blocks).insert(BlocksCompanion.insert(
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
  }

  /// 下一个可用的 sortOrder（当前最大值 + 1），避免删除块后出现重复序号。
  Future<int> nextSortOrder(int questionId) async {
    final rows = await (select(blocks)
          ..where((t) => t.questionId.equals(questionId)))
        .get();
    var maxOrder = -1;
    for (final row in rows) {
      if (row.sortOrder > maxOrder) maxOrder = row.sortOrder;
    }
    return maxOrder + 1;
  }

  /// 数据库入库前的集中校验（UI 与裁剪服务之外的兜底防线）。
  void _validateBlock({
    required String blockType,
    required double x,
    required double y,
    required double width,
    required double height,
    required String processingStatus,
    double? printScaleOverride,
  }) {
    const double epsilon = 1e-6;
    if (!kBlockTypes.contains(blockType)) {
      throw ArgumentError.value(blockType, 'blockType', '未知的区块类型');
    }
    if (!kBlockProcessingStatuses.contains(processingStatus)) {
      throw ArgumentError.value(
          processingStatus, 'processingStatus', '未知的处理状态');
    }
    if (printScaleOverride != null &&
        (printScaleOverride <= 0 || printScaleOverride > 10)) {
      throw ArgumentError.value(
          printScaleOverride, 'printScaleOverride', '缩放必须大于 0 且不超过 10');
    }
    if (x.isNaN || y.isNaN || width.isNaN || height.isNaN) {
      throw ArgumentError('区块坐标不能为 NaN');
    }
    if (x < -epsilon ||
        y < -epsilon ||
        width <= epsilon ||
        height <= epsilon) {
      throw ArgumentError('区块必须位于图片内且具有正面积');
    }
    if (x >= 1.0 || y >= 1.0) {
      throw ArgumentError('区块左上角必须小于 1.0');
    }
    if (x + width > 1.0 + epsilon || y + height > 1.0 + epsilon) {
      throw ArgumentError('区块超出归一化图片范围');
    }
  }

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

  // --- BlockVersion ---

  Stream<List<BlockVersion>> watchBlockVersions(int blockId) =>
      (select(blockVersions)
            ..where((t) => t.blockId.equals(blockId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch();

  Future<int> insertBlockVersion(BlockVersionsCompanion companion) =>
      into(blockVersions).insert(companion);

  /// 把该 block 其余版本的 useForPrint 置 false，仅保留 [versionId] 为 true。
  Future<void> setPrintVersion(int blockId, int versionId) async {
    await transaction(() async {
      await (update(blockVersions)..where((t) => t.blockId.equals(blockId)))
          .write(const BlockVersionsCompanion(useForPrint: Value(false)));
      await (update(blockVersions)..where((t) => t.id.equals(versionId)))
          .write(const BlockVersionsCompanion(useForPrint: Value(true)));
    });
  }

  Future<void> setBlockVersionVerified(int versionId, bool verified) =>
      (update(blockVersions)..where((t) => t.id.equals(versionId)))
          .write(BlockVersionsCompanion(verified: Value(verified)));

  Future<void> deleteBlockVersion(int versionId) =>
      (delete(blockVersions)..where((t) => t.id.equals(versionId))).go();

  // --- AiUnderstanding (每 Question 单条，upsert) ---

  Stream<AiUnderstanding?> watchUnderstanding(int questionId) =>
      (select(aiUnderstandings)
            ..where((t) => t.questionId.equals(questionId)))
          .watchSingleOrNull();

  Future<AiUnderstanding?> understandingOf(int questionId) =>
      (select(aiUnderstandings)
            ..where((t) => t.questionId.equals(questionId)))
          .getSingleOrNull();

  Future<void> upsertUnderstanding(
    int questionId,
    AiUnderstandingsCompanion data,
  ) async {
    final existing = await (select(aiUnderstandings)
          ..where((t) => t.questionId.equals(questionId)))
        .getSingleOrNull();
    final base = data.copyWith(questionId: Value(questionId));
    if (existing == null) {
      await into(aiUnderstandings).insert(base);
    } else {
      await (update(aiUnderstandings)..where((t) => t.id.equals(existing.id)))
          .write(base);
    }
  }

  // --- AiMistake (每 Question 单条，upsert) ---

  Stream<AiMistake?> watchMistake(int questionId) =>
      (select(aiMistakes)..where((t) => t.questionId.equals(questionId)))
          .watchSingleOrNull();

  Future<void> upsertMistake(int questionId, AiMistakesCompanion data) async {
    final existing =
        await (select(aiMistakes)..where((t) => t.questionId.equals(questionId)))
            .getSingleOrNull();
    final base = data.copyWith(questionId: Value(questionId));
    if (existing == null) {
      await into(aiMistakes).insert(base);
    } else {
      await (update(aiMistakes)..where((t) => t.id.equals(existing.id)))
          .write(base);
    }
  }

  // --- GeneratedExercise ---

  Stream<List<GeneratedExercise>> watchGeneratedOfQuestion(int questionId) =>
      (select(generatedExercises)
            ..where((t) => t.sourceQuestionId.equals(questionId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch();

  Future<int> insertGeneratedExercise({
    required int sourceQuestionId,
    required String difficulty,
    required String contentJson,
  }) =>
      into(generatedExercises).insert(GeneratedExercisesCompanion.insert(
        sourceQuestionId: sourceQuestionId,
        difficulty: difficulty,
        contentJson: contentJson,
      ));

  Future<void> deleteGeneratedExercise(int id) =>
      (delete(generatedExercises)..where((t) => t.id.equals(id))).go();

  // --- PrintItem ---

  Stream<List<PrintItem>> watchPrintItems() {
    final query = select(printItems)
      ..orderBy([(t) => OrderingTerm.asc(t.order)]);
    return query.watch();
  }

  Future<List<PrintItem>> listPrintItems() {
    final query = select(printItems)
      ..orderBy([(t) => OrderingTerm.asc(t.order)]);
    return query.get();
  }

  Future<void> updatePrintItem(int id, PrintItemsCompanion companion) =>
      (update(printItems)..where((t) => t.id.equals(id))).write(companion);

  Future<void> deletePrintItem(int id) =>
      (delete(printItems)..where((t) => t.id.equals(id))).go();

  /// 整体重排打印项 order（0..n-1）。
  Future<void> reorderPrintItems(List<int> ids) async {
    await transaction(() async {
      for (var i = 0; i < ids.length; i++) {
        await (update(printItems)..where((t) => t.id.equals(ids[i])))
            .write(PrintItemsCompanion(order: Value(i)));
      }
    });
  }

  /// 追加到打印列表末尾（order=当前最大+1）。
  Future<int> appendPrintItem(PrintItemsCompanion data) async {
    final rows = await (select(printItems)).get();
    var maxOrder = -1;
    for (final r in rows) {
      if (r.order > maxOrder) maxOrder = r.order;
    }
    final base = data.copyWith(order: Value(maxOrder + 1));
    return into(printItems).insert(base);
  }

  /// 该 question/exercise 是否已在打印列表。
  Future<bool> printItemExists({int? questionId, int? exerciseId}) async {
    final q = select(printItems);
    if (questionId != null) {
      q.where((t) => t.questionId.equals(questionId));
    } else if (exerciseId != null) {
      q.where((t) => t.exerciseId.equals(exerciseId));
    } else {
      return false;
    }
    final rows = await q.get();
    return rows.isNotEmpty;
  }

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

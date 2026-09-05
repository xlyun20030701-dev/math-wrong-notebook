import 'package:flutter_test/flutter_test.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';

void main() {
  late MistakeDatabase db;

  setUp(() {
    db = MistakeDatabase.memory();
  });

  tearDown(() async {
    await db.close();
  });

  test('paper/page/question/block round trip and cascades', () async {
    final paperId = await db.insertPaper(title: '期中考试', subject: '数学');
    expect(paperId, greaterThan(0));

    final page1 = await db.insertPage(
      paperId: paperId,
      originalImagePath: '/tmp/page1.jpg',
      pageIndex: 1,
      width: 1200,
      height: 1600,
      qualityScore: 80,
      blurScore: 120,
      exposureScore: 88,
    );
    final page2 = await db.insertPage(
      paperId: paperId,
      originalImagePath: '/tmp/page2.jpg',
      pageIndex: 2,
    );

    final qid = await db.insertQuestion(
      paperId: paperId,
      originalQuestionNumber: '3',
      title: '二次函数',
      tags: const <String>['易错', '图像'],
    );
    expect(qid, greaterThan(0));

    final b1 = await db.insertBlock(
      questionId: qid,
      pageId: page1,
      blockType: 'stem',
      x: 0.1,
      y: 0.2,
      width: 0.4,
      height: 0.1,
      sortOrder: 0,
    );
    final b2 = await db.insertBlock(
      questionId: qid,
      pageId: page2,
      blockType: 'continuation',
      x: 0.5,
      y: 0.6,
      width: 0.3,
      height: 0.2,
      sortOrder: 1,
    );
    final b3 = await db.insertBlock(
      questionId: qid,
      pageId: page1,
      blockType: 'figure',
      x: 0.2,
      y: 0.5,
      width: 0.5,
      height: 0.3,
      sortOrder: 2,
    );

    // 答案资源
    final answerId = await db.insertAnswerResource(
      questionId: qid,
      type: 'solution',
      sourceType: 'answerSheet',
      contentText: '顶点式推导',
      isVerified: true,
    );
    expect(answerId, greaterThan(0));

    // 查询
    final pages = await db.watchPagesOfPaper(paperId).first;
    expect(pages, hasLength(2));
    expect(pages.first.pageIndex, 1);
    expect(pages.first.qualityScore, 80);

    final questions = await db.watchQuestionsOfPaper(paperId).first;
    expect(questions, hasLength(1));

    final question = (await db.questionById(qid))!;
    expect(MistakeDatabase.decodeTags(question.tags), contains('易错'));

    var blocks = await db.blocksOfQuestion(qid);
    expect(blocks, hasLength(3));
    expect(blocks.map((b) => b.id), <int>[b1, b2, b3]);

    // 拖动排序重写
    await db.reorderBlocks(qid, <int>[b3, b1, b2]);
    blocks = await db.blocksOfQuestion(qid);
    expect(blocks.map((b) => b.id), <int>[b3, b1, b2]);
    expect(blocks.first.sortOrder, 0);

    final answers = await db.watchAnswersOfQuestion(qid).first;
    expect(answers, hasLength(1));
    expect(answers.first.sourceType, 'answerSheet');

    // 级联删除：删错题 -> blocks 清空
    await db.deleteQuestion(qid);
    expect(await db.blocksOfQuestion(qid), isEmpty);
    expect(await db.watchAnswersOfQuestion(qid).first, isEmpty);

    // 级联删除：删试卷 -> pages & questions 清空
    await db.deletePaper(paperId);
    expect(await db.watchPagesOfPaper(paperId).first, isEmpty);
    expect(await db.watchQuestionsOfPaper(paperId).first, isEmpty);
  });

  test('block insert validates normalized coords, type, status and scale',
      () async {
    final paperId = await db.insertPaper(title: 'p');
    final pageId = await db.insertPage(
        paperId: paperId, originalImagePath: 'x', pageIndex: 1);
    final qid = await db.insertQuestion(
        paperId: paperId, originalQuestionNumber: '1');

    Future<void> bad({
      String? blockType,
      String? status,
      double? scale,
      double x = 0.1,
      double y = 0.1,
      double width = 0.4,
      double height = 0.4,
    }) {
      return expectLater(
        () => db.insertBlock(
          questionId: qid,
          pageId: pageId,
          blockType: blockType ?? 'stem',
          x: x,
          y: y,
          width: width,
          height: height,
          processingStatus: status ?? 'cropped',
          printScaleOverride: scale,
        ),
        throwsArgumentError,
      );
    }

    // 合法插入一次。
    await db.insertBlock(
        questionId: qid,
        pageId: pageId,
        blockType: 'stem',
        x: 0.1,
        y: 0.1,
        width: 0.4,
        height: 0.4);

    await bad(blockType: 'unknown');
    await bad(status: 'weird');
    await bad(scale: 0);
    await bad(scale: 11);
    await bad(x: -0.1);
    await bad(width: 0);
    await bad(x: 0.9, width: 0.2);
    await bad(y: 0.9, height: 0.2);
    await bad(x: 1.0, width: 0.1);
    await bad(width: double.nan);
  });

  test('pageIndex never duplicates after gaps; resequence fills holes',
      () async {
    final paperId = await db.insertPaper(title: 'pages');
    // 直接造出 1 和 3 的“跳号”场景。
    await db.insertPage(
        paperId: paperId, originalImagePath: 'a', pageIndex: 1);
    final page3 = await db.insertPage(
        paperId: paperId, originalImagePath: 'b', pageIndex: 3);

    // 即使当前只有 1、3，新增页也必须取 max+1=4，而不是取 2 与 3 重复。
    expect(await db.nextPageIndex(paperId), 4);

    // 删除第 3 页后自动重排为 1。
    await db.deletePageAndResequence(page3);
    final pages = await db.watchPagesOfPaper(paperId).first;
    expect(pages, hasLength(1));
    expect(pages.first.pageIndex, 1);
    expect(await db.nextPageIndex(paperId), 2);
  });

  test('nextSortOrder avoids duplicates after block deletion', () async {
    final paperId = await db.insertPaper(title: 's');
    final pageId = await db.insertPage(
        paperId: paperId, originalImagePath: 'x', pageIndex: 1);
    final qid = await db.insertQuestion(
        paperId: paperId, originalQuestionNumber: '1');
    final b1 = await db.insertBlock(
        questionId: qid,
        pageId: pageId,
        blockType: 'stem',
        x: 0.1,
        y: 0.1,
        width: 0.4,
        height: 0.4,
        sortOrder: 0);
    final b2 = await db.insertBlock(
        questionId: qid,
        pageId: pageId,
        blockType: 'figure',
        x: 0.2,
        y: 0.2,
        width: 0.4,
        height: 0.4,
        sortOrder: await db.nextSortOrder(qid));
    expect(await db.nextSortOrder(qid), 2);

    // 删除靠前的块后，新序号仍不与现存重复。
    await db.deleteBlock(b1);
    expect(await db.nextSortOrder(qid), 2);
    final order2 = await db.insertBlock(
        questionId: qid,
        pageId: pageId,
        blockType: 'answer',
        x: 0.3,
        y: 0.3,
        width: 0.4,
        height: 0.4,
        sortOrder: await db.nextSortOrder(qid));
    final remaining = await db.blocksOfQuestion(qid);
    expect(remaining.map((b) => b.sortOrder).toSet(), <int>{1, 2});
    await db.deleteBlock(b2);
    await db.deleteBlock(order2);
  });
}

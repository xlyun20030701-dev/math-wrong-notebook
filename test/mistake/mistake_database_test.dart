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
}

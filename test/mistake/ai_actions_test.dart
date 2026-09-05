import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:smart_wrong_notebook/src/mistake/ai/ai_actions.dart';
import 'package:smart_wrong_notebook/src/mistake/ai/ai_chat_client.dart';
import 'package:smart_wrong_notebook/src/mistake/ai/ai_settings.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';

void main() {
  late MistakeDatabase db;
  late MemoryAiSettingsStore settings;
  final chat = FakeAiChatClient();

  setUp(() {
    db = MistakeDatabase.memory();
    settings = MemoryAiSettingsStore();
    chat.error = null;
  });

  tearDown(() => db.close());

  AiActions actions() => AiActions(db: db, chat: chat, settings: settings);

  Future<int> seedQuestion() async {
    final pid = await db.insertPaper(title: 'p');
    final pageId = await db.insertPage(
        paperId: pid, originalImagePath: '/tmp/x.jpg', pageIndex: 1);
    final qid = await db.insertQuestion(
        paperId: pid, originalQuestionNumber: '3', title: '二次函数');
    final file = File('${Directory.systemTemp.path}/b_$qid.jpg');
    await file.writeAsBytes(img.encodeJpg(img.Image(width: 64, height: 64)));
    addTearDown(() => file.delete());
    await db.insertBlock(
      questionId: qid,
      pageId: pageId,
      blockType: 'stem',
      x: 0.1,
      y: 0.1,
      width: 0.4,
      height: 0.4,
      processedImagePath: file.path,
    );
    return qid;
  }

  test('understand persists structured fields and backfills question', () async {
    final qid = await seedQuestion();
    chat.response =
        '{"questionType":"解答题","knowledgePoint":"二次函数","difficulty":"中等","summary":"求顶点式","answer":"顶点(1,2)","solution":"配方","approach":"先配方"}';
    await actions().understand(qid);

    final u = await db.understandingOf(qid);
    expect(u, isNotNull);
    expect(u!.status, 'ok');
    expect(u.answer, '顶点(1,2)');
    expect(u.questionType, '解答题');
    expect(u.model, SecureAiSettingsStore.defaultModel);

    final q = await db.questionById(qid);
    expect(q!.questionType, '解答题');
    expect(q.difficulty, '中等');
    expect(q.knowledgePoint, '二次函数');
  });

  test('analyzeMistake persists errorType', () async {
    final qid = await seedQuestion();
    chat.response =
        '{"errorType":"sign","errorStep":"移项","reason":"移项没变号","reviewSuggestion":"重做三题"}';
    final fields = await actions().analyzeMistake(qid);
    expect(fields.errorType, 'sign');

    final m = await (db.select(db.aiMistakes)
          ..where((t) => t.questionId.equals(qid)))
        .getSingle();
    expect(m.errorType, 'sign');
    expect(m.reason, '移项没变号');
  });

  test('generateExercises persists the requested count', () async {
    final qid = await seedQuestion();
    chat.response = '['
        '{"question":"变式1","answer":"a","solution":"s","knowledgePoint":"k","difficulty":"基础","variation":"换数值"},'
        '{"question":"变式2","answer":"a2","solution":"s2","knowledgePoint":"k","difficulty":"基础","variation":"换情境"},'
        '{"question":"变式3","answer":"a3","solution":"s3","knowledgePoint":"k","difficulty":"基础","variation":"反设"}'
        ']';
    final list = await actions().generateExercises(qid, difficulty: 'easy', count: 3);
    expect(list, hasLength(3));

    final rows = await db.watchGeneratedOfQuestion(qid).first;
    expect(rows, hasLength(3));
  });

  test('api error propagates and is user-safe', () async {
    final qid = await seedQuestion();
    chat.error = AiApiException('网络超时，请检查网络后重试。');
    await expectLater(actions().understand(qid),
        throwsA(isA<AiApiException>().having((e) => e.message, 'msg', contains('网络超时'))));
  });

  test('detectPageRegions parses candidate boxes from a real image', () async {
    final dir = await Directory.systemTemp.createTemp('page_detect');
    addTearDown(() => dir.delete(recursive: true));
    final pid = await db.insertPaper(title: 'p');
    final file = File('${dir.path}/page.jpg');
    await file.writeAsBytes(img.encodeJpg(img.Image(width: 200, height: 280)));
    final pageId = await db.insertPage(
        paperId: pid, originalImagePath: file.path, pageIndex: 1);
    chat.response =
        '{"regions":[{"order":3,"x":0.1,"y":0.2,"width":0.5,"height":0.3},{"order":"7疑似","x":0.2,"y":0.6,"width":0.4,"height":0.25}]}';
    final regions = await actions().detectPageRegions(pageId);
    expect(regions, hasLength(2));
    expect(regions.last.label, '7疑似');
  });
}

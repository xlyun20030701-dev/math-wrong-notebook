import 'package:flutter_test/flutter_test.dart';
import 'package:smart_wrong_notebook/src/mistake/ai/ai_models.dart';

void main() {
  test('extractJsonMap strips fenced JSON', () {
    const text = '好的，结果如下：\n```json\n{"summary":"求二次函数顶点","difficulty":"中等"}\n```';
    final map = extractJsonMap(text);
    expect(map, isNotNull);
    expect(map!['summary'], '求二次函数顶点');
  });

  test('AiUnderstandingFields tolerates english and chinese keys', () {
    final m = extractJsonMap(
        '{"answer":"x=2","解析":"移项","knowledgePoint":"等式性质","difficulty":"基础"}')!;
    final f = AiUnderstandingFields.fromMap(m)!;
    expect(f.answer, 'x=2');
    expect(f.solution, '移项');
    expect(f.knowledgePoint, '等式性质');
  });

  test('AiMistakeFields coerces unknown errorType to unknown', () {
    final f = AiMistakeFields.fromMap(<String, dynamic>{
      'errorType': 'whatever',
      'reason': '符号看错',
    });
    expect(f.errorType, 'unknown');
    expect(f.reason, '符号看错');
  });

  test('AiExerciseFields top-level list and wrapped list both parse', () {
    const listJson = '[{"question":"q1","answer":"a1"},{"question":"q2","answer":"a2"}]';
    final direct = extractJsonList(listJson)!;
    expect(direct, hasLength(2));

    const wrapped = '{"exercises":[{"question":"q3","answer":"a3"}]}';
    final map = extractJsonMap(wrapped)!;
    expect(map['exercises'], hasLength(1));
  });

  test('AiPageRegion normalizes valid box and rejects invalid', () {
    final ok = AiPageRegion.fromMap(<String, dynamic>{
      'order': 3,
      'x': 0.1,
      'y': 0.2,
      'width': 0.4,
      'height': 0.3,
    });
    expect(ok, isNotNull);
    expect(ok!.order, 3);

    final bad = AiPageRegion.fromMap(<String, dynamic>{
      'x': 0.9,
      'y': 0.9,
      'width': 0.5,
      'height': 0.5,
    });
    expect(bad, isNull);
  });
}

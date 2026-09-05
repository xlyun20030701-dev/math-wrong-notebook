import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/block_select_screen.dart';

Question _existingQuestion(int id, String number) => Question(
      id: id,
      paperId: 1,
      originalQuestionNumber: number,
      title: null,
      knowledgePoint: null,
      questionType: null,
      difficulty: null,
      tags: '[]',
      note: null,
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    );

/// 打开底部面板并把返回值写回 [captured]。
Future<void> _openSheet(
  WidgetTester tester,
  List<Question> basket, {
  required void Function(BlockTargetSelection?) captured,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => Center(
            child: ElevatedButton(
              onPressed: () async {
                final result = await showModalBottomSheet<BlockTargetSelection>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => NewBlockTargetSheet(
                    blockType: 'stem',
                    basket: basket,
                    blockCounts: const <int, int>{},
                  ),
                );
                captured(result);
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
      '0 道错题：新建错题后点击输入框不退出，可输入并创建第一道错题',
      (tester) async {
    BlockTargetSelection? captured;
    await _openSheet(tester, const <Question>[],
        captured: (v) => captured = v);

    // 空错题篮：只有“新建错题”入口
    expect(find.text('本卷还没有错题，请新建。'), findsOneWidget);

    // 进入新建错题
    await tester.tap(find.text('新建错题'));
    await tester.pump();
    expect(find.text('原题号（如 3、7、11）'), findsOneWidget);

    // 点击输入框获得焦点
    await tester.tap(find.byType(TextField).first);
    await tester.pump();
    expect(find.text('原题号（如 3、7、11）'), findsOneWidget,
        reason: '点击输入框后不应退出新建错题界面');

    // 模拟键盘弹出导致的尺寸/viewInsets 变化（触发 modal route 重建，
    // 旧实现会因此丢失“正在新建”的状态并退回上一层）。
    tester.view.physicalSize = const Size(1080, 2280);
    addTearDown(tester.view.reset);
    await tester.pump();
    expect(find.text('原题号（如 3、7、11）'), findsOneWidget,
        reason: '重建后必须仍停留在新建错题界面');

    // 能输入文字
    await tester.enterText(find.byType(TextField).first, '3');
    await tester.pump();
    final field = tester.widget<TextField>(find.byType(TextField).first);
    expect(field.controller!.text, '3');

    // 仍在新建状态并可创建
    expect(find.text('创建并保存'), findsOneWidget);
    await tester.tap(find.text('创建并保存'));
    await tester.pumpAndSettle();

    expect(captured, isNotNull);
    expect(captured!.isNew, isTrue);
    expect(captured!.blockType, 'stem');
    expect(captured!.newQuestion!.number, '3');
  });

  testWidgets('已有错题可直接加入；新建流程随后仍可用', (tester) async {
    final results = <BlockTargetSelection>[];
    final q = _existingQuestion(7, '7');

    // 第一次：加入已有错题 Q7。
    await _openSheet(tester, <Question>[q],
        captured: (v) {
          if (v != null) results.add(v);
        });
    expect(find.textContaining('Q7'), findsOneWidget);
    await tester.tap(find.textContaining('Q7'));
    await tester.pumpAndSettle();
    expect(results.single.isNew, isFalse);
    expect(results.single.existingQuestionId, 7);
    expect(results.single.blockType, 'stem');

    // 第二次：错题篮非空时新建入口仍可用。
    await _openSheet(tester, <Question>[q],
        captured: (v) {
          if (v != null) results.add(v);
        });
    await tester.tap(find.text('新建错题'));
    await tester.pump();
    expect(find.text('原题号（如 3、7、11）'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, '11');
    await tester.pump();
    await tester.tap(find.text('创建并保存'));
    await tester.pumpAndSettle();
    expect(results.last.isNew, isTrue);
    expect(results.last.newQuestion!.number, '11');
  });
}

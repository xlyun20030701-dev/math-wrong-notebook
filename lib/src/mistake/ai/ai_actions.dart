import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:smart_wrong_notebook/src/mistake/ai/ai_chat_client.dart';
import 'package:smart_wrong_notebook/src/mistake/ai/ai_models.dart';
import 'package:smart_wrong_notebook/src/mistake/ai/ai_settings.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';

/// AI 动作统一封装：负责提示词、图像收集、JSON 解析与落库。
///
/// 绝不打印 API Key；每次调用均由用户主动触发。
class AiActions {
  AiActions({
    required MistakeDatabase db,
    required AiChatClient chat,
    required AiSettingsStore settings,
  })  : _db = db,
        _chat = chat,
        _settings = settings;

  final MistakeDatabase _db;
  final AiChatClient _chat;
  final AiSettingsStore _settings;

  Future<String> _model() => _settings.model();

  /// AI 识题：结构化理解题干，结果保存；成功时同步 Question 的题型/难度/知识点。
  Future<AiUnderstandingFields> understand(int questionId) async {
    final question = await _db.questionById(questionId);
    if (question == null) throw AiApiException('错题不存在。');
    final images = await _blockImages(questionId, const <String>['stem', 'option', 'figure']);
    final label = _label(question);
    const system = '你是一名中学数学老师。请阅读图片中的题目，返回严格的 JSON 对象，'
        '键使用英文：questionType, knowledgePoint, difficulty, summary, answer, solution, approach。'
        '不要输出 JSON 之外的内容。';
    final user = '这是错题（$label）的图片。请：\n'
        '1. 只描述图片里实际存在的数学内容，不要编造；\n'
        '2. summary 用一句话概括题目；\n'
        '3. difficulty 取值：基础/中等/困难；\n'
        '4. 若图片没有可读数学内容，也要给出结构化 JSON，summary 写“无法识别”。';
    final text = await _chat.chat(system: system, user: user, images: images);
    final map = extractJsonMap(text);
    if (map == null) throw AiApiException('AI 返回无法解析，请重试。');
    final fields = AiUnderstandingFields.fromMap(map);
    if (fields == null) throw AiApiException('AI 返回缺少有效内容，请重试。');
    await _db.upsertUnderstanding(questionId, AiUnderstandingsCompanion(
          status: const Value('ok'),
          questionType: Value(fields.questionType),
          knowledgePoint: Value(fields.knowledgePoint),
          difficulty: Value(fields.difficulty),
          summary: Value(fields.summary),
          answer: Value(fields.answer),
          solution: Value(fields.solution),
          approach: Value(fields.approach),
          rawJson: Value(_safeEncode(map)),
          model: Value(await _model()),
          error: const Value(null),
          updatedAt: Value(DateTime.now()),
        ));
    // 回填 Question 元信息（仅填空，不覆盖已手动填写值）。
    await _db.updateQuestion(questionId, QuestionsCompanion(
          questionType: Value(fields.questionType ?? question.questionType),
          difficulty: Value(fields.difficulty ?? question.difficulty),
          knowledgePoint:
              Value(fields.knowledgePoint ?? question.knowledgePoint),
        ));
    return fields;
  }

  /// AI 错因分析：结合 work/answer/teacherNote 等 Block。
  Future<AiMistakeFields> analyzeMistake(int questionId) async {
    final question = await _db.questionById(questionId);
    if (question == null) throw AiApiException('错题不存在。');
    final images = await _blockImages(
        questionId, const <String>['stem', 'figure', 'work', 'answer', 'teacherNote', 'solution']);
    const system = '你是一名中学数学老师，帮助学生分析错因。'
        '只输出 JSON：errorType, errorStep, reason, reviewSuggestion。'
        'errorType 只能取：calculation, concept, sign, reading, formula, careless, unknown。'
        '不要输出 JSON 之外内容。';
    final user = '这是错题（${_label(question)}）。请分析错因，中文表达原因与建议。';
    final text = await _chat.chat(system: system, user: user, images: images);
    final map = extractJsonMap(text);
    if (map == null) throw AiApiException('AI 返回无法解析，请重试。');
    final fields = AiMistakeFields.fromMap(map);
    if (fields.errorType.isEmpty) {
      throw AiApiException('AI 未返回有效错因，请重试。');
    }
    await _db.upsertMistake(questionId, AiMistakesCompanion(
          status: const Value('ok'),
          errorType: Value(fields.errorType),
          errorStep: Value(fields.errorStep),
          reason: Value(fields.reason),
          reviewSuggestion: Value(fields.reviewSuggestion),
          rawJson: Value(_safeEncode(map)),
          model: Value(await _model()),
          error: const Value(null),
          updatedAt: Value(DateTime.now()),
        ));
    return fields;
  }

  /// AI 举一反三：按难度/数量生成并保存到 generated_exercises。
  Future<List<AiExerciseFields>> generateExercises(
    int questionId, {
    required String difficulty,
    required int count,
  }) async {
    if (count != 1 && count != 3 && count != 5) count = 3;
    final question = await _db.questionById(questionId);
    if (question == null) throw AiApiException('错题不存在。');
    final images = await _blockImages(questionId, const <String>['stem', 'option', 'figure']);
    final understanding = await _db.understandingOf(questionId);
    final kp = understanding?.knowledgePoint;
    final knowledgeHint =
        (kp == null || kp.isEmpty) ? '' : '；本题核心知识点：$kp';
    const system = '你是一名中学数学老师。请基于原题生成真正考同一核心知识点、'
        '但非机械换数的变式题。只输出 JSON 数组，每项键：'
        'question, answer, solution, knowledgePoint, difficulty, variation。'
        '不要输出 JSON 之外内容。';
    final user = '原题（${_label(question)}）难度参考：$difficulty（easy=基础, same=同等, hard=提高）。'
        '请生成 $count 道变式题$knowledgeHint。';
    final text = await _chat.chat(system: system, user: user, images: images);
    final list = _extractExerciseList(text);
    if (list.isEmpty) throw AiApiException('AI 返回无法解析，请重试。');
    for (final e in list) {
      await _db.insertGeneratedExercise(
        sourceQuestionId: questionId,
        difficulty: difficulty,
        contentJson: e.toJson(),
      );
    }
    return list;
  }

  /// AI 检测整页题目区域（候选框，不自动入库）。
  Future<List<AiPageRegion>> detectPageRegions(int pageId) async {
    final page = await _db.pageById(pageId);
    if (page == null) throw AiApiException('页面不存在。');
    final file = File(page.originalImagePath);
    if (!await file.exists()) throw AiApiException('找不到页面原图。');
    final bytes = await file.readAsBytes();
    const system = '你是一名数学试卷分析助手。给定一张试卷页面图片，找出每一道题目区域。'
        '输出 JSON 对象：{"regions":[{"order":题号数字或字符串,"x":左上角归一化x,"y":...,"width":...,"height":...}]}。'
        '坐标统一为 0~1 的归一化值。只输出 JSON。';
    const user = '请框出页面上每一道题（题干+选项+图形区域）。'
        '同时如果发现疑似错题（有红叉、扣分、批注、明显订正），在题号后加前缀"疑似"，如"3疑似"。';
    final text = await _chat.chat(system: system, user: user, images: <Uint8List>[bytes]);
    final map = extractJsonMap(text);
    if (map == null) throw AiApiException('AI 返回无法解析，请重试。');
    final rawList = map['regions'];
    if (rawList is! List) throw AiApiException('AI 未返回题目区域。');
    final regions = <AiPageRegion>[];
    for (final raw in rawList) {
      if (raw is Map) {
        final r = AiPageRegion.fromMap(Map<String, dynamic>.from(raw));
        if (r != null) regions.add(r);
      }
    }
    if (regions.isEmpty) throw AiApiException('未检测到题目区域，可尝试重新拍摄清晰照片。');
    return regions;
  }

  // --- helpers ---

  Future<List<Uint8List>> _blockImages(
      int questionId, List<String> preferred) async {
    final blocks = await _db.blocksOfQuestion(questionId);
    final sorted = <Block>[];
    for (final type in preferred) {
      sorted.addAll(blocks.where((b) => b.blockType == type));
    }
    sorted.addAll(blocks.where((b) => !preferred.contains(b.blockType)));
    final result = <Uint8List>[];
    for (final b in sorted) {
      if (result.length >= 4) break;
      final p = b.processedImagePath;
      if (p == null || p.isEmpty) continue;
      try {
        final f = File(p);
        if (!await f.exists()) continue;
        final bytes = await f.readAsBytes();
        if (bytes.isEmpty || bytes.length > 6 * 1024 * 1024) continue;
        result.add(bytes);
      } catch (_) {}
    }
    return result;
  }

  String _label(Question q) {
    final n = (q.originalQuestionNumber ?? '').trim();
    if (n.isNotEmpty) return 'Q$n';
    return (q.title ?? '').trim().isEmpty ? '未命名' : q.title!.trim();
  }

  List<AiExerciseFields> _extractExerciseList(String text) {
    final direct = extractJsonList(text);
    if (direct != null) {
      final items = <AiExerciseFields>[];
      for (final raw in direct) {
        if (raw is Map) {
          final e = AiExerciseFields.fromMap(Map<String, dynamic>.from(raw));
          if (e != null) items.add(e);
        }
      }
      if (items.isNotEmpty) return items;
    }
    final map = extractJsonMap(text);
    if (map != null) {
      for (final key in const <String>['exercises', 'items', 'questions']) {
        final v = map[key];
        if (v is List) {
          final items = <AiExerciseFields>[];
          for (final raw in v) {
            if (raw is Map) {
              final e = AiExerciseFields.fromMap(Map<String, dynamic>.from(raw));
              if (e != null) items.add(e);
            }
          }
          if (items.isNotEmpty) return items;
        }
      }
    }
    return const <AiExerciseFields>[];
  }

  static String _safeEncode(Map<String, dynamic> map) {
    try {
      return const JsonEncoder().convert(map);
    } catch (_) {
      return '';
    }
  }
}


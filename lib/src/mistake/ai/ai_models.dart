import 'dart:convert';

import 'package:smart_wrong_notebook/src/mistake/db/tables.dart';

/// 宽松地从模型文本中抽取 JSON（去掉 markdown 代码围栏）。
Map<String, dynamic>? extractJsonMap(String text) {
  final raw = _extractJsonObject(text);
  if (raw == null) return null;
  try {
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) return decoded;
    if (decoded is Map) return Map<String, dynamic>.from(decoded);
    return null;
  } catch (_) {
    return null;
  }
}

List<dynamic>? extractJsonList(String text) {
  final start = text.indexOf('[');
  if (start < 0) return null;
  final end = _findClosing(text, start, '[', ']');
  if (end < 0) return null;
  try {
    final decoded = jsonDecode(text.substring(start, end + 1));
    return decoded is List ? decoded : null;
  } catch (_) {
    return null;
  }
}

String? _extractJsonObject(String text) {
  final fenced = RegExp(r'```(?:json)?\s*([\s\S]*?)```').firstMatch(text);
  final candidate = fenced == null ? text : fenced.group(1)!;
  final start = candidate.indexOf('{');
  if (start < 0) return null;
  final end = _findClosing(candidate, start, '{', '}');
  if (end < 0) return null;
  return candidate.substring(start, end + 1);
}

int _findClosing(String s, int open, String o, String c) {
  var depth = 0;
  var inString = false;
  var escape = false;
  for (var i = open; i < s.length; i++) {
    final ch = s[i];
    if (inString) {
      if (escape) {
        escape = false;
      } else if (ch == r'\') {
        escape = true;
      } else if (ch == '"') {
        inString = false;
      }
      continue;
    }
    if (ch == '"') {
      inString = true;
    } else if (ch == o) {
      depth++;
    } else if (ch == c) {
      depth--;
      if (depth == 0) return i;
    }
  }
  return -1;
}

String? _firstString(Map<String, dynamic> map, List<String> keys) {
  for (final k in keys) {
    final v = map[k];
    if (v is String && v.trim().isNotEmpty) return v.trim();
    if (v is num) return '$v';
  }
  return null;
}

double _num(Map<String, dynamic> map, List<String> keys, [double d = 0]) {
  for (final k in keys) {
    final v = map[k];
    if (v is num) return v.toDouble();
    if (v is String) {
      final p = double.tryParse(v);
      if (p != null) return p;
    }
  }
  return d;
}

/// AI 识题结构化结果。
class AiUnderstandingFields {
  const AiUnderstandingFields({
    this.questionType,
    this.knowledgePoint,
    this.difficulty,
    this.summary,
    this.answer,
    this.solution,
    this.approach,
  });

  final String? questionType;
  final String? knowledgePoint;
  final String? difficulty;
  final String? summary;
  final String? answer;
  final String? solution;
  final String? approach;

  static AiUnderstandingFields? fromMap(Map<String, dynamic> map) {
    final map2 = _unwrap(map);
    final any = _firstString(map2, <String>[
      'summary', 'question', 'stem', '题目摘要', '题干', '题目',
    ]);
    if (any == null && map2.isEmpty) return null;
    return AiUnderstandingFields(
      questionType: _firstString(map2, <String>['questionType', '题型', 'type']),
      knowledgePoint: _firstString(
          map2, <String>['knowledgePoint', '知识点', 'knowledge_point']),
      difficulty: _firstString(map2, <String>['difficulty', '难度']),
      summary: _firstString(map2, <String>[
        'summary', 'question', 'stem', '题目摘要', '题干', '题目', '摘要',
      ]),
      answer: _firstString(map2, <String>['answer', '答案']),
      solution: _firstString(map2, <String>['solution', '解析', '解答']),
      approach: _firstString(map2, <String>[
        'approach', 'thought', '解题思路', '思路', 'steps',
      ]),
    );
  }
}

/// AI 错因结构化结果。
class AiMistakeFields {
  const AiMistakeFields({
    required this.errorType,
    this.errorStep,
    this.reason,
    this.reviewSuggestion,
  });

  final String errorType;
  final String? errorStep;
  final String? reason;
  final String? reviewSuggestion;

  static AiMistakeFields fromMap(Map<String, dynamic> map) {
    final m = _unwrap(map);
    final rawType =
        _firstString(m, <String>['errorType', '错误类型', 'error_type']) ??
            'unknown';
    final type = kErrorTypes.contains(rawType) ? rawType : 'unknown';
    return AiMistakeFields(
      errorType: type,
      errorStep: _firstString(m, <String>['errorStep', '错误步骤', 'error_step']),
      reason: _firstString(m, <String>['reason', '原因', '错因']),
      reviewSuggestion: _firstString(m, <String>[
        'reviewSuggestion', '复习建议', 'review_suggestion', 'suggestion',
      ]),
    );
  }
}

/// 一道举一反三生成题。
class AiExerciseFields {
  const AiExerciseFields({
    required this.question,
    required this.answer,
    this.solution,
    this.knowledgePoint,
    this.difficulty,
    this.variation,
  });

  final String question;
  final String answer;
  final String? solution;
  final String? knowledgePoint;
  final String? difficulty;
  final String? variation;

  static AiExerciseFields? fromMap(Map<String, dynamic> map) {
    final m = _unwrap(map);
    final question =
        _firstString(m, <String>['question', '题目', 'stem']) ?? '';
    final answer = _firstString(m, <String>['answer', '答案']) ?? '';
    if (question.isEmpty) return null;
    return AiExerciseFields(
      question: question,
      answer: answer,
      solution: _firstString(m, <String>['solution', '解析', '解答']),
      knowledgePoint: _firstString(
          m, <String>['knowledgePoint', '知识点', 'knowledge_point']),
      difficulty: _firstString(m, <String>['difficulty', '难度']),
      variation: _firstString(
          m, <String>['variation', '与原题差异', '变化点', '变化']),
    );
  }

  String toJson() => const JsonEncoder().convert({
        'question': question,
        'answer': answer,
        'solution': solution,
        'knowledgePoint': knowledgePoint,
        'difficulty': difficulty,
        'variation': variation,
      });

  static AiExerciseFields? fromStoredJson(String json) {
    try {
      final decoded = jsonDecode(json);
      if (decoded is Map) return fromMap(Map<String, dynamic>.from(decoded));
    } catch (_) {}
    return null;
  }
}

/// AI 在整页图片上检测出的候选题目区域（归一化坐标）。
class AiPageRegion {
  const AiPageRegion({
    required this.order,
    this.label,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  final int order;
  final String? label;
  final double x;
  final double y;
  final double width;
  final double height;

  static AiPageRegion? fromMap(Map<String, dynamic> map) {
    final m = _unwrap(map);
    final x = _num(m, <String>['x', 'left']);
    final y = _num(m, <String>['y', 'top']);
    final width = _num(m, <String>['width', 'w', 'right'], -1);
    final height = _num(m, <String>['height', 'h', 'bottom'], -1);
    var w = width;
    var h = height;
    if (width < 0) {
      final right = _num(m, <String>['right'], 0);
      w = right - x;
    }
    if (height < 0) {
      final bottom = _num(m, <String>['bottom'], 0);
      h = bottom - y;
    }
    if (w <= 0 || h <= 0 || x < 0 || y < 0 || x + w > 1.01 || y + h > 1.01) {
      return null;
    }
    final orderRaw = m['order'] ?? m['index'] ?? m['题号'];
    final order = orderRaw is num ? orderRaw.toInt() : 0;
    final label = orderRaw is String ? orderRaw : null;
    return AiPageRegion(
      order: order,
      label: label,
      x: x.clamp(0.0, 1.0).toDouble(),
      y: y.clamp(0.0, 1.0).toDouble(),
      width: w.clamp(0.0, 1.0).toDouble(),
      height: h.clamp(0.0, 1.0).toDouble(),
    );
  }
}

Map<String, dynamic> _unwrap(Map<String, dynamic> map) {
  // 兼容模型把结果包在 result/data/questionAnalysis 等键下。
  for (final key in const <String>['result', 'data', 'analysis', 'question']) {
    final v = map[key];
    if (v is Map) {
      final inner = Map<String, dynamic>.from(v);
      return inner;
    }
  }
  return map;
}

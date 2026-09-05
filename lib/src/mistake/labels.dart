import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';

const Map<String, String> blockTypeLabels = <String, String>{
  'stem': '题干',
  'option': '选项',
  'continuation': '题目续接',
  'figure': '图形',
  'answer': '答案',
  'solution': '解答过程',
  'work': '答题过程',
  'teacherNote': '老师批注',
  'other': '其他',
};

const Map<String, String> answerTypeLabels = <String, String>{
  'answer': '答案',
  'solution': '解析',
  'hint': '提示',
};

const Map<String, String> answerSourceLabels = <String, String>{
  'originalPaper': '原试卷',
  'answerSheet': '答案册',
  'searchApp': '搜题软件',
  'ai': 'AI 平台',
  'manual': '手输',
  'screenshot': '截图',
  'teacher': '老师提供',
  'other': '其他',
};

const String kUnknownQuestionLabel = '?';

/// 列表/详情里展示错题编号（题号或标题）。
String questionDisplayLabel(Question q) {
  final number = (q.originalQuestionNumber ?? '').trim();
  if (number.isNotEmpty) return 'Q$number';
  final title = (q.title ?? '').trim();
  if (title.isNotEmpty) return title;
  return kUnknownQuestionLabel;
}

List<String> tagsOf(Question q) =>
    MistakeDatabase.decodeTags(q.tags);

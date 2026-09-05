import 'package:drift/drift.dart';

/// 一张试卷 / 一次考试。
@DataClassName('Paper')
class Papers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get subject => text().nullable()();
  DateTimeColumn get examDate => dateTime().nullable()();
  TextColumn get school => text().nullable()();
  TextColumn get grade => text().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}

/// 试卷的一张原始照片。原图永远保留。
@DataClassName('PageRecord')
class Pages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get paperId =>
      integer().references(Papers, #id, onDelete: KeyAction.cascade)();
  TextColumn get originalImagePath => text()();
  IntColumn get pageIndex => integer()();
  IntColumn get width => integer().nullable()();
  IntColumn get height => integer().nullable()();
  /// 总体质量 0~100，越高越好。
  RealColumn get qualityScore => real().nullable()();
  /// Laplacian 方差，越大越清晰。
  RealColumn get blurScore => real().nullable()();
  /// 曝光分 0~100。
  RealColumn get exposureScore => real().nullable()();
  /// 透视/倾斜警示。
  ///
  /// 说明：Phase 1 尚未实现透视/倾斜检测，本字段恒为 false（“尚未检测”），
  /// 不得被当作“已检测且无倾斜”来宣传。真正的几何透视检测在 Phase 2 实现。
  BoolColumn get perspectiveWarning =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}

/// 一道错题，由多个 Block 组成。
class Questions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get paperId =>
      integer().references(Papers, #id, onDelete: KeyAction.cascade)();
  TextColumn get originalQuestionNumber => text().nullable()();
  TextColumn get title => text().nullable()();
  TextColumn get knowledgePoint => text().nullable()();
  /// 题型，如：选择题/填空题/解答题/其他。
  TextColumn get questionType => text().nullable()();
  /// 难度：基础/中等/困难（本地保存，来源可为手动或 AI）。
  TextColumn get difficulty => text().nullable()();
  /// JSON 字符串数组，例如 '["二次函数","易错"]'。
  TextColumn get tags => text().withDefault(const Constant('[]'))();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}

/// 手动框选的一块图片区域（可来自不同 Page）。
@DataClassName('Block')
class Blocks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get questionId =>
      integer().references(Questions, #id, onDelete: KeyAction.cascade)();
  IntColumn get pageId =>
      integer().references(Pages, #id, onDelete: KeyAction.cascade)();
  /// blockType: stem / option / continuation / figure / answer /
  /// solution / work / teacherNote / other
  TextColumn get blockType => text()();
  /// 归一化坐标 0~1。
  RealColumn get x => real()();
  RealColumn get y => real()();
  RealColumn get width => real()();
  RealColumn get height => real()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  /// 裁剪后保存的区块图片（原图无修改）。
  TextColumn get processedImagePath => text().nullable()();
  /// none / cropped / processed
  TextColumn get processingStatus =>
      text().withDefault(const Constant('cropped'))();
  RealColumn get printScaleOverride => real().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}

/// 答案/解析资源，与 Question 分离（来源多样，仅供标签标记）。
@DataClassName('AnswerResource')
class AnswerResources extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get questionId =>
      integer().references(Questions, #id, onDelete: KeyAction.cascade)();
  /// answer / solution / hint
  TextColumn get type => text().withDefault(const Constant('answer'))();
  /// text / image / mixed
  TextColumn get format => text().withDefault(const Constant('text'))();
  /// originalPaper / answerSheet / searchApp / ai / manual /
  /// screenshot / teacher / other
  TextColumn get sourceType =>
      text().withDefault(const Constant('other'))();
  TextColumn get sourceDescription => text().nullable()();
  TextColumn get contentText => text().nullable()();
  TextColumn get imagePath => text().nullable()();
  BoolColumn get isVerified => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}

const List<String> kBlockTypes = <String>[
  'stem',
  'option',
  'continuation',
  'figure',
  'answer',
  'solution',
  'work',
  'teacherNote',
  'other',
];

/// Block 处理状态。Phase 2 引入真正的图像处理后才会写入 processed。
const Set<String> kBlockProcessingStatuses = <String>{
  'none',
  'cropped',
  'processed',
};

const List<String> kAnswerSourceTypes = <String>[
  'originalPaper',
  'answerSheet',
  'searchApp',
  'ai',
  'manual',
  'screenshot',
  'teacher',
  'other',
];

/// Block 图片版本方法。
const List<String> kImageVersions = <String>[
  'original',
  'traditional',
  'aiMaskLocal',
  'aiEdit',
  'manual',
];

/// 一张 Block 的派生图片版本（原图永远保留在 Page/block 原始路径中）。
@DataClassName('BlockVersion')
class BlockVersions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get blockId =>
      integer().references(Blocks, #id, onDelete: KeyAction.cascade)();
  /// original / traditional / aiMaskLocal / aiEdit / manual
  TextColumn get method => text()();
  TextColumn get sourceImagePath => text().nullable()();
  TextColumn get processedImagePath => text().nullable()();
  TextColumn get maskPath => text().nullable()();
  TextColumn get model => text().nullable()();
  BoolColumn get verified => boolean().withDefault(const Constant(false))();
  BoolColumn get useForPrint => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// AI 识题结果（每 Question 至多一条；可手动编辑覆盖）。
@DataClassName('AiUnderstanding')
class AiUnderstandings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get questionId =>
      integer().references(Questions, #id, onDelete: KeyAction.cascade)();
  /// none / ok / error
  TextColumn get status => text().withDefault(const Constant('none'))();
  TextColumn get questionType => text().nullable()();
  TextColumn get knowledgePoint => text().nullable()();
  TextColumn get difficulty => text().nullable()();
  TextColumn get summary => text().nullable()();
  TextColumn get answer => text().nullable()();
  TextColumn get solution => text().nullable()();
  TextColumn get approach => text().nullable()();
  TextColumn get rawJson => text().nullable()();
  TextColumn get model => text().nullable()();
  TextColumn get error => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// AI 错因分析（每 Question 至多一条；可手动编辑覆盖）。
@DataClassName('AiMistake')
class AiMistakes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get questionId =>
      integer().references(Questions, #id, onDelete: KeyAction.cascade)();
  /// none / ok / error
  TextColumn get status => text().withDefault(const Constant('none'))();
  TextColumn get errorType => text().nullable()();
  TextColumn get errorStep => text().nullable()();
  TextColumn get reason => text().nullable()();
  TextColumn get reviewSuggestion => text().nullable()();
  TextColumn get rawJson => text().nullable()();
  TextColumn get model => text().nullable()();
  TextColumn get error => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// AI 举一反三生成题（保存到本地，可加入打印）。
@DataClassName('GeneratedExercise')
class GeneratedExercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sourceQuestionId =>
      integer().references(Questions, #id, onDelete: KeyAction.cascade)();
  /// easy / same / hard（对应 基础/同等/提高）
  TextColumn get difficulty => text()();
  /// JSON: {question, answer, solution, knowledgePoint, difficulty, variation}
  TextColumn get contentJson => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 一次打印会话中的一道题（Question 或 AI 生成题）。
@DataClassName('PrintItem')
class PrintItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  /// question / exercise
  TextColumn get kind => text().withDefault(const Constant('question'))();
  IntColumn get questionId => integer().nullable()();
  IntColumn get exerciseId => integer().nullable()();
  IntColumn get order => integer().withDefault(const Constant(0))();
  IntColumn get answerSpaceMm => integer().withDefault(const Constant(40))();
  BoolColumn get forcePageBreakBefore =>
      boolean().withDefault(const Constant(false))();
  RealColumn get scaleOverride => real().nullable()();
  BoolColumn get showSource => boolean().withDefault(const Constant(true))();
  BoolColumn get showOriginalNumber =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get showAnswer => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// AI 错因类型（简单枚举）。
const List<String> kErrorTypes = <String>[
  'calculation',
  'concept',
  'sign',
  'reading',
  'formula',
  'careless',
  'unknown',
];

/// 举一反三难度标签。
const List<String> kExerciseDifficulties = <String>[
  'easy',
  'same',
  'hard',
];

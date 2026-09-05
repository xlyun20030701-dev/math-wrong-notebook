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

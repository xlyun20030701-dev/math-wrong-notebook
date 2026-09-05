// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mistake_database.dart';

// ignore_for_file: type=lint
class $PapersTable extends Papers with TableInfo<$PapersTable, Paper> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PapersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subjectMeta =
      const VerificationMeta('subject');
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
      'subject', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _examDateMeta =
      const VerificationMeta('examDate');
  @override
  late final GeneratedColumn<DateTime> examDate = GeneratedColumn<DateTime>(
      'exam_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _schoolMeta = const VerificationMeta('school');
  @override
  late final GeneratedColumn<String> school = GeneratedColumn<String>(
      'school', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
      'grade', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, subject, examDate, school, grade, note, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'papers';
  @override
  VerificationContext validateIntegrity(Insertable<Paper> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('subject')) {
      context.handle(_subjectMeta,
          subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta));
    }
    if (data.containsKey('exam_date')) {
      context.handle(_examDateMeta,
          examDate.isAcceptableOrUnknown(data['exam_date']!, _examDateMeta));
    }
    if (data.containsKey('school')) {
      context.handle(_schoolMeta,
          school.isAcceptableOrUnknown(data['school']!, _schoolMeta));
    }
    if (data.containsKey('grade')) {
      context.handle(
          _gradeMeta, grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Paper map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Paper(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      subject: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subject']),
      examDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}exam_date']),
      school: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}school']),
      grade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}grade']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PapersTable createAlias(String alias) {
    return $PapersTable(attachedDatabase, alias);
  }
}

class Paper extends DataClass implements Insertable<Paper> {
  final int id;
  final String title;
  final String? subject;
  final DateTime? examDate;
  final String? school;
  final String? grade;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Paper(
      {required this.id,
      required this.title,
      this.subject,
      this.examDate,
      this.school,
      this.grade,
      this.note,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || subject != null) {
      map['subject'] = Variable<String>(subject);
    }
    if (!nullToAbsent || examDate != null) {
      map['exam_date'] = Variable<DateTime>(examDate);
    }
    if (!nullToAbsent || school != null) {
      map['school'] = Variable<String>(school);
    }
    if (!nullToAbsent || grade != null) {
      map['grade'] = Variable<String>(grade);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PapersCompanion toCompanion(bool nullToAbsent) {
    return PapersCompanion(
      id: Value(id),
      title: Value(title),
      subject: subject == null && nullToAbsent
          ? const Value.absent()
          : Value(subject),
      examDate: examDate == null && nullToAbsent
          ? const Value.absent()
          : Value(examDate),
      school:
          school == null && nullToAbsent ? const Value.absent() : Value(school),
      grade:
          grade == null && nullToAbsent ? const Value.absent() : Value(grade),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Paper.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Paper(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      subject: serializer.fromJson<String?>(json['subject']),
      examDate: serializer.fromJson<DateTime?>(json['examDate']),
      school: serializer.fromJson<String?>(json['school']),
      grade: serializer.fromJson<String?>(json['grade']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'subject': serializer.toJson<String?>(subject),
      'examDate': serializer.toJson<DateTime?>(examDate),
      'school': serializer.toJson<String?>(school),
      'grade': serializer.toJson<String?>(grade),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Paper copyWith(
          {int? id,
          String? title,
          Value<String?> subject = const Value.absent(),
          Value<DateTime?> examDate = const Value.absent(),
          Value<String?> school = const Value.absent(),
          Value<String?> grade = const Value.absent(),
          Value<String?> note = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Paper(
        id: id ?? this.id,
        title: title ?? this.title,
        subject: subject.present ? subject.value : this.subject,
        examDate: examDate.present ? examDate.value : this.examDate,
        school: school.present ? school.value : this.school,
        grade: grade.present ? grade.value : this.grade,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Paper copyWithCompanion(PapersCompanion data) {
    return Paper(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      subject: data.subject.present ? data.subject.value : this.subject,
      examDate: data.examDate.present ? data.examDate.value : this.examDate,
      school: data.school.present ? data.school.value : this.school,
      grade: data.grade.present ? data.grade.value : this.grade,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Paper(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('subject: $subject, ')
          ..write('examDate: $examDate, ')
          ..write('school: $school, ')
          ..write('grade: $grade, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, subject, examDate, school, grade, note, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Paper &&
          other.id == this.id &&
          other.title == this.title &&
          other.subject == this.subject &&
          other.examDate == this.examDate &&
          other.school == this.school &&
          other.grade == this.grade &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PapersCompanion extends UpdateCompanion<Paper> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> subject;
  final Value<DateTime?> examDate;
  final Value<String?> school;
  final Value<String?> grade;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PapersCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.subject = const Value.absent(),
    this.examDate = const Value.absent(),
    this.school = const Value.absent(),
    this.grade = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PapersCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.subject = const Value.absent(),
    this.examDate = const Value.absent(),
    this.school = const Value.absent(),
    this.grade = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Paper> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? subject,
    Expression<DateTime>? examDate,
    Expression<String>? school,
    Expression<String>? grade,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (subject != null) 'subject': subject,
      if (examDate != null) 'exam_date': examDate,
      if (school != null) 'school': school,
      if (grade != null) 'grade': grade,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PapersCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? subject,
      Value<DateTime?>? examDate,
      Value<String?>? school,
      Value<String?>? grade,
      Value<String?>? note,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return PapersCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      examDate: examDate ?? this.examDate,
      school: school ?? this.school,
      grade: grade ?? this.grade,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (examDate.present) {
      map['exam_date'] = Variable<DateTime>(examDate.value);
    }
    if (school.present) {
      map['school'] = Variable<String>(school.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PapersCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('subject: $subject, ')
          ..write('examDate: $examDate, ')
          ..write('school: $school, ')
          ..write('grade: $grade, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PagesTable extends Pages with TableInfo<$PagesTable, PageRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _paperIdMeta =
      const VerificationMeta('paperId');
  @override
  late final GeneratedColumn<int> paperId = GeneratedColumn<int>(
      'paper_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES papers (id) ON DELETE CASCADE'));
  static const VerificationMeta _originalImagePathMeta =
      const VerificationMeta('originalImagePath');
  @override
  late final GeneratedColumn<String> originalImagePath =
      GeneratedColumn<String>('original_image_path', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pageIndexMeta =
      const VerificationMeta('pageIndex');
  @override
  late final GeneratedColumn<int> pageIndex = GeneratedColumn<int>(
      'page_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
      'width', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
      'height', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _qualityScoreMeta =
      const VerificationMeta('qualityScore');
  @override
  late final GeneratedColumn<double> qualityScore = GeneratedColumn<double>(
      'quality_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _blurScoreMeta =
      const VerificationMeta('blurScore');
  @override
  late final GeneratedColumn<double> blurScore = GeneratedColumn<double>(
      'blur_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _exposureScoreMeta =
      const VerificationMeta('exposureScore');
  @override
  late final GeneratedColumn<double> exposureScore = GeneratedColumn<double>(
      'exposure_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _perspectiveWarningMeta =
      const VerificationMeta('perspectiveWarning');
  @override
  late final GeneratedColumn<bool> perspectiveWarning = GeneratedColumn<bool>(
      'perspective_warning', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("perspective_warning" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        paperId,
        originalImagePath,
        pageIndex,
        width,
        height,
        qualityScore,
        blurScore,
        exposureScore,
        perspectiveWarning,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pages';
  @override
  VerificationContext validateIntegrity(Insertable<PageRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('paper_id')) {
      context.handle(_paperIdMeta,
          paperId.isAcceptableOrUnknown(data['paper_id']!, _paperIdMeta));
    } else if (isInserting) {
      context.missing(_paperIdMeta);
    }
    if (data.containsKey('original_image_path')) {
      context.handle(
          _originalImagePathMeta,
          originalImagePath.isAcceptableOrUnknown(
              data['original_image_path']!, _originalImagePathMeta));
    } else if (isInserting) {
      context.missing(_originalImagePathMeta);
    }
    if (data.containsKey('page_index')) {
      context.handle(_pageIndexMeta,
          pageIndex.isAcceptableOrUnknown(data['page_index']!, _pageIndexMeta));
    } else if (isInserting) {
      context.missing(_pageIndexMeta);
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    }
    if (data.containsKey('quality_score')) {
      context.handle(
          _qualityScoreMeta,
          qualityScore.isAcceptableOrUnknown(
              data['quality_score']!, _qualityScoreMeta));
    }
    if (data.containsKey('blur_score')) {
      context.handle(_blurScoreMeta,
          blurScore.isAcceptableOrUnknown(data['blur_score']!, _blurScoreMeta));
    }
    if (data.containsKey('exposure_score')) {
      context.handle(
          _exposureScoreMeta,
          exposureScore.isAcceptableOrUnknown(
              data['exposure_score']!, _exposureScoreMeta));
    }
    if (data.containsKey('perspective_warning')) {
      context.handle(
          _perspectiveWarningMeta,
          perspectiveWarning.isAcceptableOrUnknown(
              data['perspective_warning']!, _perspectiveWarningMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PageRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PageRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      paperId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}paper_id'])!,
      originalImagePath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}original_image_path'])!,
      pageIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page_index'])!,
      width: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}width']),
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}height']),
      qualityScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quality_score']),
      blurScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}blur_score']),
      exposureScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}exposure_score']),
      perspectiveWarning: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}perspective_warning'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PagesTable createAlias(String alias) {
    return $PagesTable(attachedDatabase, alias);
  }
}

class PageRecord extends DataClass implements Insertable<PageRecord> {
  final int id;
  final int paperId;
  final String originalImagePath;
  final int pageIndex;
  final int? width;
  final int? height;

  /// 总体质量 0~100，越高越好。
  final double? qualityScore;

  /// Laplacian 方差，越大越清晰。
  final double? blurScore;

  /// 曝光分 0~100。
  final double? exposureScore;

  /// 透视/倾斜警示。
  ///
  /// 说明：Phase 1 尚未实现透视/倾斜检测，本字段恒为 false（“尚未检测”），
  /// 不得被当作“已检测且无倾斜”来宣传。真正的几何透视检测在 Phase 2 实现。
  final bool perspectiveWarning;
  final DateTime createdAt;
  const PageRecord(
      {required this.id,
      required this.paperId,
      required this.originalImagePath,
      required this.pageIndex,
      this.width,
      this.height,
      this.qualityScore,
      this.blurScore,
      this.exposureScore,
      required this.perspectiveWarning,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['paper_id'] = Variable<int>(paperId);
    map['original_image_path'] = Variable<String>(originalImagePath);
    map['page_index'] = Variable<int>(pageIndex);
    if (!nullToAbsent || width != null) {
      map['width'] = Variable<int>(width);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    if (!nullToAbsent || qualityScore != null) {
      map['quality_score'] = Variable<double>(qualityScore);
    }
    if (!nullToAbsent || blurScore != null) {
      map['blur_score'] = Variable<double>(blurScore);
    }
    if (!nullToAbsent || exposureScore != null) {
      map['exposure_score'] = Variable<double>(exposureScore);
    }
    map['perspective_warning'] = Variable<bool>(perspectiveWarning);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PagesCompanion toCompanion(bool nullToAbsent) {
    return PagesCompanion(
      id: Value(id),
      paperId: Value(paperId),
      originalImagePath: Value(originalImagePath),
      pageIndex: Value(pageIndex),
      width:
          width == null && nullToAbsent ? const Value.absent() : Value(width),
      height:
          height == null && nullToAbsent ? const Value.absent() : Value(height),
      qualityScore: qualityScore == null && nullToAbsent
          ? const Value.absent()
          : Value(qualityScore),
      blurScore: blurScore == null && nullToAbsent
          ? const Value.absent()
          : Value(blurScore),
      exposureScore: exposureScore == null && nullToAbsent
          ? const Value.absent()
          : Value(exposureScore),
      perspectiveWarning: Value(perspectiveWarning),
      createdAt: Value(createdAt),
    );
  }

  factory PageRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PageRecord(
      id: serializer.fromJson<int>(json['id']),
      paperId: serializer.fromJson<int>(json['paperId']),
      originalImagePath: serializer.fromJson<String>(json['originalImagePath']),
      pageIndex: serializer.fromJson<int>(json['pageIndex']),
      width: serializer.fromJson<int?>(json['width']),
      height: serializer.fromJson<int?>(json['height']),
      qualityScore: serializer.fromJson<double?>(json['qualityScore']),
      blurScore: serializer.fromJson<double?>(json['blurScore']),
      exposureScore: serializer.fromJson<double?>(json['exposureScore']),
      perspectiveWarning: serializer.fromJson<bool>(json['perspectiveWarning']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'paperId': serializer.toJson<int>(paperId),
      'originalImagePath': serializer.toJson<String>(originalImagePath),
      'pageIndex': serializer.toJson<int>(pageIndex),
      'width': serializer.toJson<int?>(width),
      'height': serializer.toJson<int?>(height),
      'qualityScore': serializer.toJson<double?>(qualityScore),
      'blurScore': serializer.toJson<double?>(blurScore),
      'exposureScore': serializer.toJson<double?>(exposureScore),
      'perspectiveWarning': serializer.toJson<bool>(perspectiveWarning),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PageRecord copyWith(
          {int? id,
          int? paperId,
          String? originalImagePath,
          int? pageIndex,
          Value<int?> width = const Value.absent(),
          Value<int?> height = const Value.absent(),
          Value<double?> qualityScore = const Value.absent(),
          Value<double?> blurScore = const Value.absent(),
          Value<double?> exposureScore = const Value.absent(),
          bool? perspectiveWarning,
          DateTime? createdAt}) =>
      PageRecord(
        id: id ?? this.id,
        paperId: paperId ?? this.paperId,
        originalImagePath: originalImagePath ?? this.originalImagePath,
        pageIndex: pageIndex ?? this.pageIndex,
        width: width.present ? width.value : this.width,
        height: height.present ? height.value : this.height,
        qualityScore:
            qualityScore.present ? qualityScore.value : this.qualityScore,
        blurScore: blurScore.present ? blurScore.value : this.blurScore,
        exposureScore:
            exposureScore.present ? exposureScore.value : this.exposureScore,
        perspectiveWarning: perspectiveWarning ?? this.perspectiveWarning,
        createdAt: createdAt ?? this.createdAt,
      );
  PageRecord copyWithCompanion(PagesCompanion data) {
    return PageRecord(
      id: data.id.present ? data.id.value : this.id,
      paperId: data.paperId.present ? data.paperId.value : this.paperId,
      originalImagePath: data.originalImagePath.present
          ? data.originalImagePath.value
          : this.originalImagePath,
      pageIndex: data.pageIndex.present ? data.pageIndex.value : this.pageIndex,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      qualityScore: data.qualityScore.present
          ? data.qualityScore.value
          : this.qualityScore,
      blurScore: data.blurScore.present ? data.blurScore.value : this.blurScore,
      exposureScore: data.exposureScore.present
          ? data.exposureScore.value
          : this.exposureScore,
      perspectiveWarning: data.perspectiveWarning.present
          ? data.perspectiveWarning.value
          : this.perspectiveWarning,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PageRecord(')
          ..write('id: $id, ')
          ..write('paperId: $paperId, ')
          ..write('originalImagePath: $originalImagePath, ')
          ..write('pageIndex: $pageIndex, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('qualityScore: $qualityScore, ')
          ..write('blurScore: $blurScore, ')
          ..write('exposureScore: $exposureScore, ')
          ..write('perspectiveWarning: $perspectiveWarning, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      paperId,
      originalImagePath,
      pageIndex,
      width,
      height,
      qualityScore,
      blurScore,
      exposureScore,
      perspectiveWarning,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PageRecord &&
          other.id == this.id &&
          other.paperId == this.paperId &&
          other.originalImagePath == this.originalImagePath &&
          other.pageIndex == this.pageIndex &&
          other.width == this.width &&
          other.height == this.height &&
          other.qualityScore == this.qualityScore &&
          other.blurScore == this.blurScore &&
          other.exposureScore == this.exposureScore &&
          other.perspectiveWarning == this.perspectiveWarning &&
          other.createdAt == this.createdAt);
}

class PagesCompanion extends UpdateCompanion<PageRecord> {
  final Value<int> id;
  final Value<int> paperId;
  final Value<String> originalImagePath;
  final Value<int> pageIndex;
  final Value<int?> width;
  final Value<int?> height;
  final Value<double?> qualityScore;
  final Value<double?> blurScore;
  final Value<double?> exposureScore;
  final Value<bool> perspectiveWarning;
  final Value<DateTime> createdAt;
  const PagesCompanion({
    this.id = const Value.absent(),
    this.paperId = const Value.absent(),
    this.originalImagePath = const Value.absent(),
    this.pageIndex = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.qualityScore = const Value.absent(),
    this.blurScore = const Value.absent(),
    this.exposureScore = const Value.absent(),
    this.perspectiveWarning = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PagesCompanion.insert({
    this.id = const Value.absent(),
    required int paperId,
    required String originalImagePath,
    required int pageIndex,
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.qualityScore = const Value.absent(),
    this.blurScore = const Value.absent(),
    this.exposureScore = const Value.absent(),
    this.perspectiveWarning = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : paperId = Value(paperId),
        originalImagePath = Value(originalImagePath),
        pageIndex = Value(pageIndex);
  static Insertable<PageRecord> custom({
    Expression<int>? id,
    Expression<int>? paperId,
    Expression<String>? originalImagePath,
    Expression<int>? pageIndex,
    Expression<int>? width,
    Expression<int>? height,
    Expression<double>? qualityScore,
    Expression<double>? blurScore,
    Expression<double>? exposureScore,
    Expression<bool>? perspectiveWarning,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (paperId != null) 'paper_id': paperId,
      if (originalImagePath != null) 'original_image_path': originalImagePath,
      if (pageIndex != null) 'page_index': pageIndex,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (qualityScore != null) 'quality_score': qualityScore,
      if (blurScore != null) 'blur_score': blurScore,
      if (exposureScore != null) 'exposure_score': exposureScore,
      if (perspectiveWarning != null) 'perspective_warning': perspectiveWarning,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PagesCompanion copyWith(
      {Value<int>? id,
      Value<int>? paperId,
      Value<String>? originalImagePath,
      Value<int>? pageIndex,
      Value<int?>? width,
      Value<int?>? height,
      Value<double?>? qualityScore,
      Value<double?>? blurScore,
      Value<double?>? exposureScore,
      Value<bool>? perspectiveWarning,
      Value<DateTime>? createdAt}) {
    return PagesCompanion(
      id: id ?? this.id,
      paperId: paperId ?? this.paperId,
      originalImagePath: originalImagePath ?? this.originalImagePath,
      pageIndex: pageIndex ?? this.pageIndex,
      width: width ?? this.width,
      height: height ?? this.height,
      qualityScore: qualityScore ?? this.qualityScore,
      blurScore: blurScore ?? this.blurScore,
      exposureScore: exposureScore ?? this.exposureScore,
      perspectiveWarning: perspectiveWarning ?? this.perspectiveWarning,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (paperId.present) {
      map['paper_id'] = Variable<int>(paperId.value);
    }
    if (originalImagePath.present) {
      map['original_image_path'] = Variable<String>(originalImagePath.value);
    }
    if (pageIndex.present) {
      map['page_index'] = Variable<int>(pageIndex.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (qualityScore.present) {
      map['quality_score'] = Variable<double>(qualityScore.value);
    }
    if (blurScore.present) {
      map['blur_score'] = Variable<double>(blurScore.value);
    }
    if (exposureScore.present) {
      map['exposure_score'] = Variable<double>(exposureScore.value);
    }
    if (perspectiveWarning.present) {
      map['perspective_warning'] = Variable<bool>(perspectiveWarning.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PagesCompanion(')
          ..write('id: $id, ')
          ..write('paperId: $paperId, ')
          ..write('originalImagePath: $originalImagePath, ')
          ..write('pageIndex: $pageIndex, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('qualityScore: $qualityScore, ')
          ..write('blurScore: $blurScore, ')
          ..write('exposureScore: $exposureScore, ')
          ..write('perspectiveWarning: $perspectiveWarning, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $QuestionsTable extends Questions
    with TableInfo<$QuestionsTable, Question> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _paperIdMeta =
      const VerificationMeta('paperId');
  @override
  late final GeneratedColumn<int> paperId = GeneratedColumn<int>(
      'paper_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES papers (id) ON DELETE CASCADE'));
  static const VerificationMeta _originalQuestionNumberMeta =
      const VerificationMeta('originalQuestionNumber');
  @override
  late final GeneratedColumn<String> originalQuestionNumber =
      GeneratedColumn<String>('original_question_number', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _knowledgePointMeta =
      const VerificationMeta('knowledgePoint');
  @override
  late final GeneratedColumn<String> knowledgePoint = GeneratedColumn<String>(
      'knowledge_point', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _questionTypeMeta =
      const VerificationMeta('questionType');
  @override
  late final GeneratedColumn<String> questionType = GeneratedColumn<String>(
      'question_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
      'difficulty', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        paperId,
        originalQuestionNumber,
        title,
        knowledgePoint,
        questionType,
        difficulty,
        tags,
        note,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'questions';
  @override
  VerificationContext validateIntegrity(Insertable<Question> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('paper_id')) {
      context.handle(_paperIdMeta,
          paperId.isAcceptableOrUnknown(data['paper_id']!, _paperIdMeta));
    } else if (isInserting) {
      context.missing(_paperIdMeta);
    }
    if (data.containsKey('original_question_number')) {
      context.handle(
          _originalQuestionNumberMeta,
          originalQuestionNumber.isAcceptableOrUnknown(
              data['original_question_number']!, _originalQuestionNumberMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('knowledge_point')) {
      context.handle(
          _knowledgePointMeta,
          knowledgePoint.isAcceptableOrUnknown(
              data['knowledge_point']!, _knowledgePointMeta));
    }
    if (data.containsKey('question_type')) {
      context.handle(
          _questionTypeMeta,
          questionType.isAcceptableOrUnknown(
              data['question_type']!, _questionTypeMeta));
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Question map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Question(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      paperId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}paper_id'])!,
      originalQuestionNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}original_question_number']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      knowledgePoint: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}knowledge_point']),
      questionType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_type']),
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}difficulty']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $QuestionsTable createAlias(String alias) {
    return $QuestionsTable(attachedDatabase, alias);
  }
}

class Question extends DataClass implements Insertable<Question> {
  final int id;
  final int paperId;
  final String? originalQuestionNumber;
  final String? title;
  final String? knowledgePoint;

  /// 题型，如：选择题/填空题/解答题/其他。
  final String? questionType;

  /// 难度：基础/中等/困难（本地保存，来源可为手动或 AI）。
  final String? difficulty;

  /// JSON 字符串数组，例如 '["二次函数","易错"]'。
  final String tags;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Question(
      {required this.id,
      required this.paperId,
      this.originalQuestionNumber,
      this.title,
      this.knowledgePoint,
      this.questionType,
      this.difficulty,
      required this.tags,
      this.note,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['paper_id'] = Variable<int>(paperId);
    if (!nullToAbsent || originalQuestionNumber != null) {
      map['original_question_number'] =
          Variable<String>(originalQuestionNumber);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || knowledgePoint != null) {
      map['knowledge_point'] = Variable<String>(knowledgePoint);
    }
    if (!nullToAbsent || questionType != null) {
      map['question_type'] = Variable<String>(questionType);
    }
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<String>(difficulty);
    }
    map['tags'] = Variable<String>(tags);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  QuestionsCompanion toCompanion(bool nullToAbsent) {
    return QuestionsCompanion(
      id: Value(id),
      paperId: Value(paperId),
      originalQuestionNumber: originalQuestionNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(originalQuestionNumber),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      knowledgePoint: knowledgePoint == null && nullToAbsent
          ? const Value.absent()
          : Value(knowledgePoint),
      questionType: questionType == null && nullToAbsent
          ? const Value.absent()
          : Value(questionType),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      tags: Value(tags),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Question.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Question(
      id: serializer.fromJson<int>(json['id']),
      paperId: serializer.fromJson<int>(json['paperId']),
      originalQuestionNumber:
          serializer.fromJson<String?>(json['originalQuestionNumber']),
      title: serializer.fromJson<String?>(json['title']),
      knowledgePoint: serializer.fromJson<String?>(json['knowledgePoint']),
      questionType: serializer.fromJson<String?>(json['questionType']),
      difficulty: serializer.fromJson<String?>(json['difficulty']),
      tags: serializer.fromJson<String>(json['tags']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'paperId': serializer.toJson<int>(paperId),
      'originalQuestionNumber':
          serializer.toJson<String?>(originalQuestionNumber),
      'title': serializer.toJson<String?>(title),
      'knowledgePoint': serializer.toJson<String?>(knowledgePoint),
      'questionType': serializer.toJson<String?>(questionType),
      'difficulty': serializer.toJson<String?>(difficulty),
      'tags': serializer.toJson<String>(tags),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Question copyWith(
          {int? id,
          int? paperId,
          Value<String?> originalQuestionNumber = const Value.absent(),
          Value<String?> title = const Value.absent(),
          Value<String?> knowledgePoint = const Value.absent(),
          Value<String?> questionType = const Value.absent(),
          Value<String?> difficulty = const Value.absent(),
          String? tags,
          Value<String?> note = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Question(
        id: id ?? this.id,
        paperId: paperId ?? this.paperId,
        originalQuestionNumber: originalQuestionNumber.present
            ? originalQuestionNumber.value
            : this.originalQuestionNumber,
        title: title.present ? title.value : this.title,
        knowledgePoint:
            knowledgePoint.present ? knowledgePoint.value : this.knowledgePoint,
        questionType:
            questionType.present ? questionType.value : this.questionType,
        difficulty: difficulty.present ? difficulty.value : this.difficulty,
        tags: tags ?? this.tags,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Question copyWithCompanion(QuestionsCompanion data) {
    return Question(
      id: data.id.present ? data.id.value : this.id,
      paperId: data.paperId.present ? data.paperId.value : this.paperId,
      originalQuestionNumber: data.originalQuestionNumber.present
          ? data.originalQuestionNumber.value
          : this.originalQuestionNumber,
      title: data.title.present ? data.title.value : this.title,
      knowledgePoint: data.knowledgePoint.present
          ? data.knowledgePoint.value
          : this.knowledgePoint,
      questionType: data.questionType.present
          ? data.questionType.value
          : this.questionType,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      tags: data.tags.present ? data.tags.value : this.tags,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Question(')
          ..write('id: $id, ')
          ..write('paperId: $paperId, ')
          ..write('originalQuestionNumber: $originalQuestionNumber, ')
          ..write('title: $title, ')
          ..write('knowledgePoint: $knowledgePoint, ')
          ..write('questionType: $questionType, ')
          ..write('difficulty: $difficulty, ')
          ..write('tags: $tags, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      paperId,
      originalQuestionNumber,
      title,
      knowledgePoint,
      questionType,
      difficulty,
      tags,
      note,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Question &&
          other.id == this.id &&
          other.paperId == this.paperId &&
          other.originalQuestionNumber == this.originalQuestionNumber &&
          other.title == this.title &&
          other.knowledgePoint == this.knowledgePoint &&
          other.questionType == this.questionType &&
          other.difficulty == this.difficulty &&
          other.tags == this.tags &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class QuestionsCompanion extends UpdateCompanion<Question> {
  final Value<int> id;
  final Value<int> paperId;
  final Value<String?> originalQuestionNumber;
  final Value<String?> title;
  final Value<String?> knowledgePoint;
  final Value<String?> questionType;
  final Value<String?> difficulty;
  final Value<String> tags;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const QuestionsCompanion({
    this.id = const Value.absent(),
    this.paperId = const Value.absent(),
    this.originalQuestionNumber = const Value.absent(),
    this.title = const Value.absent(),
    this.knowledgePoint = const Value.absent(),
    this.questionType = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.tags = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  QuestionsCompanion.insert({
    this.id = const Value.absent(),
    required int paperId,
    this.originalQuestionNumber = const Value.absent(),
    this.title = const Value.absent(),
    this.knowledgePoint = const Value.absent(),
    this.questionType = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.tags = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : paperId = Value(paperId);
  static Insertable<Question> custom({
    Expression<int>? id,
    Expression<int>? paperId,
    Expression<String>? originalQuestionNumber,
    Expression<String>? title,
    Expression<String>? knowledgePoint,
    Expression<String>? questionType,
    Expression<String>? difficulty,
    Expression<String>? tags,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (paperId != null) 'paper_id': paperId,
      if (originalQuestionNumber != null)
        'original_question_number': originalQuestionNumber,
      if (title != null) 'title': title,
      if (knowledgePoint != null) 'knowledge_point': knowledgePoint,
      if (questionType != null) 'question_type': questionType,
      if (difficulty != null) 'difficulty': difficulty,
      if (tags != null) 'tags': tags,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  QuestionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? paperId,
      Value<String?>? originalQuestionNumber,
      Value<String?>? title,
      Value<String?>? knowledgePoint,
      Value<String?>? questionType,
      Value<String?>? difficulty,
      Value<String>? tags,
      Value<String?>? note,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return QuestionsCompanion(
      id: id ?? this.id,
      paperId: paperId ?? this.paperId,
      originalQuestionNumber:
          originalQuestionNumber ?? this.originalQuestionNumber,
      title: title ?? this.title,
      knowledgePoint: knowledgePoint ?? this.knowledgePoint,
      questionType: questionType ?? this.questionType,
      difficulty: difficulty ?? this.difficulty,
      tags: tags ?? this.tags,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (paperId.present) {
      map['paper_id'] = Variable<int>(paperId.value);
    }
    if (originalQuestionNumber.present) {
      map['original_question_number'] =
          Variable<String>(originalQuestionNumber.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (knowledgePoint.present) {
      map['knowledge_point'] = Variable<String>(knowledgePoint.value);
    }
    if (questionType.present) {
      map['question_type'] = Variable<String>(questionType.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsCompanion(')
          ..write('id: $id, ')
          ..write('paperId: $paperId, ')
          ..write('originalQuestionNumber: $originalQuestionNumber, ')
          ..write('title: $title, ')
          ..write('knowledgePoint: $knowledgePoint, ')
          ..write('questionType: $questionType, ')
          ..write('difficulty: $difficulty, ')
          ..write('tags: $tags, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BlocksTable extends Blocks with TableInfo<$BlocksTable, Block> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<int> questionId = GeneratedColumn<int>(
      'question_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES questions (id) ON DELETE CASCADE'));
  static const VerificationMeta _pageIdMeta = const VerificationMeta('pageId');
  @override
  late final GeneratedColumn<int> pageId = GeneratedColumn<int>(
      'page_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES pages (id) ON DELETE CASCADE'));
  static const VerificationMeta _blockTypeMeta =
      const VerificationMeta('blockType');
  @override
  late final GeneratedColumn<String> blockType = GeneratedColumn<String>(
      'block_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  @override
  late final GeneratedColumn<double> x = GeneratedColumn<double>(
      'x', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _yMeta = const VerificationMeta('y');
  @override
  late final GeneratedColumn<double> y = GeneratedColumn<double>(
      'y', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<double> width = GeneratedColumn<double>(
      'width', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _processedImagePathMeta =
      const VerificationMeta('processedImagePath');
  @override
  late final GeneratedColumn<String> processedImagePath =
      GeneratedColumn<String>('processed_image_path', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _processingStatusMeta =
      const VerificationMeta('processingStatus');
  @override
  late final GeneratedColumn<String> processingStatus = GeneratedColumn<String>(
      'processing_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('cropped'));
  static const VerificationMeta _printScaleOverrideMeta =
      const VerificationMeta('printScaleOverride');
  @override
  late final GeneratedColumn<double> printScaleOverride =
      GeneratedColumn<double>('print_scale_override', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        questionId,
        pageId,
        blockType,
        x,
        y,
        width,
        height,
        sortOrder,
        processedImagePath,
        processingStatus,
        printScaleOverride,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blocks';
  @override
  VerificationContext validateIntegrity(Insertable<Block> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('page_id')) {
      context.handle(_pageIdMeta,
          pageId.isAcceptableOrUnknown(data['page_id']!, _pageIdMeta));
    } else if (isInserting) {
      context.missing(_pageIdMeta);
    }
    if (data.containsKey('block_type')) {
      context.handle(_blockTypeMeta,
          blockType.isAcceptableOrUnknown(data['block_type']!, _blockTypeMeta));
    } else if (isInserting) {
      context.missing(_blockTypeMeta);
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    } else if (isInserting) {
      context.missing(_xMeta);
    }
    if (data.containsKey('y')) {
      context.handle(_yMeta, y.isAcceptableOrUnknown(data['y']!, _yMeta));
    } else if (isInserting) {
      context.missing(_yMeta);
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    } else if (isInserting) {
      context.missing(_widthMeta);
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('processed_image_path')) {
      context.handle(
          _processedImagePathMeta,
          processedImagePath.isAcceptableOrUnknown(
              data['processed_image_path']!, _processedImagePathMeta));
    }
    if (data.containsKey('processing_status')) {
      context.handle(
          _processingStatusMeta,
          processingStatus.isAcceptableOrUnknown(
              data['processing_status']!, _processingStatusMeta));
    }
    if (data.containsKey('print_scale_override')) {
      context.handle(
          _printScaleOverrideMeta,
          printScaleOverride.isAcceptableOrUnknown(
              data['print_scale_override']!, _printScaleOverrideMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Block map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Block(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}question_id'])!,
      pageId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page_id'])!,
      blockType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}block_type'])!,
      x: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}x'])!,
      y: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}y'])!,
      width: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}width'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      processedImagePath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}processed_image_path']),
      processingStatus: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}processing_status'])!,
      printScaleOverride: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}print_scale_override']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $BlocksTable createAlias(String alias) {
    return $BlocksTable(attachedDatabase, alias);
  }
}

class Block extends DataClass implements Insertable<Block> {
  final int id;
  final int questionId;
  final int pageId;

  /// blockType: stem / option / continuation / figure / answer /
  /// solution / work / teacherNote / other
  final String blockType;

  /// 归一化坐标 0~1。
  final double x;
  final double y;
  final double width;
  final double height;
  final int sortOrder;

  /// 裁剪后保存的区块图片（原图无修改）。
  final String? processedImagePath;

  /// none / cropped / processed
  final String processingStatus;
  final double? printScaleOverride;
  final DateTime createdAt;
  const Block(
      {required this.id,
      required this.questionId,
      required this.pageId,
      required this.blockType,
      required this.x,
      required this.y,
      required this.width,
      required this.height,
      required this.sortOrder,
      this.processedImagePath,
      required this.processingStatus,
      this.printScaleOverride,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['question_id'] = Variable<int>(questionId);
    map['page_id'] = Variable<int>(pageId);
    map['block_type'] = Variable<String>(blockType);
    map['x'] = Variable<double>(x);
    map['y'] = Variable<double>(y);
    map['width'] = Variable<double>(width);
    map['height'] = Variable<double>(height);
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || processedImagePath != null) {
      map['processed_image_path'] = Variable<String>(processedImagePath);
    }
    map['processing_status'] = Variable<String>(processingStatus);
    if (!nullToAbsent || printScaleOverride != null) {
      map['print_scale_override'] = Variable<double>(printScaleOverride);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BlocksCompanion toCompanion(bool nullToAbsent) {
    return BlocksCompanion(
      id: Value(id),
      questionId: Value(questionId),
      pageId: Value(pageId),
      blockType: Value(blockType),
      x: Value(x),
      y: Value(y),
      width: Value(width),
      height: Value(height),
      sortOrder: Value(sortOrder),
      processedImagePath: processedImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(processedImagePath),
      processingStatus: Value(processingStatus),
      printScaleOverride: printScaleOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(printScaleOverride),
      createdAt: Value(createdAt),
    );
  }

  factory Block.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Block(
      id: serializer.fromJson<int>(json['id']),
      questionId: serializer.fromJson<int>(json['questionId']),
      pageId: serializer.fromJson<int>(json['pageId']),
      blockType: serializer.fromJson<String>(json['blockType']),
      x: serializer.fromJson<double>(json['x']),
      y: serializer.fromJson<double>(json['y']),
      width: serializer.fromJson<double>(json['width']),
      height: serializer.fromJson<double>(json['height']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      processedImagePath:
          serializer.fromJson<String?>(json['processedImagePath']),
      processingStatus: serializer.fromJson<String>(json['processingStatus']),
      printScaleOverride:
          serializer.fromJson<double?>(json['printScaleOverride']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'questionId': serializer.toJson<int>(questionId),
      'pageId': serializer.toJson<int>(pageId),
      'blockType': serializer.toJson<String>(blockType),
      'x': serializer.toJson<double>(x),
      'y': serializer.toJson<double>(y),
      'width': serializer.toJson<double>(width),
      'height': serializer.toJson<double>(height),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'processedImagePath': serializer.toJson<String?>(processedImagePath),
      'processingStatus': serializer.toJson<String>(processingStatus),
      'printScaleOverride': serializer.toJson<double?>(printScaleOverride),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Block copyWith(
          {int? id,
          int? questionId,
          int? pageId,
          String? blockType,
          double? x,
          double? y,
          double? width,
          double? height,
          int? sortOrder,
          Value<String?> processedImagePath = const Value.absent(),
          String? processingStatus,
          Value<double?> printScaleOverride = const Value.absent(),
          DateTime? createdAt}) =>
      Block(
        id: id ?? this.id,
        questionId: questionId ?? this.questionId,
        pageId: pageId ?? this.pageId,
        blockType: blockType ?? this.blockType,
        x: x ?? this.x,
        y: y ?? this.y,
        width: width ?? this.width,
        height: height ?? this.height,
        sortOrder: sortOrder ?? this.sortOrder,
        processedImagePath: processedImagePath.present
            ? processedImagePath.value
            : this.processedImagePath,
        processingStatus: processingStatus ?? this.processingStatus,
        printScaleOverride: printScaleOverride.present
            ? printScaleOverride.value
            : this.printScaleOverride,
        createdAt: createdAt ?? this.createdAt,
      );
  Block copyWithCompanion(BlocksCompanion data) {
    return Block(
      id: data.id.present ? data.id.value : this.id,
      questionId:
          data.questionId.present ? data.questionId.value : this.questionId,
      pageId: data.pageId.present ? data.pageId.value : this.pageId,
      blockType: data.blockType.present ? data.blockType.value : this.blockType,
      x: data.x.present ? data.x.value : this.x,
      y: data.y.present ? data.y.value : this.y,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      processedImagePath: data.processedImagePath.present
          ? data.processedImagePath.value
          : this.processedImagePath,
      processingStatus: data.processingStatus.present
          ? data.processingStatus.value
          : this.processingStatus,
      printScaleOverride: data.printScaleOverride.present
          ? data.printScaleOverride.value
          : this.printScaleOverride,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Block(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('pageId: $pageId, ')
          ..write('blockType: $blockType, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('processedImagePath: $processedImagePath, ')
          ..write('processingStatus: $processingStatus, ')
          ..write('printScaleOverride: $printScaleOverride, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      questionId,
      pageId,
      blockType,
      x,
      y,
      width,
      height,
      sortOrder,
      processedImagePath,
      processingStatus,
      printScaleOverride,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Block &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.pageId == this.pageId &&
          other.blockType == this.blockType &&
          other.x == this.x &&
          other.y == this.y &&
          other.width == this.width &&
          other.height == this.height &&
          other.sortOrder == this.sortOrder &&
          other.processedImagePath == this.processedImagePath &&
          other.processingStatus == this.processingStatus &&
          other.printScaleOverride == this.printScaleOverride &&
          other.createdAt == this.createdAt);
}

class BlocksCompanion extends UpdateCompanion<Block> {
  final Value<int> id;
  final Value<int> questionId;
  final Value<int> pageId;
  final Value<String> blockType;
  final Value<double> x;
  final Value<double> y;
  final Value<double> width;
  final Value<double> height;
  final Value<int> sortOrder;
  final Value<String?> processedImagePath;
  final Value<String> processingStatus;
  final Value<double?> printScaleOverride;
  final Value<DateTime> createdAt;
  const BlocksCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.pageId = const Value.absent(),
    this.blockType = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.processedImagePath = const Value.absent(),
    this.processingStatus = const Value.absent(),
    this.printScaleOverride = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BlocksCompanion.insert({
    this.id = const Value.absent(),
    required int questionId,
    required int pageId,
    required String blockType,
    required double x,
    required double y,
    required double width,
    required double height,
    this.sortOrder = const Value.absent(),
    this.processedImagePath = const Value.absent(),
    this.processingStatus = const Value.absent(),
    this.printScaleOverride = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : questionId = Value(questionId),
        pageId = Value(pageId),
        blockType = Value(blockType),
        x = Value(x),
        y = Value(y),
        width = Value(width),
        height = Value(height);
  static Insertable<Block> custom({
    Expression<int>? id,
    Expression<int>? questionId,
    Expression<int>? pageId,
    Expression<String>? blockType,
    Expression<double>? x,
    Expression<double>? y,
    Expression<double>? width,
    Expression<double>? height,
    Expression<int>? sortOrder,
    Expression<String>? processedImagePath,
    Expression<String>? processingStatus,
    Expression<double>? printScaleOverride,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionId != null) 'question_id': questionId,
      if (pageId != null) 'page_id': pageId,
      if (blockType != null) 'block_type': blockType,
      if (x != null) 'x': x,
      if (y != null) 'y': y,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (processedImagePath != null)
        'processed_image_path': processedImagePath,
      if (processingStatus != null) 'processing_status': processingStatus,
      if (printScaleOverride != null)
        'print_scale_override': printScaleOverride,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BlocksCompanion copyWith(
      {Value<int>? id,
      Value<int>? questionId,
      Value<int>? pageId,
      Value<String>? blockType,
      Value<double>? x,
      Value<double>? y,
      Value<double>? width,
      Value<double>? height,
      Value<int>? sortOrder,
      Value<String?>? processedImagePath,
      Value<String>? processingStatus,
      Value<double?>? printScaleOverride,
      Value<DateTime>? createdAt}) {
    return BlocksCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      pageId: pageId ?? this.pageId,
      blockType: blockType ?? this.blockType,
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
      sortOrder: sortOrder ?? this.sortOrder,
      processedImagePath: processedImagePath ?? this.processedImagePath,
      processingStatus: processingStatus ?? this.processingStatus,
      printScaleOverride: printScaleOverride ?? this.printScaleOverride,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<int>(questionId.value);
    }
    if (pageId.present) {
      map['page_id'] = Variable<int>(pageId.value);
    }
    if (blockType.present) {
      map['block_type'] = Variable<String>(blockType.value);
    }
    if (x.present) {
      map['x'] = Variable<double>(x.value);
    }
    if (y.present) {
      map['y'] = Variable<double>(y.value);
    }
    if (width.present) {
      map['width'] = Variable<double>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (processedImagePath.present) {
      map['processed_image_path'] = Variable<String>(processedImagePath.value);
    }
    if (processingStatus.present) {
      map['processing_status'] = Variable<String>(processingStatus.value);
    }
    if (printScaleOverride.present) {
      map['print_scale_override'] = Variable<double>(printScaleOverride.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlocksCompanion(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('pageId: $pageId, ')
          ..write('blockType: $blockType, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('processedImagePath: $processedImagePath, ')
          ..write('processingStatus: $processingStatus, ')
          ..write('printScaleOverride: $printScaleOverride, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AnswerResourcesTable extends AnswerResources
    with TableInfo<$AnswerResourcesTable, AnswerResource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnswerResourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<int> questionId = GeneratedColumn<int>(
      'question_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES questions (id) ON DELETE CASCADE'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('answer'));
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<String> format = GeneratedColumn<String>(
      'format', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('text'));
  static const VerificationMeta _sourceTypeMeta =
      const VerificationMeta('sourceType');
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
      'source_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('other'));
  static const VerificationMeta _sourceDescriptionMeta =
      const VerificationMeta('sourceDescription');
  @override
  late final GeneratedColumn<String> sourceDescription =
      GeneratedColumn<String>('source_description', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentTextMeta =
      const VerificationMeta('contentText');
  @override
  late final GeneratedColumn<String> contentText = GeneratedColumn<String>(
      'content_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isVerifiedMeta =
      const VerificationMeta('isVerified');
  @override
  late final GeneratedColumn<bool> isVerified = GeneratedColumn<bool>(
      'is_verified', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_verified" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        questionId,
        type,
        format,
        sourceType,
        sourceDescription,
        contentText,
        imagePath,
        isVerified,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'answer_resources';
  @override
  VerificationContext validateIntegrity(Insertable<AnswerResource> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('format')) {
      context.handle(_formatMeta,
          format.isAcceptableOrUnknown(data['format']!, _formatMeta));
    }
    if (data.containsKey('source_type')) {
      context.handle(
          _sourceTypeMeta,
          sourceType.isAcceptableOrUnknown(
              data['source_type']!, _sourceTypeMeta));
    }
    if (data.containsKey('source_description')) {
      context.handle(
          _sourceDescriptionMeta,
          sourceDescription.isAcceptableOrUnknown(
              data['source_description']!, _sourceDescriptionMeta));
    }
    if (data.containsKey('content_text')) {
      context.handle(
          _contentTextMeta,
          contentText.isAcceptableOrUnknown(
              data['content_text']!, _contentTextMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    if (data.containsKey('is_verified')) {
      context.handle(
          _isVerifiedMeta,
          isVerified.isAcceptableOrUnknown(
              data['is_verified']!, _isVerifiedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnswerResource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnswerResource(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}question_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      format: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}format'])!,
      sourceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_type'])!,
      sourceDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}source_description']),
      contentText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_text']),
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
      isVerified: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_verified'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AnswerResourcesTable createAlias(String alias) {
    return $AnswerResourcesTable(attachedDatabase, alias);
  }
}

class AnswerResource extends DataClass implements Insertable<AnswerResource> {
  final int id;
  final int questionId;

  /// answer / solution / hint
  final String type;

  /// text / image / mixed
  final String format;

  /// originalPaper / answerSheet / searchApp / ai / manual /
  /// screenshot / teacher / other
  final String sourceType;
  final String? sourceDescription;
  final String? contentText;
  final String? imagePath;
  final bool isVerified;
  final DateTime createdAt;
  const AnswerResource(
      {required this.id,
      required this.questionId,
      required this.type,
      required this.format,
      required this.sourceType,
      this.sourceDescription,
      this.contentText,
      this.imagePath,
      required this.isVerified,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['question_id'] = Variable<int>(questionId);
    map['type'] = Variable<String>(type);
    map['format'] = Variable<String>(format);
    map['source_type'] = Variable<String>(sourceType);
    if (!nullToAbsent || sourceDescription != null) {
      map['source_description'] = Variable<String>(sourceDescription);
    }
    if (!nullToAbsent || contentText != null) {
      map['content_text'] = Variable<String>(contentText);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['is_verified'] = Variable<bool>(isVerified);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AnswerResourcesCompanion toCompanion(bool nullToAbsent) {
    return AnswerResourcesCompanion(
      id: Value(id),
      questionId: Value(questionId),
      type: Value(type),
      format: Value(format),
      sourceType: Value(sourceType),
      sourceDescription: sourceDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceDescription),
      contentText: contentText == null && nullToAbsent
          ? const Value.absent()
          : Value(contentText),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      isVerified: Value(isVerified),
      createdAt: Value(createdAt),
    );
  }

  factory AnswerResource.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnswerResource(
      id: serializer.fromJson<int>(json['id']),
      questionId: serializer.fromJson<int>(json['questionId']),
      type: serializer.fromJson<String>(json['type']),
      format: serializer.fromJson<String>(json['format']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      sourceDescription:
          serializer.fromJson<String?>(json['sourceDescription']),
      contentText: serializer.fromJson<String?>(json['contentText']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'questionId': serializer.toJson<int>(questionId),
      'type': serializer.toJson<String>(type),
      'format': serializer.toJson<String>(format),
      'sourceType': serializer.toJson<String>(sourceType),
      'sourceDescription': serializer.toJson<String?>(sourceDescription),
      'contentText': serializer.toJson<String?>(contentText),
      'imagePath': serializer.toJson<String?>(imagePath),
      'isVerified': serializer.toJson<bool>(isVerified),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AnswerResource copyWith(
          {int? id,
          int? questionId,
          String? type,
          String? format,
          String? sourceType,
          Value<String?> sourceDescription = const Value.absent(),
          Value<String?> contentText = const Value.absent(),
          Value<String?> imagePath = const Value.absent(),
          bool? isVerified,
          DateTime? createdAt}) =>
      AnswerResource(
        id: id ?? this.id,
        questionId: questionId ?? this.questionId,
        type: type ?? this.type,
        format: format ?? this.format,
        sourceType: sourceType ?? this.sourceType,
        sourceDescription: sourceDescription.present
            ? sourceDescription.value
            : this.sourceDescription,
        contentText: contentText.present ? contentText.value : this.contentText,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
        isVerified: isVerified ?? this.isVerified,
        createdAt: createdAt ?? this.createdAt,
      );
  AnswerResource copyWithCompanion(AnswerResourcesCompanion data) {
    return AnswerResource(
      id: data.id.present ? data.id.value : this.id,
      questionId:
          data.questionId.present ? data.questionId.value : this.questionId,
      type: data.type.present ? data.type.value : this.type,
      format: data.format.present ? data.format.value : this.format,
      sourceType:
          data.sourceType.present ? data.sourceType.value : this.sourceType,
      sourceDescription: data.sourceDescription.present
          ? data.sourceDescription.value
          : this.sourceDescription,
      contentText:
          data.contentText.present ? data.contentText.value : this.contentText,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      isVerified:
          data.isVerified.present ? data.isVerified.value : this.isVerified,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnswerResource(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('type: $type, ')
          ..write('format: $format, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceDescription: $sourceDescription, ')
          ..write('contentText: $contentText, ')
          ..write('imagePath: $imagePath, ')
          ..write('isVerified: $isVerified, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, questionId, type, format, sourceType,
      sourceDescription, contentText, imagePath, isVerified, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnswerResource &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.type == this.type &&
          other.format == this.format &&
          other.sourceType == this.sourceType &&
          other.sourceDescription == this.sourceDescription &&
          other.contentText == this.contentText &&
          other.imagePath == this.imagePath &&
          other.isVerified == this.isVerified &&
          other.createdAt == this.createdAt);
}

class AnswerResourcesCompanion extends UpdateCompanion<AnswerResource> {
  final Value<int> id;
  final Value<int> questionId;
  final Value<String> type;
  final Value<String> format;
  final Value<String> sourceType;
  final Value<String?> sourceDescription;
  final Value<String?> contentText;
  final Value<String?> imagePath;
  final Value<bool> isVerified;
  final Value<DateTime> createdAt;
  const AnswerResourcesCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.type = const Value.absent(),
    this.format = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceDescription = const Value.absent(),
    this.contentText = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AnswerResourcesCompanion.insert({
    this.id = const Value.absent(),
    required int questionId,
    this.type = const Value.absent(),
    this.format = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceDescription = const Value.absent(),
    this.contentText = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : questionId = Value(questionId);
  static Insertable<AnswerResource> custom({
    Expression<int>? id,
    Expression<int>? questionId,
    Expression<String>? type,
    Expression<String>? format,
    Expression<String>? sourceType,
    Expression<String>? sourceDescription,
    Expression<String>? contentText,
    Expression<String>? imagePath,
    Expression<bool>? isVerified,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionId != null) 'question_id': questionId,
      if (type != null) 'type': type,
      if (format != null) 'format': format,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceDescription != null) 'source_description': sourceDescription,
      if (contentText != null) 'content_text': contentText,
      if (imagePath != null) 'image_path': imagePath,
      if (isVerified != null) 'is_verified': isVerified,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AnswerResourcesCompanion copyWith(
      {Value<int>? id,
      Value<int>? questionId,
      Value<String>? type,
      Value<String>? format,
      Value<String>? sourceType,
      Value<String?>? sourceDescription,
      Value<String?>? contentText,
      Value<String?>? imagePath,
      Value<bool>? isVerified,
      Value<DateTime>? createdAt}) {
    return AnswerResourcesCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      type: type ?? this.type,
      format: format ?? this.format,
      sourceType: sourceType ?? this.sourceType,
      sourceDescription: sourceDescription ?? this.sourceDescription,
      contentText: contentText ?? this.contentText,
      imagePath: imagePath ?? this.imagePath,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<int>(questionId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (sourceDescription.present) {
      map['source_description'] = Variable<String>(sourceDescription.value);
    }
    if (contentText.present) {
      map['content_text'] = Variable<String>(contentText.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnswerResourcesCompanion(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('type: $type, ')
          ..write('format: $format, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceDescription: $sourceDescription, ')
          ..write('contentText: $contentText, ')
          ..write('imagePath: $imagePath, ')
          ..write('isVerified: $isVerified, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BlockVersionsTable extends BlockVersions
    with TableInfo<$BlockVersionsTable, BlockVersion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlockVersionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _blockIdMeta =
      const VerificationMeta('blockId');
  @override
  late final GeneratedColumn<int> blockId = GeneratedColumn<int>(
      'block_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES blocks (id) ON DELETE CASCADE'));
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
      'method', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceImagePathMeta =
      const VerificationMeta('sourceImagePath');
  @override
  late final GeneratedColumn<String> sourceImagePath = GeneratedColumn<String>(
      'source_image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _processedImagePathMeta =
      const VerificationMeta('processedImagePath');
  @override
  late final GeneratedColumn<String> processedImagePath =
      GeneratedColumn<String>('processed_image_path', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _maskPathMeta =
      const VerificationMeta('maskPath');
  @override
  late final GeneratedColumn<String> maskPath = GeneratedColumn<String>(
      'mask_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
      'model', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _verifiedMeta =
      const VerificationMeta('verified');
  @override
  late final GeneratedColumn<bool> verified = GeneratedColumn<bool>(
      'verified', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("verified" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _useForPrintMeta =
      const VerificationMeta('useForPrint');
  @override
  late final GeneratedColumn<bool> useForPrint = GeneratedColumn<bool>(
      'use_for_print', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("use_for_print" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        blockId,
        method,
        sourceImagePath,
        processedImagePath,
        maskPath,
        model,
        verified,
        useForPrint,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'block_versions';
  @override
  VerificationContext validateIntegrity(Insertable<BlockVersion> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('block_id')) {
      context.handle(_blockIdMeta,
          blockId.isAcceptableOrUnknown(data['block_id']!, _blockIdMeta));
    } else if (isInserting) {
      context.missing(_blockIdMeta);
    }
    if (data.containsKey('method')) {
      context.handle(_methodMeta,
          method.isAcceptableOrUnknown(data['method']!, _methodMeta));
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('source_image_path')) {
      context.handle(
          _sourceImagePathMeta,
          sourceImagePath.isAcceptableOrUnknown(
              data['source_image_path']!, _sourceImagePathMeta));
    }
    if (data.containsKey('processed_image_path')) {
      context.handle(
          _processedImagePathMeta,
          processedImagePath.isAcceptableOrUnknown(
              data['processed_image_path']!, _processedImagePathMeta));
    }
    if (data.containsKey('mask_path')) {
      context.handle(_maskPathMeta,
          maskPath.isAcceptableOrUnknown(data['mask_path']!, _maskPathMeta));
    }
    if (data.containsKey('model')) {
      context.handle(
          _modelMeta, model.isAcceptableOrUnknown(data['model']!, _modelMeta));
    }
    if (data.containsKey('verified')) {
      context.handle(_verifiedMeta,
          verified.isAcceptableOrUnknown(data['verified']!, _verifiedMeta));
    }
    if (data.containsKey('use_for_print')) {
      context.handle(
          _useForPrintMeta,
          useForPrint.isAcceptableOrUnknown(
              data['use_for_print']!, _useForPrintMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BlockVersion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BlockVersion(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      blockId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}block_id'])!,
      method: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}method'])!,
      sourceImagePath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}source_image_path']),
      processedImagePath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}processed_image_path']),
      maskPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mask_path']),
      model: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model']),
      verified: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}verified'])!,
      useForPrint: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}use_for_print'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $BlockVersionsTable createAlias(String alias) {
    return $BlockVersionsTable(attachedDatabase, alias);
  }
}

class BlockVersion extends DataClass implements Insertable<BlockVersion> {
  final int id;
  final int blockId;

  /// original / traditional / aiMaskLocal / aiEdit / manual
  final String method;
  final String? sourceImagePath;
  final String? processedImagePath;
  final String? maskPath;
  final String? model;
  final bool verified;
  final bool useForPrint;
  final DateTime createdAt;
  const BlockVersion(
      {required this.id,
      required this.blockId,
      required this.method,
      this.sourceImagePath,
      this.processedImagePath,
      this.maskPath,
      this.model,
      required this.verified,
      required this.useForPrint,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['block_id'] = Variable<int>(blockId);
    map['method'] = Variable<String>(method);
    if (!nullToAbsent || sourceImagePath != null) {
      map['source_image_path'] = Variable<String>(sourceImagePath);
    }
    if (!nullToAbsent || processedImagePath != null) {
      map['processed_image_path'] = Variable<String>(processedImagePath);
    }
    if (!nullToAbsent || maskPath != null) {
      map['mask_path'] = Variable<String>(maskPath);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    map['verified'] = Variable<bool>(verified);
    map['use_for_print'] = Variable<bool>(useForPrint);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BlockVersionsCompanion toCompanion(bool nullToAbsent) {
    return BlockVersionsCompanion(
      id: Value(id),
      blockId: Value(blockId),
      method: Value(method),
      sourceImagePath: sourceImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceImagePath),
      processedImagePath: processedImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(processedImagePath),
      maskPath: maskPath == null && nullToAbsent
          ? const Value.absent()
          : Value(maskPath),
      model:
          model == null && nullToAbsent ? const Value.absent() : Value(model),
      verified: Value(verified),
      useForPrint: Value(useForPrint),
      createdAt: Value(createdAt),
    );
  }

  factory BlockVersion.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BlockVersion(
      id: serializer.fromJson<int>(json['id']),
      blockId: serializer.fromJson<int>(json['blockId']),
      method: serializer.fromJson<String>(json['method']),
      sourceImagePath: serializer.fromJson<String?>(json['sourceImagePath']),
      processedImagePath:
          serializer.fromJson<String?>(json['processedImagePath']),
      maskPath: serializer.fromJson<String?>(json['maskPath']),
      model: serializer.fromJson<String?>(json['model']),
      verified: serializer.fromJson<bool>(json['verified']),
      useForPrint: serializer.fromJson<bool>(json['useForPrint']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'blockId': serializer.toJson<int>(blockId),
      'method': serializer.toJson<String>(method),
      'sourceImagePath': serializer.toJson<String?>(sourceImagePath),
      'processedImagePath': serializer.toJson<String?>(processedImagePath),
      'maskPath': serializer.toJson<String?>(maskPath),
      'model': serializer.toJson<String?>(model),
      'verified': serializer.toJson<bool>(verified),
      'useForPrint': serializer.toJson<bool>(useForPrint),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BlockVersion copyWith(
          {int? id,
          int? blockId,
          String? method,
          Value<String?> sourceImagePath = const Value.absent(),
          Value<String?> processedImagePath = const Value.absent(),
          Value<String?> maskPath = const Value.absent(),
          Value<String?> model = const Value.absent(),
          bool? verified,
          bool? useForPrint,
          DateTime? createdAt}) =>
      BlockVersion(
        id: id ?? this.id,
        blockId: blockId ?? this.blockId,
        method: method ?? this.method,
        sourceImagePath: sourceImagePath.present
            ? sourceImagePath.value
            : this.sourceImagePath,
        processedImagePath: processedImagePath.present
            ? processedImagePath.value
            : this.processedImagePath,
        maskPath: maskPath.present ? maskPath.value : this.maskPath,
        model: model.present ? model.value : this.model,
        verified: verified ?? this.verified,
        useForPrint: useForPrint ?? this.useForPrint,
        createdAt: createdAt ?? this.createdAt,
      );
  BlockVersion copyWithCompanion(BlockVersionsCompanion data) {
    return BlockVersion(
      id: data.id.present ? data.id.value : this.id,
      blockId: data.blockId.present ? data.blockId.value : this.blockId,
      method: data.method.present ? data.method.value : this.method,
      sourceImagePath: data.sourceImagePath.present
          ? data.sourceImagePath.value
          : this.sourceImagePath,
      processedImagePath: data.processedImagePath.present
          ? data.processedImagePath.value
          : this.processedImagePath,
      maskPath: data.maskPath.present ? data.maskPath.value : this.maskPath,
      model: data.model.present ? data.model.value : this.model,
      verified: data.verified.present ? data.verified.value : this.verified,
      useForPrint:
          data.useForPrint.present ? data.useForPrint.value : this.useForPrint,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BlockVersion(')
          ..write('id: $id, ')
          ..write('blockId: $blockId, ')
          ..write('method: $method, ')
          ..write('sourceImagePath: $sourceImagePath, ')
          ..write('processedImagePath: $processedImagePath, ')
          ..write('maskPath: $maskPath, ')
          ..write('model: $model, ')
          ..write('verified: $verified, ')
          ..write('useForPrint: $useForPrint, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, blockId, method, sourceImagePath,
      processedImagePath, maskPath, model, verified, useForPrint, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BlockVersion &&
          other.id == this.id &&
          other.blockId == this.blockId &&
          other.method == this.method &&
          other.sourceImagePath == this.sourceImagePath &&
          other.processedImagePath == this.processedImagePath &&
          other.maskPath == this.maskPath &&
          other.model == this.model &&
          other.verified == this.verified &&
          other.useForPrint == this.useForPrint &&
          other.createdAt == this.createdAt);
}

class BlockVersionsCompanion extends UpdateCompanion<BlockVersion> {
  final Value<int> id;
  final Value<int> blockId;
  final Value<String> method;
  final Value<String?> sourceImagePath;
  final Value<String?> processedImagePath;
  final Value<String?> maskPath;
  final Value<String?> model;
  final Value<bool> verified;
  final Value<bool> useForPrint;
  final Value<DateTime> createdAt;
  const BlockVersionsCompanion({
    this.id = const Value.absent(),
    this.blockId = const Value.absent(),
    this.method = const Value.absent(),
    this.sourceImagePath = const Value.absent(),
    this.processedImagePath = const Value.absent(),
    this.maskPath = const Value.absent(),
    this.model = const Value.absent(),
    this.verified = const Value.absent(),
    this.useForPrint = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BlockVersionsCompanion.insert({
    this.id = const Value.absent(),
    required int blockId,
    required String method,
    this.sourceImagePath = const Value.absent(),
    this.processedImagePath = const Value.absent(),
    this.maskPath = const Value.absent(),
    this.model = const Value.absent(),
    this.verified = const Value.absent(),
    this.useForPrint = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : blockId = Value(blockId),
        method = Value(method);
  static Insertable<BlockVersion> custom({
    Expression<int>? id,
    Expression<int>? blockId,
    Expression<String>? method,
    Expression<String>? sourceImagePath,
    Expression<String>? processedImagePath,
    Expression<String>? maskPath,
    Expression<String>? model,
    Expression<bool>? verified,
    Expression<bool>? useForPrint,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (blockId != null) 'block_id': blockId,
      if (method != null) 'method': method,
      if (sourceImagePath != null) 'source_image_path': sourceImagePath,
      if (processedImagePath != null)
        'processed_image_path': processedImagePath,
      if (maskPath != null) 'mask_path': maskPath,
      if (model != null) 'model': model,
      if (verified != null) 'verified': verified,
      if (useForPrint != null) 'use_for_print': useForPrint,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BlockVersionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? blockId,
      Value<String>? method,
      Value<String?>? sourceImagePath,
      Value<String?>? processedImagePath,
      Value<String?>? maskPath,
      Value<String?>? model,
      Value<bool>? verified,
      Value<bool>? useForPrint,
      Value<DateTime>? createdAt}) {
    return BlockVersionsCompanion(
      id: id ?? this.id,
      blockId: blockId ?? this.blockId,
      method: method ?? this.method,
      sourceImagePath: sourceImagePath ?? this.sourceImagePath,
      processedImagePath: processedImagePath ?? this.processedImagePath,
      maskPath: maskPath ?? this.maskPath,
      model: model ?? this.model,
      verified: verified ?? this.verified,
      useForPrint: useForPrint ?? this.useForPrint,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (blockId.present) {
      map['block_id'] = Variable<int>(blockId.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (sourceImagePath.present) {
      map['source_image_path'] = Variable<String>(sourceImagePath.value);
    }
    if (processedImagePath.present) {
      map['processed_image_path'] = Variable<String>(processedImagePath.value);
    }
    if (maskPath.present) {
      map['mask_path'] = Variable<String>(maskPath.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (verified.present) {
      map['verified'] = Variable<bool>(verified.value);
    }
    if (useForPrint.present) {
      map['use_for_print'] = Variable<bool>(useForPrint.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlockVersionsCompanion(')
          ..write('id: $id, ')
          ..write('blockId: $blockId, ')
          ..write('method: $method, ')
          ..write('sourceImagePath: $sourceImagePath, ')
          ..write('processedImagePath: $processedImagePath, ')
          ..write('maskPath: $maskPath, ')
          ..write('model: $model, ')
          ..write('verified: $verified, ')
          ..write('useForPrint: $useForPrint, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AiUnderstandingsTable extends AiUnderstandings
    with TableInfo<$AiUnderstandingsTable, AiUnderstanding> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiUnderstandingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<int> questionId = GeneratedColumn<int>(
      'question_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES questions (id) ON DELETE CASCADE'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('none'));
  static const VerificationMeta _questionTypeMeta =
      const VerificationMeta('questionType');
  @override
  late final GeneratedColumn<String> questionType = GeneratedColumn<String>(
      'question_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _knowledgePointMeta =
      const VerificationMeta('knowledgePoint');
  @override
  late final GeneratedColumn<String> knowledgePoint = GeneratedColumn<String>(
      'knowledge_point', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
      'difficulty', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _summaryMeta =
      const VerificationMeta('summary');
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
      'summary', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _answerMeta = const VerificationMeta('answer');
  @override
  late final GeneratedColumn<String> answer = GeneratedColumn<String>(
      'answer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _solutionMeta =
      const VerificationMeta('solution');
  @override
  late final GeneratedColumn<String> solution = GeneratedColumn<String>(
      'solution', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _approachMeta =
      const VerificationMeta('approach');
  @override
  late final GeneratedColumn<String> approach = GeneratedColumn<String>(
      'approach', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rawJsonMeta =
      const VerificationMeta('rawJson');
  @override
  late final GeneratedColumn<String> rawJson = GeneratedColumn<String>(
      'raw_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
      'model', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
      'error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        questionId,
        status,
        questionType,
        knowledgePoint,
        difficulty,
        summary,
        answer,
        solution,
        approach,
        rawJson,
        model,
        error,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_understandings';
  @override
  VerificationContext validateIntegrity(Insertable<AiUnderstanding> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('question_type')) {
      context.handle(
          _questionTypeMeta,
          questionType.isAcceptableOrUnknown(
              data['question_type']!, _questionTypeMeta));
    }
    if (data.containsKey('knowledge_point')) {
      context.handle(
          _knowledgePointMeta,
          knowledgePoint.isAcceptableOrUnknown(
              data['knowledge_point']!, _knowledgePointMeta));
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    }
    if (data.containsKey('summary')) {
      context.handle(_summaryMeta,
          summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta));
    }
    if (data.containsKey('answer')) {
      context.handle(_answerMeta,
          answer.isAcceptableOrUnknown(data['answer']!, _answerMeta));
    }
    if (data.containsKey('solution')) {
      context.handle(_solutionMeta,
          solution.isAcceptableOrUnknown(data['solution']!, _solutionMeta));
    }
    if (data.containsKey('approach')) {
      context.handle(_approachMeta,
          approach.isAcceptableOrUnknown(data['approach']!, _approachMeta));
    }
    if (data.containsKey('raw_json')) {
      context.handle(_rawJsonMeta,
          rawJson.isAcceptableOrUnknown(data['raw_json']!, _rawJsonMeta));
    }
    if (data.containsKey('model')) {
      context.handle(
          _modelMeta, model.isAcceptableOrUnknown(data['model']!, _modelMeta));
    }
    if (data.containsKey('error')) {
      context.handle(
          _errorMeta, error.isAcceptableOrUnknown(data['error']!, _errorMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiUnderstanding map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiUnderstanding(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}question_id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      questionType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_type']),
      knowledgePoint: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}knowledge_point']),
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}difficulty']),
      summary: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summary']),
      answer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}answer']),
      solution: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}solution']),
      approach: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}approach']),
      rawJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}raw_json']),
      model: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model']),
      error: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AiUnderstandingsTable createAlias(String alias) {
    return $AiUnderstandingsTable(attachedDatabase, alias);
  }
}

class AiUnderstanding extends DataClass implements Insertable<AiUnderstanding> {
  final int id;
  final int questionId;

  /// none / ok / error
  final String status;
  final String? questionType;
  final String? knowledgePoint;
  final String? difficulty;
  final String? summary;
  final String? answer;
  final String? solution;
  final String? approach;
  final String? rawJson;
  final String? model;
  final String? error;
  final DateTime updatedAt;
  const AiUnderstanding(
      {required this.id,
      required this.questionId,
      required this.status,
      this.questionType,
      this.knowledgePoint,
      this.difficulty,
      this.summary,
      this.answer,
      this.solution,
      this.approach,
      this.rawJson,
      this.model,
      this.error,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['question_id'] = Variable<int>(questionId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || questionType != null) {
      map['question_type'] = Variable<String>(questionType);
    }
    if (!nullToAbsent || knowledgePoint != null) {
      map['knowledge_point'] = Variable<String>(knowledgePoint);
    }
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<String>(difficulty);
    }
    if (!nullToAbsent || summary != null) {
      map['summary'] = Variable<String>(summary);
    }
    if (!nullToAbsent || answer != null) {
      map['answer'] = Variable<String>(answer);
    }
    if (!nullToAbsent || solution != null) {
      map['solution'] = Variable<String>(solution);
    }
    if (!nullToAbsent || approach != null) {
      map['approach'] = Variable<String>(approach);
    }
    if (!nullToAbsent || rawJson != null) {
      map['raw_json'] = Variable<String>(rawJson);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || error != null) {
      map['error'] = Variable<String>(error);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AiUnderstandingsCompanion toCompanion(bool nullToAbsent) {
    return AiUnderstandingsCompanion(
      id: Value(id),
      questionId: Value(questionId),
      status: Value(status),
      questionType: questionType == null && nullToAbsent
          ? const Value.absent()
          : Value(questionType),
      knowledgePoint: knowledgePoint == null && nullToAbsent
          ? const Value.absent()
          : Value(knowledgePoint),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      summary: summary == null && nullToAbsent
          ? const Value.absent()
          : Value(summary),
      answer:
          answer == null && nullToAbsent ? const Value.absent() : Value(answer),
      solution: solution == null && nullToAbsent
          ? const Value.absent()
          : Value(solution),
      approach: approach == null && nullToAbsent
          ? const Value.absent()
          : Value(approach),
      rawJson: rawJson == null && nullToAbsent
          ? const Value.absent()
          : Value(rawJson),
      model:
          model == null && nullToAbsent ? const Value.absent() : Value(model),
      error:
          error == null && nullToAbsent ? const Value.absent() : Value(error),
      updatedAt: Value(updatedAt),
    );
  }

  factory AiUnderstanding.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiUnderstanding(
      id: serializer.fromJson<int>(json['id']),
      questionId: serializer.fromJson<int>(json['questionId']),
      status: serializer.fromJson<String>(json['status']),
      questionType: serializer.fromJson<String?>(json['questionType']),
      knowledgePoint: serializer.fromJson<String?>(json['knowledgePoint']),
      difficulty: serializer.fromJson<String?>(json['difficulty']),
      summary: serializer.fromJson<String?>(json['summary']),
      answer: serializer.fromJson<String?>(json['answer']),
      solution: serializer.fromJson<String?>(json['solution']),
      approach: serializer.fromJson<String?>(json['approach']),
      rawJson: serializer.fromJson<String?>(json['rawJson']),
      model: serializer.fromJson<String?>(json['model']),
      error: serializer.fromJson<String?>(json['error']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'questionId': serializer.toJson<int>(questionId),
      'status': serializer.toJson<String>(status),
      'questionType': serializer.toJson<String?>(questionType),
      'knowledgePoint': serializer.toJson<String?>(knowledgePoint),
      'difficulty': serializer.toJson<String?>(difficulty),
      'summary': serializer.toJson<String?>(summary),
      'answer': serializer.toJson<String?>(answer),
      'solution': serializer.toJson<String?>(solution),
      'approach': serializer.toJson<String?>(approach),
      'rawJson': serializer.toJson<String?>(rawJson),
      'model': serializer.toJson<String?>(model),
      'error': serializer.toJson<String?>(error),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AiUnderstanding copyWith(
          {int? id,
          int? questionId,
          String? status,
          Value<String?> questionType = const Value.absent(),
          Value<String?> knowledgePoint = const Value.absent(),
          Value<String?> difficulty = const Value.absent(),
          Value<String?> summary = const Value.absent(),
          Value<String?> answer = const Value.absent(),
          Value<String?> solution = const Value.absent(),
          Value<String?> approach = const Value.absent(),
          Value<String?> rawJson = const Value.absent(),
          Value<String?> model = const Value.absent(),
          Value<String?> error = const Value.absent(),
          DateTime? updatedAt}) =>
      AiUnderstanding(
        id: id ?? this.id,
        questionId: questionId ?? this.questionId,
        status: status ?? this.status,
        questionType:
            questionType.present ? questionType.value : this.questionType,
        knowledgePoint:
            knowledgePoint.present ? knowledgePoint.value : this.knowledgePoint,
        difficulty: difficulty.present ? difficulty.value : this.difficulty,
        summary: summary.present ? summary.value : this.summary,
        answer: answer.present ? answer.value : this.answer,
        solution: solution.present ? solution.value : this.solution,
        approach: approach.present ? approach.value : this.approach,
        rawJson: rawJson.present ? rawJson.value : this.rawJson,
        model: model.present ? model.value : this.model,
        error: error.present ? error.value : this.error,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AiUnderstanding copyWithCompanion(AiUnderstandingsCompanion data) {
    return AiUnderstanding(
      id: data.id.present ? data.id.value : this.id,
      questionId:
          data.questionId.present ? data.questionId.value : this.questionId,
      status: data.status.present ? data.status.value : this.status,
      questionType: data.questionType.present
          ? data.questionType.value
          : this.questionType,
      knowledgePoint: data.knowledgePoint.present
          ? data.knowledgePoint.value
          : this.knowledgePoint,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      summary: data.summary.present ? data.summary.value : this.summary,
      answer: data.answer.present ? data.answer.value : this.answer,
      solution: data.solution.present ? data.solution.value : this.solution,
      approach: data.approach.present ? data.approach.value : this.approach,
      rawJson: data.rawJson.present ? data.rawJson.value : this.rawJson,
      model: data.model.present ? data.model.value : this.model,
      error: data.error.present ? data.error.value : this.error,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiUnderstanding(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('status: $status, ')
          ..write('questionType: $questionType, ')
          ..write('knowledgePoint: $knowledgePoint, ')
          ..write('difficulty: $difficulty, ')
          ..write('summary: $summary, ')
          ..write('answer: $answer, ')
          ..write('solution: $solution, ')
          ..write('approach: $approach, ')
          ..write('rawJson: $rawJson, ')
          ..write('model: $model, ')
          ..write('error: $error, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      questionId,
      status,
      questionType,
      knowledgePoint,
      difficulty,
      summary,
      answer,
      solution,
      approach,
      rawJson,
      model,
      error,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiUnderstanding &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.status == this.status &&
          other.questionType == this.questionType &&
          other.knowledgePoint == this.knowledgePoint &&
          other.difficulty == this.difficulty &&
          other.summary == this.summary &&
          other.answer == this.answer &&
          other.solution == this.solution &&
          other.approach == this.approach &&
          other.rawJson == this.rawJson &&
          other.model == this.model &&
          other.error == this.error &&
          other.updatedAt == this.updatedAt);
}

class AiUnderstandingsCompanion extends UpdateCompanion<AiUnderstanding> {
  final Value<int> id;
  final Value<int> questionId;
  final Value<String> status;
  final Value<String?> questionType;
  final Value<String?> knowledgePoint;
  final Value<String?> difficulty;
  final Value<String?> summary;
  final Value<String?> answer;
  final Value<String?> solution;
  final Value<String?> approach;
  final Value<String?> rawJson;
  final Value<String?> model;
  final Value<String?> error;
  final Value<DateTime> updatedAt;
  const AiUnderstandingsCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.status = const Value.absent(),
    this.questionType = const Value.absent(),
    this.knowledgePoint = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.summary = const Value.absent(),
    this.answer = const Value.absent(),
    this.solution = const Value.absent(),
    this.approach = const Value.absent(),
    this.rawJson = const Value.absent(),
    this.model = const Value.absent(),
    this.error = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AiUnderstandingsCompanion.insert({
    this.id = const Value.absent(),
    required int questionId,
    this.status = const Value.absent(),
    this.questionType = const Value.absent(),
    this.knowledgePoint = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.summary = const Value.absent(),
    this.answer = const Value.absent(),
    this.solution = const Value.absent(),
    this.approach = const Value.absent(),
    this.rawJson = const Value.absent(),
    this.model = const Value.absent(),
    this.error = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : questionId = Value(questionId);
  static Insertable<AiUnderstanding> custom({
    Expression<int>? id,
    Expression<int>? questionId,
    Expression<String>? status,
    Expression<String>? questionType,
    Expression<String>? knowledgePoint,
    Expression<String>? difficulty,
    Expression<String>? summary,
    Expression<String>? answer,
    Expression<String>? solution,
    Expression<String>? approach,
    Expression<String>? rawJson,
    Expression<String>? model,
    Expression<String>? error,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionId != null) 'question_id': questionId,
      if (status != null) 'status': status,
      if (questionType != null) 'question_type': questionType,
      if (knowledgePoint != null) 'knowledge_point': knowledgePoint,
      if (difficulty != null) 'difficulty': difficulty,
      if (summary != null) 'summary': summary,
      if (answer != null) 'answer': answer,
      if (solution != null) 'solution': solution,
      if (approach != null) 'approach': approach,
      if (rawJson != null) 'raw_json': rawJson,
      if (model != null) 'model': model,
      if (error != null) 'error': error,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AiUnderstandingsCompanion copyWith(
      {Value<int>? id,
      Value<int>? questionId,
      Value<String>? status,
      Value<String?>? questionType,
      Value<String?>? knowledgePoint,
      Value<String?>? difficulty,
      Value<String?>? summary,
      Value<String?>? answer,
      Value<String?>? solution,
      Value<String?>? approach,
      Value<String?>? rawJson,
      Value<String?>? model,
      Value<String?>? error,
      Value<DateTime>? updatedAt}) {
    return AiUnderstandingsCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      status: status ?? this.status,
      questionType: questionType ?? this.questionType,
      knowledgePoint: knowledgePoint ?? this.knowledgePoint,
      difficulty: difficulty ?? this.difficulty,
      summary: summary ?? this.summary,
      answer: answer ?? this.answer,
      solution: solution ?? this.solution,
      approach: approach ?? this.approach,
      rawJson: rawJson ?? this.rawJson,
      model: model ?? this.model,
      error: error ?? this.error,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<int>(questionId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (questionType.present) {
      map['question_type'] = Variable<String>(questionType.value);
    }
    if (knowledgePoint.present) {
      map['knowledge_point'] = Variable<String>(knowledgePoint.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    if (solution.present) {
      map['solution'] = Variable<String>(solution.value);
    }
    if (approach.present) {
      map['approach'] = Variable<String>(approach.value);
    }
    if (rawJson.present) {
      map['raw_json'] = Variable<String>(rawJson.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (error.present) {
      map['error'] = Variable<String>(error.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiUnderstandingsCompanion(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('status: $status, ')
          ..write('questionType: $questionType, ')
          ..write('knowledgePoint: $knowledgePoint, ')
          ..write('difficulty: $difficulty, ')
          ..write('summary: $summary, ')
          ..write('answer: $answer, ')
          ..write('solution: $solution, ')
          ..write('approach: $approach, ')
          ..write('rawJson: $rawJson, ')
          ..write('model: $model, ')
          ..write('error: $error, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AiMistakesTable extends AiMistakes
    with TableInfo<$AiMistakesTable, AiMistake> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiMistakesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<int> questionId = GeneratedColumn<int>(
      'question_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES questions (id) ON DELETE CASCADE'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('none'));
  static const VerificationMeta _errorTypeMeta =
      const VerificationMeta('errorType');
  @override
  late final GeneratedColumn<String> errorType = GeneratedColumn<String>(
      'error_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _errorStepMeta =
      const VerificationMeta('errorStep');
  @override
  late final GeneratedColumn<String> errorStep = GeneratedColumn<String>(
      'error_step', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
      'reason', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reviewSuggestionMeta =
      const VerificationMeta('reviewSuggestion');
  @override
  late final GeneratedColumn<String> reviewSuggestion = GeneratedColumn<String>(
      'review_suggestion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rawJsonMeta =
      const VerificationMeta('rawJson');
  @override
  late final GeneratedColumn<String> rawJson = GeneratedColumn<String>(
      'raw_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
      'model', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
      'error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        questionId,
        status,
        errorType,
        errorStep,
        reason,
        reviewSuggestion,
        rawJson,
        model,
        error,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_mistakes';
  @override
  VerificationContext validateIntegrity(Insertable<AiMistake> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('error_type')) {
      context.handle(_errorTypeMeta,
          errorType.isAcceptableOrUnknown(data['error_type']!, _errorTypeMeta));
    }
    if (data.containsKey('error_step')) {
      context.handle(_errorStepMeta,
          errorStep.isAcceptableOrUnknown(data['error_step']!, _errorStepMeta));
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    }
    if (data.containsKey('review_suggestion')) {
      context.handle(
          _reviewSuggestionMeta,
          reviewSuggestion.isAcceptableOrUnknown(
              data['review_suggestion']!, _reviewSuggestionMeta));
    }
    if (data.containsKey('raw_json')) {
      context.handle(_rawJsonMeta,
          rawJson.isAcceptableOrUnknown(data['raw_json']!, _rawJsonMeta));
    }
    if (data.containsKey('model')) {
      context.handle(
          _modelMeta, model.isAcceptableOrUnknown(data['model']!, _modelMeta));
    }
    if (data.containsKey('error')) {
      context.handle(
          _errorMeta, error.isAcceptableOrUnknown(data['error']!, _errorMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiMistake map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiMistake(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}question_id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      errorType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_type']),
      errorStep: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_step']),
      reason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason']),
      reviewSuggestion: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}review_suggestion']),
      rawJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}raw_json']),
      model: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model']),
      error: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AiMistakesTable createAlias(String alias) {
    return $AiMistakesTable(attachedDatabase, alias);
  }
}

class AiMistake extends DataClass implements Insertable<AiMistake> {
  final int id;
  final int questionId;

  /// none / ok / error
  final String status;
  final String? errorType;
  final String? errorStep;
  final String? reason;
  final String? reviewSuggestion;
  final String? rawJson;
  final String? model;
  final String? error;
  final DateTime updatedAt;
  const AiMistake(
      {required this.id,
      required this.questionId,
      required this.status,
      this.errorType,
      this.errorStep,
      this.reason,
      this.reviewSuggestion,
      this.rawJson,
      this.model,
      this.error,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['question_id'] = Variable<int>(questionId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorType != null) {
      map['error_type'] = Variable<String>(errorType);
    }
    if (!nullToAbsent || errorStep != null) {
      map['error_step'] = Variable<String>(errorStep);
    }
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    if (!nullToAbsent || reviewSuggestion != null) {
      map['review_suggestion'] = Variable<String>(reviewSuggestion);
    }
    if (!nullToAbsent || rawJson != null) {
      map['raw_json'] = Variable<String>(rawJson);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || error != null) {
      map['error'] = Variable<String>(error);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AiMistakesCompanion toCompanion(bool nullToAbsent) {
    return AiMistakesCompanion(
      id: Value(id),
      questionId: Value(questionId),
      status: Value(status),
      errorType: errorType == null && nullToAbsent
          ? const Value.absent()
          : Value(errorType),
      errorStep: errorStep == null && nullToAbsent
          ? const Value.absent()
          : Value(errorStep),
      reason:
          reason == null && nullToAbsent ? const Value.absent() : Value(reason),
      reviewSuggestion: reviewSuggestion == null && nullToAbsent
          ? const Value.absent()
          : Value(reviewSuggestion),
      rawJson: rawJson == null && nullToAbsent
          ? const Value.absent()
          : Value(rawJson),
      model:
          model == null && nullToAbsent ? const Value.absent() : Value(model),
      error:
          error == null && nullToAbsent ? const Value.absent() : Value(error),
      updatedAt: Value(updatedAt),
    );
  }

  factory AiMistake.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiMistake(
      id: serializer.fromJson<int>(json['id']),
      questionId: serializer.fromJson<int>(json['questionId']),
      status: serializer.fromJson<String>(json['status']),
      errorType: serializer.fromJson<String?>(json['errorType']),
      errorStep: serializer.fromJson<String?>(json['errorStep']),
      reason: serializer.fromJson<String?>(json['reason']),
      reviewSuggestion: serializer.fromJson<String?>(json['reviewSuggestion']),
      rawJson: serializer.fromJson<String?>(json['rawJson']),
      model: serializer.fromJson<String?>(json['model']),
      error: serializer.fromJson<String?>(json['error']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'questionId': serializer.toJson<int>(questionId),
      'status': serializer.toJson<String>(status),
      'errorType': serializer.toJson<String?>(errorType),
      'errorStep': serializer.toJson<String?>(errorStep),
      'reason': serializer.toJson<String?>(reason),
      'reviewSuggestion': serializer.toJson<String?>(reviewSuggestion),
      'rawJson': serializer.toJson<String?>(rawJson),
      'model': serializer.toJson<String?>(model),
      'error': serializer.toJson<String?>(error),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AiMistake copyWith(
          {int? id,
          int? questionId,
          String? status,
          Value<String?> errorType = const Value.absent(),
          Value<String?> errorStep = const Value.absent(),
          Value<String?> reason = const Value.absent(),
          Value<String?> reviewSuggestion = const Value.absent(),
          Value<String?> rawJson = const Value.absent(),
          Value<String?> model = const Value.absent(),
          Value<String?> error = const Value.absent(),
          DateTime? updatedAt}) =>
      AiMistake(
        id: id ?? this.id,
        questionId: questionId ?? this.questionId,
        status: status ?? this.status,
        errorType: errorType.present ? errorType.value : this.errorType,
        errorStep: errorStep.present ? errorStep.value : this.errorStep,
        reason: reason.present ? reason.value : this.reason,
        reviewSuggestion: reviewSuggestion.present
            ? reviewSuggestion.value
            : this.reviewSuggestion,
        rawJson: rawJson.present ? rawJson.value : this.rawJson,
        model: model.present ? model.value : this.model,
        error: error.present ? error.value : this.error,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AiMistake copyWithCompanion(AiMistakesCompanion data) {
    return AiMistake(
      id: data.id.present ? data.id.value : this.id,
      questionId:
          data.questionId.present ? data.questionId.value : this.questionId,
      status: data.status.present ? data.status.value : this.status,
      errorType: data.errorType.present ? data.errorType.value : this.errorType,
      errorStep: data.errorStep.present ? data.errorStep.value : this.errorStep,
      reason: data.reason.present ? data.reason.value : this.reason,
      reviewSuggestion: data.reviewSuggestion.present
          ? data.reviewSuggestion.value
          : this.reviewSuggestion,
      rawJson: data.rawJson.present ? data.rawJson.value : this.rawJson,
      model: data.model.present ? data.model.value : this.model,
      error: data.error.present ? data.error.value : this.error,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiMistake(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('status: $status, ')
          ..write('errorType: $errorType, ')
          ..write('errorStep: $errorStep, ')
          ..write('reason: $reason, ')
          ..write('reviewSuggestion: $reviewSuggestion, ')
          ..write('rawJson: $rawJson, ')
          ..write('model: $model, ')
          ..write('error: $error, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, questionId, status, errorType, errorStep,
      reason, reviewSuggestion, rawJson, model, error, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiMistake &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.status == this.status &&
          other.errorType == this.errorType &&
          other.errorStep == this.errorStep &&
          other.reason == this.reason &&
          other.reviewSuggestion == this.reviewSuggestion &&
          other.rawJson == this.rawJson &&
          other.model == this.model &&
          other.error == this.error &&
          other.updatedAt == this.updatedAt);
}

class AiMistakesCompanion extends UpdateCompanion<AiMistake> {
  final Value<int> id;
  final Value<int> questionId;
  final Value<String> status;
  final Value<String?> errorType;
  final Value<String?> errorStep;
  final Value<String?> reason;
  final Value<String?> reviewSuggestion;
  final Value<String?> rawJson;
  final Value<String?> model;
  final Value<String?> error;
  final Value<DateTime> updatedAt;
  const AiMistakesCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.status = const Value.absent(),
    this.errorType = const Value.absent(),
    this.errorStep = const Value.absent(),
    this.reason = const Value.absent(),
    this.reviewSuggestion = const Value.absent(),
    this.rawJson = const Value.absent(),
    this.model = const Value.absent(),
    this.error = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AiMistakesCompanion.insert({
    this.id = const Value.absent(),
    required int questionId,
    this.status = const Value.absent(),
    this.errorType = const Value.absent(),
    this.errorStep = const Value.absent(),
    this.reason = const Value.absent(),
    this.reviewSuggestion = const Value.absent(),
    this.rawJson = const Value.absent(),
    this.model = const Value.absent(),
    this.error = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : questionId = Value(questionId);
  static Insertable<AiMistake> custom({
    Expression<int>? id,
    Expression<int>? questionId,
    Expression<String>? status,
    Expression<String>? errorType,
    Expression<String>? errorStep,
    Expression<String>? reason,
    Expression<String>? reviewSuggestion,
    Expression<String>? rawJson,
    Expression<String>? model,
    Expression<String>? error,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionId != null) 'question_id': questionId,
      if (status != null) 'status': status,
      if (errorType != null) 'error_type': errorType,
      if (errorStep != null) 'error_step': errorStep,
      if (reason != null) 'reason': reason,
      if (reviewSuggestion != null) 'review_suggestion': reviewSuggestion,
      if (rawJson != null) 'raw_json': rawJson,
      if (model != null) 'model': model,
      if (error != null) 'error': error,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AiMistakesCompanion copyWith(
      {Value<int>? id,
      Value<int>? questionId,
      Value<String>? status,
      Value<String?>? errorType,
      Value<String?>? errorStep,
      Value<String?>? reason,
      Value<String?>? reviewSuggestion,
      Value<String?>? rawJson,
      Value<String?>? model,
      Value<String?>? error,
      Value<DateTime>? updatedAt}) {
    return AiMistakesCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      status: status ?? this.status,
      errorType: errorType ?? this.errorType,
      errorStep: errorStep ?? this.errorStep,
      reason: reason ?? this.reason,
      reviewSuggestion: reviewSuggestion ?? this.reviewSuggestion,
      rawJson: rawJson ?? this.rawJson,
      model: model ?? this.model,
      error: error ?? this.error,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<int>(questionId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorType.present) {
      map['error_type'] = Variable<String>(errorType.value);
    }
    if (errorStep.present) {
      map['error_step'] = Variable<String>(errorStep.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (reviewSuggestion.present) {
      map['review_suggestion'] = Variable<String>(reviewSuggestion.value);
    }
    if (rawJson.present) {
      map['raw_json'] = Variable<String>(rawJson.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (error.present) {
      map['error'] = Variable<String>(error.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiMistakesCompanion(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('status: $status, ')
          ..write('errorType: $errorType, ')
          ..write('errorStep: $errorStep, ')
          ..write('reason: $reason, ')
          ..write('reviewSuggestion: $reviewSuggestion, ')
          ..write('rawJson: $rawJson, ')
          ..write('model: $model, ')
          ..write('error: $error, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $GeneratedExercisesTable extends GeneratedExercises
    with TableInfo<$GeneratedExercisesTable, GeneratedExercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GeneratedExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sourceQuestionIdMeta =
      const VerificationMeta('sourceQuestionId');
  @override
  late final GeneratedColumn<int> sourceQuestionId = GeneratedColumn<int>(
      'source_question_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES questions (id) ON DELETE CASCADE'));
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
      'difficulty', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentJsonMeta =
      const VerificationMeta('contentJson');
  @override
  late final GeneratedColumn<String> contentJson = GeneratedColumn<String>(
      'content_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sourceQuestionId, difficulty, contentJson, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'generated_exercises';
  @override
  VerificationContext validateIntegrity(Insertable<GeneratedExercise> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_question_id')) {
      context.handle(
          _sourceQuestionIdMeta,
          sourceQuestionId.isAcceptableOrUnknown(
              data['source_question_id']!, _sourceQuestionIdMeta));
    } else if (isInserting) {
      context.missing(_sourceQuestionIdMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('content_json')) {
      context.handle(
          _contentJsonMeta,
          contentJson.isAcceptableOrUnknown(
              data['content_json']!, _contentJsonMeta));
    } else if (isInserting) {
      context.missing(_contentJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GeneratedExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GeneratedExercise(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sourceQuestionId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}source_question_id'])!,
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}difficulty'])!,
      contentJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $GeneratedExercisesTable createAlias(String alias) {
    return $GeneratedExercisesTable(attachedDatabase, alias);
  }
}

class GeneratedExercise extends DataClass
    implements Insertable<GeneratedExercise> {
  final int id;
  final int sourceQuestionId;

  /// easy / same / hard（对应 基础/同等/提高）
  final String difficulty;

  /// JSON: {question, answer, solution, knowledgePoint, difficulty, variation}
  final String contentJson;
  final DateTime createdAt;
  const GeneratedExercise(
      {required this.id,
      required this.sourceQuestionId,
      required this.difficulty,
      required this.contentJson,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source_question_id'] = Variable<int>(sourceQuestionId);
    map['difficulty'] = Variable<String>(difficulty);
    map['content_json'] = Variable<String>(contentJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GeneratedExercisesCompanion toCompanion(bool nullToAbsent) {
    return GeneratedExercisesCompanion(
      id: Value(id),
      sourceQuestionId: Value(sourceQuestionId),
      difficulty: Value(difficulty),
      contentJson: Value(contentJson),
      createdAt: Value(createdAt),
    );
  }

  factory GeneratedExercise.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GeneratedExercise(
      id: serializer.fromJson<int>(json['id']),
      sourceQuestionId: serializer.fromJson<int>(json['sourceQuestionId']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      contentJson: serializer.fromJson<String>(json['contentJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceQuestionId': serializer.toJson<int>(sourceQuestionId),
      'difficulty': serializer.toJson<String>(difficulty),
      'contentJson': serializer.toJson<String>(contentJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  GeneratedExercise copyWith(
          {int? id,
          int? sourceQuestionId,
          String? difficulty,
          String? contentJson,
          DateTime? createdAt}) =>
      GeneratedExercise(
        id: id ?? this.id,
        sourceQuestionId: sourceQuestionId ?? this.sourceQuestionId,
        difficulty: difficulty ?? this.difficulty,
        contentJson: contentJson ?? this.contentJson,
        createdAt: createdAt ?? this.createdAt,
      );
  GeneratedExercise copyWithCompanion(GeneratedExercisesCompanion data) {
    return GeneratedExercise(
      id: data.id.present ? data.id.value : this.id,
      sourceQuestionId: data.sourceQuestionId.present
          ? data.sourceQuestionId.value
          : this.sourceQuestionId,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      contentJson:
          data.contentJson.present ? data.contentJson.value : this.contentJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GeneratedExercise(')
          ..write('id: $id, ')
          ..write('sourceQuestionId: $sourceQuestionId, ')
          ..write('difficulty: $difficulty, ')
          ..write('contentJson: $contentJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sourceQuestionId, difficulty, contentJson, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GeneratedExercise &&
          other.id == this.id &&
          other.sourceQuestionId == this.sourceQuestionId &&
          other.difficulty == this.difficulty &&
          other.contentJson == this.contentJson &&
          other.createdAt == this.createdAt);
}

class GeneratedExercisesCompanion extends UpdateCompanion<GeneratedExercise> {
  final Value<int> id;
  final Value<int> sourceQuestionId;
  final Value<String> difficulty;
  final Value<String> contentJson;
  final Value<DateTime> createdAt;
  const GeneratedExercisesCompanion({
    this.id = const Value.absent(),
    this.sourceQuestionId = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.contentJson = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  GeneratedExercisesCompanion.insert({
    this.id = const Value.absent(),
    required int sourceQuestionId,
    required String difficulty,
    required String contentJson,
    this.createdAt = const Value.absent(),
  })  : sourceQuestionId = Value(sourceQuestionId),
        difficulty = Value(difficulty),
        contentJson = Value(contentJson);
  static Insertable<GeneratedExercise> custom({
    Expression<int>? id,
    Expression<int>? sourceQuestionId,
    Expression<String>? difficulty,
    Expression<String>? contentJson,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceQuestionId != null) 'source_question_id': sourceQuestionId,
      if (difficulty != null) 'difficulty': difficulty,
      if (contentJson != null) 'content_json': contentJson,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  GeneratedExercisesCompanion copyWith(
      {Value<int>? id,
      Value<int>? sourceQuestionId,
      Value<String>? difficulty,
      Value<String>? contentJson,
      Value<DateTime>? createdAt}) {
    return GeneratedExercisesCompanion(
      id: id ?? this.id,
      sourceQuestionId: sourceQuestionId ?? this.sourceQuestionId,
      difficulty: difficulty ?? this.difficulty,
      contentJson: contentJson ?? this.contentJson,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceQuestionId.present) {
      map['source_question_id'] = Variable<int>(sourceQuestionId.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (contentJson.present) {
      map['content_json'] = Variable<String>(contentJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GeneratedExercisesCompanion(')
          ..write('id: $id, ')
          ..write('sourceQuestionId: $sourceQuestionId, ')
          ..write('difficulty: $difficulty, ')
          ..write('contentJson: $contentJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PrintItemsTable extends PrintItems
    with TableInfo<$PrintItemsTable, PrintItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrintItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
      'kind', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('question'));
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<int> questionId = GeneratedColumn<int>(
      'question_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _exerciseIdMeta =
      const VerificationMeta('exerciseId');
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
      'exercise_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _answerSpaceMmMeta =
      const VerificationMeta('answerSpaceMm');
  @override
  late final GeneratedColumn<int> answerSpaceMm = GeneratedColumn<int>(
      'answer_space_mm', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(40));
  static const VerificationMeta _forcePageBreakBeforeMeta =
      const VerificationMeta('forcePageBreakBefore');
  @override
  late final GeneratedColumn<bool> forcePageBreakBefore = GeneratedColumn<bool>(
      'force_page_break_before', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("force_page_break_before" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _scaleOverrideMeta =
      const VerificationMeta('scaleOverride');
  @override
  late final GeneratedColumn<double> scaleOverride = GeneratedColumn<double>(
      'scale_override', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _showSourceMeta =
      const VerificationMeta('showSource');
  @override
  late final GeneratedColumn<bool> showSource = GeneratedColumn<bool>(
      'show_source', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("show_source" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _showOriginalNumberMeta =
      const VerificationMeta('showOriginalNumber');
  @override
  late final GeneratedColumn<bool> showOriginalNumber = GeneratedColumn<bool>(
      'show_original_number', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_original_number" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _showAnswerMeta =
      const VerificationMeta('showAnswer');
  @override
  late final GeneratedColumn<bool> showAnswer = GeneratedColumn<bool>(
      'show_answer', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("show_answer" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        kind,
        questionId,
        exerciseId,
        order,
        answerSpaceMm,
        forcePageBreakBefore,
        scaleOverride,
        showSource,
        showOriginalNumber,
        showAnswer,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'print_items';
  @override
  VerificationContext validateIntegrity(Insertable<PrintItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kind')) {
      context.handle(
          _kindMeta, kind.isAcceptableOrUnknown(data['kind']!, _kindMeta));
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id']!, _exerciseIdMeta));
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    }
    if (data.containsKey('answer_space_mm')) {
      context.handle(
          _answerSpaceMmMeta,
          answerSpaceMm.isAcceptableOrUnknown(
              data['answer_space_mm']!, _answerSpaceMmMeta));
    }
    if (data.containsKey('force_page_break_before')) {
      context.handle(
          _forcePageBreakBeforeMeta,
          forcePageBreakBefore.isAcceptableOrUnknown(
              data['force_page_break_before']!, _forcePageBreakBeforeMeta));
    }
    if (data.containsKey('scale_override')) {
      context.handle(
          _scaleOverrideMeta,
          scaleOverride.isAcceptableOrUnknown(
              data['scale_override']!, _scaleOverrideMeta));
    }
    if (data.containsKey('show_source')) {
      context.handle(
          _showSourceMeta,
          showSource.isAcceptableOrUnknown(
              data['show_source']!, _showSourceMeta));
    }
    if (data.containsKey('show_original_number')) {
      context.handle(
          _showOriginalNumberMeta,
          showOriginalNumber.isAcceptableOrUnknown(
              data['show_original_number']!, _showOriginalNumberMeta));
    }
    if (data.containsKey('show_answer')) {
      context.handle(
          _showAnswerMeta,
          showAnswer.isAcceptableOrUnknown(
              data['show_answer']!, _showAnswerMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrintItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrintItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kind: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kind'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}question_id']),
      exerciseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_id']),
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      answerSpaceMm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}answer_space_mm'])!,
      forcePageBreakBefore: attachedDatabase.typeMapping.read(DriftSqlType.bool,
          data['${effectivePrefix}force_page_break_before'])!,
      scaleOverride: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}scale_override']),
      showSource: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}show_source'])!,
      showOriginalNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}show_original_number'])!,
      showAnswer: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}show_answer'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PrintItemsTable createAlias(String alias) {
    return $PrintItemsTable(attachedDatabase, alias);
  }
}

class PrintItem extends DataClass implements Insertable<PrintItem> {
  final int id;

  /// question / exercise
  final String kind;
  final int? questionId;
  final int? exerciseId;
  final int order;
  final int answerSpaceMm;
  final bool forcePageBreakBefore;
  final double? scaleOverride;
  final bool showSource;
  final bool showOriginalNumber;
  final bool showAnswer;
  final DateTime createdAt;
  const PrintItem(
      {required this.id,
      required this.kind,
      this.questionId,
      this.exerciseId,
      required this.order,
      required this.answerSpaceMm,
      required this.forcePageBreakBefore,
      this.scaleOverride,
      required this.showSource,
      required this.showOriginalNumber,
      required this.showAnswer,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || questionId != null) {
      map['question_id'] = Variable<int>(questionId);
    }
    if (!nullToAbsent || exerciseId != null) {
      map['exercise_id'] = Variable<int>(exerciseId);
    }
    map['order'] = Variable<int>(order);
    map['answer_space_mm'] = Variable<int>(answerSpaceMm);
    map['force_page_break_before'] = Variable<bool>(forcePageBreakBefore);
    if (!nullToAbsent || scaleOverride != null) {
      map['scale_override'] = Variable<double>(scaleOverride);
    }
    map['show_source'] = Variable<bool>(showSource);
    map['show_original_number'] = Variable<bool>(showOriginalNumber);
    map['show_answer'] = Variable<bool>(showAnswer);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PrintItemsCompanion toCompanion(bool nullToAbsent) {
    return PrintItemsCompanion(
      id: Value(id),
      kind: Value(kind),
      questionId: questionId == null && nullToAbsent
          ? const Value.absent()
          : Value(questionId),
      exerciseId: exerciseId == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseId),
      order: Value(order),
      answerSpaceMm: Value(answerSpaceMm),
      forcePageBreakBefore: Value(forcePageBreakBefore),
      scaleOverride: scaleOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(scaleOverride),
      showSource: Value(showSource),
      showOriginalNumber: Value(showOriginalNumber),
      showAnswer: Value(showAnswer),
      createdAt: Value(createdAt),
    );
  }

  factory PrintItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrintItem(
      id: serializer.fromJson<int>(json['id']),
      kind: serializer.fromJson<String>(json['kind']),
      questionId: serializer.fromJson<int?>(json['questionId']),
      exerciseId: serializer.fromJson<int?>(json['exerciseId']),
      order: serializer.fromJson<int>(json['order']),
      answerSpaceMm: serializer.fromJson<int>(json['answerSpaceMm']),
      forcePageBreakBefore:
          serializer.fromJson<bool>(json['forcePageBreakBefore']),
      scaleOverride: serializer.fromJson<double?>(json['scaleOverride']),
      showSource: serializer.fromJson<bool>(json['showSource']),
      showOriginalNumber: serializer.fromJson<bool>(json['showOriginalNumber']),
      showAnswer: serializer.fromJson<bool>(json['showAnswer']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kind': serializer.toJson<String>(kind),
      'questionId': serializer.toJson<int?>(questionId),
      'exerciseId': serializer.toJson<int?>(exerciseId),
      'order': serializer.toJson<int>(order),
      'answerSpaceMm': serializer.toJson<int>(answerSpaceMm),
      'forcePageBreakBefore': serializer.toJson<bool>(forcePageBreakBefore),
      'scaleOverride': serializer.toJson<double?>(scaleOverride),
      'showSource': serializer.toJson<bool>(showSource),
      'showOriginalNumber': serializer.toJson<bool>(showOriginalNumber),
      'showAnswer': serializer.toJson<bool>(showAnswer),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PrintItem copyWith(
          {int? id,
          String? kind,
          Value<int?> questionId = const Value.absent(),
          Value<int?> exerciseId = const Value.absent(),
          int? order,
          int? answerSpaceMm,
          bool? forcePageBreakBefore,
          Value<double?> scaleOverride = const Value.absent(),
          bool? showSource,
          bool? showOriginalNumber,
          bool? showAnswer,
          DateTime? createdAt}) =>
      PrintItem(
        id: id ?? this.id,
        kind: kind ?? this.kind,
        questionId: questionId.present ? questionId.value : this.questionId,
        exerciseId: exerciseId.present ? exerciseId.value : this.exerciseId,
        order: order ?? this.order,
        answerSpaceMm: answerSpaceMm ?? this.answerSpaceMm,
        forcePageBreakBefore: forcePageBreakBefore ?? this.forcePageBreakBefore,
        scaleOverride:
            scaleOverride.present ? scaleOverride.value : this.scaleOverride,
        showSource: showSource ?? this.showSource,
        showOriginalNumber: showOriginalNumber ?? this.showOriginalNumber,
        showAnswer: showAnswer ?? this.showAnswer,
        createdAt: createdAt ?? this.createdAt,
      );
  PrintItem copyWithCompanion(PrintItemsCompanion data) {
    return PrintItem(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      questionId:
          data.questionId.present ? data.questionId.value : this.questionId,
      exerciseId:
          data.exerciseId.present ? data.exerciseId.value : this.exerciseId,
      order: data.order.present ? data.order.value : this.order,
      answerSpaceMm: data.answerSpaceMm.present
          ? data.answerSpaceMm.value
          : this.answerSpaceMm,
      forcePageBreakBefore: data.forcePageBreakBefore.present
          ? data.forcePageBreakBefore.value
          : this.forcePageBreakBefore,
      scaleOverride: data.scaleOverride.present
          ? data.scaleOverride.value
          : this.scaleOverride,
      showSource:
          data.showSource.present ? data.showSource.value : this.showSource,
      showOriginalNumber: data.showOriginalNumber.present
          ? data.showOriginalNumber.value
          : this.showOriginalNumber,
      showAnswer:
          data.showAnswer.present ? data.showAnswer.value : this.showAnswer,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrintItem(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('questionId: $questionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('order: $order, ')
          ..write('answerSpaceMm: $answerSpaceMm, ')
          ..write('forcePageBreakBefore: $forcePageBreakBefore, ')
          ..write('scaleOverride: $scaleOverride, ')
          ..write('showSource: $showSource, ')
          ..write('showOriginalNumber: $showOriginalNumber, ')
          ..write('showAnswer: $showAnswer, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      kind,
      questionId,
      exerciseId,
      order,
      answerSpaceMm,
      forcePageBreakBefore,
      scaleOverride,
      showSource,
      showOriginalNumber,
      showAnswer,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrintItem &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.questionId == this.questionId &&
          other.exerciseId == this.exerciseId &&
          other.order == this.order &&
          other.answerSpaceMm == this.answerSpaceMm &&
          other.forcePageBreakBefore == this.forcePageBreakBefore &&
          other.scaleOverride == this.scaleOverride &&
          other.showSource == this.showSource &&
          other.showOriginalNumber == this.showOriginalNumber &&
          other.showAnswer == this.showAnswer &&
          other.createdAt == this.createdAt);
}

class PrintItemsCompanion extends UpdateCompanion<PrintItem> {
  final Value<int> id;
  final Value<String> kind;
  final Value<int?> questionId;
  final Value<int?> exerciseId;
  final Value<int> order;
  final Value<int> answerSpaceMm;
  final Value<bool> forcePageBreakBefore;
  final Value<double?> scaleOverride;
  final Value<bool> showSource;
  final Value<bool> showOriginalNumber;
  final Value<bool> showAnswer;
  final Value<DateTime> createdAt;
  const PrintItemsCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.questionId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.order = const Value.absent(),
    this.answerSpaceMm = const Value.absent(),
    this.forcePageBreakBefore = const Value.absent(),
    this.scaleOverride = const Value.absent(),
    this.showSource = const Value.absent(),
    this.showOriginalNumber = const Value.absent(),
    this.showAnswer = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PrintItemsCompanion.insert({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.questionId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.order = const Value.absent(),
    this.answerSpaceMm = const Value.absent(),
    this.forcePageBreakBefore = const Value.absent(),
    this.scaleOverride = const Value.absent(),
    this.showSource = const Value.absent(),
    this.showOriginalNumber = const Value.absent(),
    this.showAnswer = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<PrintItem> custom({
    Expression<int>? id,
    Expression<String>? kind,
    Expression<int>? questionId,
    Expression<int>? exerciseId,
    Expression<int>? order,
    Expression<int>? answerSpaceMm,
    Expression<bool>? forcePageBreakBefore,
    Expression<double>? scaleOverride,
    Expression<bool>? showSource,
    Expression<bool>? showOriginalNumber,
    Expression<bool>? showAnswer,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (questionId != null) 'question_id': questionId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (order != null) 'order': order,
      if (answerSpaceMm != null) 'answer_space_mm': answerSpaceMm,
      if (forcePageBreakBefore != null)
        'force_page_break_before': forcePageBreakBefore,
      if (scaleOverride != null) 'scale_override': scaleOverride,
      if (showSource != null) 'show_source': showSource,
      if (showOriginalNumber != null)
        'show_original_number': showOriginalNumber,
      if (showAnswer != null) 'show_answer': showAnswer,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PrintItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? kind,
      Value<int?>? questionId,
      Value<int?>? exerciseId,
      Value<int>? order,
      Value<int>? answerSpaceMm,
      Value<bool>? forcePageBreakBefore,
      Value<double?>? scaleOverride,
      Value<bool>? showSource,
      Value<bool>? showOriginalNumber,
      Value<bool>? showAnswer,
      Value<DateTime>? createdAt}) {
    return PrintItemsCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      questionId: questionId ?? this.questionId,
      exerciseId: exerciseId ?? this.exerciseId,
      order: order ?? this.order,
      answerSpaceMm: answerSpaceMm ?? this.answerSpaceMm,
      forcePageBreakBefore: forcePageBreakBefore ?? this.forcePageBreakBefore,
      scaleOverride: scaleOverride ?? this.scaleOverride,
      showSource: showSource ?? this.showSource,
      showOriginalNumber: showOriginalNumber ?? this.showOriginalNumber,
      showAnswer: showAnswer ?? this.showAnswer,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<int>(questionId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (answerSpaceMm.present) {
      map['answer_space_mm'] = Variable<int>(answerSpaceMm.value);
    }
    if (forcePageBreakBefore.present) {
      map['force_page_break_before'] =
          Variable<bool>(forcePageBreakBefore.value);
    }
    if (scaleOverride.present) {
      map['scale_override'] = Variable<double>(scaleOverride.value);
    }
    if (showSource.present) {
      map['show_source'] = Variable<bool>(showSource.value);
    }
    if (showOriginalNumber.present) {
      map['show_original_number'] = Variable<bool>(showOriginalNumber.value);
    }
    if (showAnswer.present) {
      map['show_answer'] = Variable<bool>(showAnswer.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrintItemsCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('questionId: $questionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('order: $order, ')
          ..write('answerSpaceMm: $answerSpaceMm, ')
          ..write('forcePageBreakBefore: $forcePageBreakBefore, ')
          ..write('scaleOverride: $scaleOverride, ')
          ..write('showSource: $showSource, ')
          ..write('showOriginalNumber: $showOriginalNumber, ')
          ..write('showAnswer: $showAnswer, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$MistakeDatabase extends GeneratedDatabase {
  _$MistakeDatabase(QueryExecutor e) : super(e);
  $MistakeDatabaseManager get managers => $MistakeDatabaseManager(this);
  late final $PapersTable papers = $PapersTable(this);
  late final $PagesTable pages = $PagesTable(this);
  late final $QuestionsTable questions = $QuestionsTable(this);
  late final $BlocksTable blocks = $BlocksTable(this);
  late final $AnswerResourcesTable answerResources =
      $AnswerResourcesTable(this);
  late final $BlockVersionsTable blockVersions = $BlockVersionsTable(this);
  late final $AiUnderstandingsTable aiUnderstandings =
      $AiUnderstandingsTable(this);
  late final $AiMistakesTable aiMistakes = $AiMistakesTable(this);
  late final $GeneratedExercisesTable generatedExercises =
      $GeneratedExercisesTable(this);
  late final $PrintItemsTable printItems = $PrintItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        papers,
        pages,
        questions,
        blocks,
        answerResources,
        blockVersions,
        aiUnderstandings,
        aiMistakes,
        generatedExercises,
        printItems
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('papers',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('pages', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('papers',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('questions', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('questions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('blocks', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('pages',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('blocks', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('questions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('answer_resources', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('blocks',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('block_versions', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('questions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('ai_understandings', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('questions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('ai_mistakes', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('questions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('generated_exercises', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$PapersTableCreateCompanionBuilder = PapersCompanion Function({
  Value<int> id,
  required String title,
  Value<String?> subject,
  Value<DateTime?> examDate,
  Value<String?> school,
  Value<String?> grade,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$PapersTableUpdateCompanionBuilder = PapersCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String?> subject,
  Value<DateTime?> examDate,
  Value<String?> school,
  Value<String?> grade,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$PapersTableReferences
    extends BaseReferences<_$MistakeDatabase, $PapersTable, Paper> {
  $$PapersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PagesTable, List<PageRecord>> _pagesRefsTable(
          _$MistakeDatabase db) =>
      MultiTypedResultKey.fromTable(db.pages,
          aliasName: 'papers__id__pages__paper_id');

  $$PagesTableProcessedTableManager get pagesRefs {
    final manager = $$PagesTableTableManager($_db, $_db.pages)
        .filter((f) => f.paperId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pagesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$QuestionsTable, List<Question>>
      _questionsRefsTable(_$MistakeDatabase db) =>
          MultiTypedResultKey.fromTable(db.questions,
              aliasName: 'papers__id__questions__paper_id');

  $$QuestionsTableProcessedTableManager get questionsRefs {
    final manager = $$QuestionsTableTableManager($_db, $_db.questions)
        .filter((f) => f.paperId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_questionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PapersTableFilterComposer
    extends Composer<_$MistakeDatabase, $PapersTable> {
  $$PapersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subject => $composableBuilder(
      column: $table.subject, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get examDate => $composableBuilder(
      column: $table.examDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get school => $composableBuilder(
      column: $table.school, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> pagesRefs(
      Expression<bool> Function($$PagesTableFilterComposer f) f) {
    final $$PagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pages,
        getReferencedColumn: (t) => t.paperId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PagesTableFilterComposer(
              $db: $db,
              $table: $db.pages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> questionsRefs(
      Expression<bool> Function($$QuestionsTableFilterComposer f) f) {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.paperId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableFilterComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PapersTableOrderingComposer
    extends Composer<_$MistakeDatabase, $PapersTable> {
  $$PapersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subject => $composableBuilder(
      column: $table.subject, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get examDate => $composableBuilder(
      column: $table.examDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get school => $composableBuilder(
      column: $table.school, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PapersTableAnnotationComposer
    extends Composer<_$MistakeDatabase, $PapersTable> {
  $$PapersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<DateTime> get examDate =>
      $composableBuilder(column: $table.examDate, builder: (column) => column);

  GeneratedColumn<String> get school =>
      $composableBuilder(column: $table.school, builder: (column) => column);

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> pagesRefs<T extends Object>(
      Expression<T> Function($$PagesTableAnnotationComposer a) f) {
    final $$PagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pages,
        getReferencedColumn: (t) => t.paperId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PagesTableAnnotationComposer(
              $db: $db,
              $table: $db.pages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> questionsRefs<T extends Object>(
      Expression<T> Function($$QuestionsTableAnnotationComposer a) f) {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.paperId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableAnnotationComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PapersTableTableManager extends RootTableManager<
    _$MistakeDatabase,
    $PapersTable,
    Paper,
    $$PapersTableFilterComposer,
    $$PapersTableOrderingComposer,
    $$PapersTableAnnotationComposer,
    $$PapersTableCreateCompanionBuilder,
    $$PapersTableUpdateCompanionBuilder,
    (Paper, $$PapersTableReferences),
    Paper,
    PrefetchHooks Function({bool pagesRefs, bool questionsRefs})> {
  $$PapersTableTableManager(_$MistakeDatabase db, $PapersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PapersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PapersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PapersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> subject = const Value.absent(),
            Value<DateTime?> examDate = const Value.absent(),
            Value<String?> school = const Value.absent(),
            Value<String?> grade = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PapersCompanion(
            id: id,
            title: title,
            subject: subject,
            examDate: examDate,
            school: school,
            grade: grade,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            Value<String?> subject = const Value.absent(),
            Value<DateTime?> examDate = const Value.absent(),
            Value<String?> school = const Value.absent(),
            Value<String?> grade = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PapersCompanion.insert(
            id: id,
            title: title,
            subject: subject,
            examDate: examDate,
            school: school,
            grade: grade,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$PapersTable, Paper>(table),
                    $$PapersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({pagesRefs = false, questionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pagesRefs) db.pages,
                if (questionsRefs) db.questions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pagesRefs)
                    await $_getPrefetchedData<Paper, $PapersTable, PageRecord>(
                        currentTable: table,
                        referencedTable:
                            $$PapersTableReferences._pagesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PapersTableReferences(db, table, p0).pagesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.paperId == item.id),
                        typedResults: items),
                  if (questionsRefs)
                    await $_getPrefetchedData<Paper, $PapersTable, Question>(
                        currentTable: table,
                        referencedTable:
                            $$PapersTableReferences._questionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PapersTableReferences(db, table, p0)
                                .questionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.paperId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PapersTableProcessedTableManager = ProcessedTableManager<
    _$MistakeDatabase,
    $PapersTable,
    Paper,
    $$PapersTableFilterComposer,
    $$PapersTableOrderingComposer,
    $$PapersTableAnnotationComposer,
    $$PapersTableCreateCompanionBuilder,
    $$PapersTableUpdateCompanionBuilder,
    (Paper, $$PapersTableReferences),
    Paper,
    PrefetchHooks Function({bool pagesRefs, bool questionsRefs})>;
typedef $$PagesTableCreateCompanionBuilder = PagesCompanion Function({
  Value<int> id,
  required int paperId,
  required String originalImagePath,
  required int pageIndex,
  Value<int?> width,
  Value<int?> height,
  Value<double?> qualityScore,
  Value<double?> blurScore,
  Value<double?> exposureScore,
  Value<bool> perspectiveWarning,
  Value<DateTime> createdAt,
});
typedef $$PagesTableUpdateCompanionBuilder = PagesCompanion Function({
  Value<int> id,
  Value<int> paperId,
  Value<String> originalImagePath,
  Value<int> pageIndex,
  Value<int?> width,
  Value<int?> height,
  Value<double?> qualityScore,
  Value<double?> blurScore,
  Value<double?> exposureScore,
  Value<bool> perspectiveWarning,
  Value<DateTime> createdAt,
});

final class $$PagesTableReferences
    extends BaseReferences<_$MistakeDatabase, $PagesTable, PageRecord> {
  $$PagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PapersTable _paperIdTable(_$MistakeDatabase db) =>
      db.papers.createAlias('pages__paper_id__papers__id');

  $$PapersTableProcessedTableManager get paperId {
    final $_column = $_itemColumn<int>('paper_id')!;

    final manager = $$PapersTableTableManager($_db, $_db.papers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paperIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$BlocksTable, List<Block>> _blocksRefsTable(
          _$MistakeDatabase db) =>
      MultiTypedResultKey.fromTable(db.blocks,
          aliasName: 'pages__id__blocks__page_id');

  $$BlocksTableProcessedTableManager get blocksRefs {
    final manager = $$BlocksTableTableManager($_db, $_db.blocks)
        .filter((f) => f.pageId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_blocksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PagesTableFilterComposer
    extends Composer<_$MistakeDatabase, $PagesTable> {
  $$PagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get originalImagePath => $composableBuilder(
      column: $table.originalImagePath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pageIndex => $composableBuilder(
      column: $table.pageIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get qualityScore => $composableBuilder(
      column: $table.qualityScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get blurScore => $composableBuilder(
      column: $table.blurScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get exposureScore => $composableBuilder(
      column: $table.exposureScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get perspectiveWarning => $composableBuilder(
      column: $table.perspectiveWarning,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PapersTableFilterComposer get paperId {
    final $$PapersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paperId,
        referencedTable: $db.papers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PapersTableFilterComposer(
              $db: $db,
              $table: $db.papers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> blocksRefs(
      Expression<bool> Function($$BlocksTableFilterComposer f) f) {
    final $$BlocksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.blocks,
        getReferencedColumn: (t) => t.pageId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlocksTableFilterComposer(
              $db: $db,
              $table: $db.blocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PagesTableOrderingComposer
    extends Composer<_$MistakeDatabase, $PagesTable> {
  $$PagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get originalImagePath => $composableBuilder(
      column: $table.originalImagePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pageIndex => $composableBuilder(
      column: $table.pageIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get qualityScore => $composableBuilder(
      column: $table.qualityScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get blurScore => $composableBuilder(
      column: $table.blurScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get exposureScore => $composableBuilder(
      column: $table.exposureScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get perspectiveWarning => $composableBuilder(
      column: $table.perspectiveWarning,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PapersTableOrderingComposer get paperId {
    final $$PapersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paperId,
        referencedTable: $db.papers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PapersTableOrderingComposer(
              $db: $db,
              $table: $db.papers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PagesTableAnnotationComposer
    extends Composer<_$MistakeDatabase, $PagesTable> {
  $$PagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get originalImagePath => $composableBuilder(
      column: $table.originalImagePath, builder: (column) => column);

  GeneratedColumn<int> get pageIndex =>
      $composableBuilder(column: $table.pageIndex, builder: (column) => column);

  GeneratedColumn<int> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<double> get qualityScore => $composableBuilder(
      column: $table.qualityScore, builder: (column) => column);

  GeneratedColumn<double> get blurScore =>
      $composableBuilder(column: $table.blurScore, builder: (column) => column);

  GeneratedColumn<double> get exposureScore => $composableBuilder(
      column: $table.exposureScore, builder: (column) => column);

  GeneratedColumn<bool> get perspectiveWarning => $composableBuilder(
      column: $table.perspectiveWarning, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PapersTableAnnotationComposer get paperId {
    final $$PapersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paperId,
        referencedTable: $db.papers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PapersTableAnnotationComposer(
              $db: $db,
              $table: $db.papers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> blocksRefs<T extends Object>(
      Expression<T> Function($$BlocksTableAnnotationComposer a) f) {
    final $$BlocksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.blocks,
        getReferencedColumn: (t) => t.pageId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlocksTableAnnotationComposer(
              $db: $db,
              $table: $db.blocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PagesTableTableManager extends RootTableManager<
    _$MistakeDatabase,
    $PagesTable,
    PageRecord,
    $$PagesTableFilterComposer,
    $$PagesTableOrderingComposer,
    $$PagesTableAnnotationComposer,
    $$PagesTableCreateCompanionBuilder,
    $$PagesTableUpdateCompanionBuilder,
    (PageRecord, $$PagesTableReferences),
    PageRecord,
    PrefetchHooks Function({bool paperId, bool blocksRefs})> {
  $$PagesTableTableManager(_$MistakeDatabase db, $PagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> paperId = const Value.absent(),
            Value<String> originalImagePath = const Value.absent(),
            Value<int> pageIndex = const Value.absent(),
            Value<int?> width = const Value.absent(),
            Value<int?> height = const Value.absent(),
            Value<double?> qualityScore = const Value.absent(),
            Value<double?> blurScore = const Value.absent(),
            Value<double?> exposureScore = const Value.absent(),
            Value<bool> perspectiveWarning = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              PagesCompanion(
            id: id,
            paperId: paperId,
            originalImagePath: originalImagePath,
            pageIndex: pageIndex,
            width: width,
            height: height,
            qualityScore: qualityScore,
            blurScore: blurScore,
            exposureScore: exposureScore,
            perspectiveWarning: perspectiveWarning,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int paperId,
            required String originalImagePath,
            required int pageIndex,
            Value<int?> width = const Value.absent(),
            Value<int?> height = const Value.absent(),
            Value<double?> qualityScore = const Value.absent(),
            Value<double?> blurScore = const Value.absent(),
            Value<double?> exposureScore = const Value.absent(),
            Value<bool> perspectiveWarning = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              PagesCompanion.insert(
            id: id,
            paperId: paperId,
            originalImagePath: originalImagePath,
            pageIndex: pageIndex,
            width: width,
            height: height,
            qualityScore: qualityScore,
            blurScore: blurScore,
            exposureScore: exposureScore,
            perspectiveWarning: perspectiveWarning,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$PagesTable, PageRecord>(table),
                    $$PagesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({paperId = false, blocksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (blocksRefs) db.blocks],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (paperId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.paperId,
                    referencedTable: $$PagesTableReferences._paperIdTable(db),
                    referencedColumn:
                        $$PagesTableReferences._paperIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (blocksRefs)
                    await $_getPrefetchedData<PageRecord, $PagesTable, Block>(
                        currentTable: table,
                        referencedTable:
                            $$PagesTableReferences._blocksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PagesTableReferences(db, table, p0).blocksRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.pageId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PagesTableProcessedTableManager = ProcessedTableManager<
    _$MistakeDatabase,
    $PagesTable,
    PageRecord,
    $$PagesTableFilterComposer,
    $$PagesTableOrderingComposer,
    $$PagesTableAnnotationComposer,
    $$PagesTableCreateCompanionBuilder,
    $$PagesTableUpdateCompanionBuilder,
    (PageRecord, $$PagesTableReferences),
    PageRecord,
    PrefetchHooks Function({bool paperId, bool blocksRefs})>;
typedef $$QuestionsTableCreateCompanionBuilder = QuestionsCompanion Function({
  Value<int> id,
  required int paperId,
  Value<String?> originalQuestionNumber,
  Value<String?> title,
  Value<String?> knowledgePoint,
  Value<String?> questionType,
  Value<String?> difficulty,
  Value<String> tags,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$QuestionsTableUpdateCompanionBuilder = QuestionsCompanion Function({
  Value<int> id,
  Value<int> paperId,
  Value<String?> originalQuestionNumber,
  Value<String?> title,
  Value<String?> knowledgePoint,
  Value<String?> questionType,
  Value<String?> difficulty,
  Value<String> tags,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$QuestionsTableReferences
    extends BaseReferences<_$MistakeDatabase, $QuestionsTable, Question> {
  $$QuestionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PapersTable _paperIdTable(_$MistakeDatabase db) =>
      db.papers.createAlias('questions__paper_id__papers__id');

  $$PapersTableProcessedTableManager get paperId {
    final $_column = $_itemColumn<int>('paper_id')!;

    final manager = $$PapersTableTableManager($_db, $_db.papers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paperIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$BlocksTable, List<Block>> _blocksRefsTable(
          _$MistakeDatabase db) =>
      MultiTypedResultKey.fromTable(db.blocks,
          aliasName: 'questions__id__blocks__question_id');

  $$BlocksTableProcessedTableManager get blocksRefs {
    final manager = $$BlocksTableTableManager($_db, $_db.blocks)
        .filter((f) => f.questionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_blocksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AnswerResourcesTable, List<AnswerResource>>
      _answerResourcesRefsTable(_$MistakeDatabase db) =>
          MultiTypedResultKey.fromTable(db.answerResources,
              aliasName: 'questions__id__answer_resources__question_id');

  $$AnswerResourcesTableProcessedTableManager get answerResourcesRefs {
    final manager =
        $$AnswerResourcesTableTableManager($_db, $_db.answerResources)
            .filter((f) => f.questionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_answerResourcesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AiUnderstandingsTable, List<AiUnderstanding>>
      _aiUnderstandingsRefsTable(_$MistakeDatabase db) =>
          MultiTypedResultKey.fromTable(db.aiUnderstandings,
              aliasName: 'questions__id__ai_understandings__question_id');

  $$AiUnderstandingsTableProcessedTableManager get aiUnderstandingsRefs {
    final manager =
        $$AiUnderstandingsTableTableManager($_db, $_db.aiUnderstandings)
            .filter((f) => f.questionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_aiUnderstandingsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AiMistakesTable, List<AiMistake>>
      _aiMistakesRefsTable(_$MistakeDatabase db) =>
          MultiTypedResultKey.fromTable(db.aiMistakes,
              aliasName: 'questions__id__ai_mistakes__question_id');

  $$AiMistakesTableProcessedTableManager get aiMistakesRefs {
    final manager = $$AiMistakesTableTableManager($_db, $_db.aiMistakes)
        .filter((f) => f.questionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_aiMistakesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GeneratedExercisesTable, List<GeneratedExercise>>
      _generatedExercisesRefsTable(_$MistakeDatabase db) =>
          MultiTypedResultKey.fromTable(db.generatedExercises,
              aliasName:
                  'questions__id__generated_exercises__source_question_id');

  $$GeneratedExercisesTableProcessedTableManager get generatedExercisesRefs {
    final manager = $$GeneratedExercisesTableTableManager(
            $_db, $_db.generatedExercises)
        .filter(
            (f) => f.sourceQuestionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_generatedExercisesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$QuestionsTableFilterComposer
    extends Composer<_$MistakeDatabase, $QuestionsTable> {
  $$QuestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get originalQuestionNumber => $composableBuilder(
      column: $table.originalQuestionNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get knowledgePoint => $composableBuilder(
      column: $table.knowledgePoint,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionType => $composableBuilder(
      column: $table.questionType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$PapersTableFilterComposer get paperId {
    final $$PapersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paperId,
        referencedTable: $db.papers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PapersTableFilterComposer(
              $db: $db,
              $table: $db.papers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> blocksRefs(
      Expression<bool> Function($$BlocksTableFilterComposer f) f) {
    final $$BlocksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.blocks,
        getReferencedColumn: (t) => t.questionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlocksTableFilterComposer(
              $db: $db,
              $table: $db.blocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> answerResourcesRefs(
      Expression<bool> Function($$AnswerResourcesTableFilterComposer f) f) {
    final $$AnswerResourcesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.answerResources,
        getReferencedColumn: (t) => t.questionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnswerResourcesTableFilterComposer(
              $db: $db,
              $table: $db.answerResources,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> aiUnderstandingsRefs(
      Expression<bool> Function($$AiUnderstandingsTableFilterComposer f) f) {
    final $$AiUnderstandingsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aiUnderstandings,
        getReferencedColumn: (t) => t.questionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AiUnderstandingsTableFilterComposer(
              $db: $db,
              $table: $db.aiUnderstandings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> aiMistakesRefs(
      Expression<bool> Function($$AiMistakesTableFilterComposer f) f) {
    final $$AiMistakesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aiMistakes,
        getReferencedColumn: (t) => t.questionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AiMistakesTableFilterComposer(
              $db: $db,
              $table: $db.aiMistakes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> generatedExercisesRefs(
      Expression<bool> Function($$GeneratedExercisesTableFilterComposer f) f) {
    final $$GeneratedExercisesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.generatedExercises,
        getReferencedColumn: (t) => t.sourceQuestionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GeneratedExercisesTableFilterComposer(
              $db: $db,
              $table: $db.generatedExercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$QuestionsTableOrderingComposer
    extends Composer<_$MistakeDatabase, $QuestionsTable> {
  $$QuestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get originalQuestionNumber => $composableBuilder(
      column: $table.originalQuestionNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get knowledgePoint => $composableBuilder(
      column: $table.knowledgePoint,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionType => $composableBuilder(
      column: $table.questionType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$PapersTableOrderingComposer get paperId {
    final $$PapersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paperId,
        referencedTable: $db.papers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PapersTableOrderingComposer(
              $db: $db,
              $table: $db.papers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuestionsTableAnnotationComposer
    extends Composer<_$MistakeDatabase, $QuestionsTable> {
  $$QuestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get originalQuestionNumber => $composableBuilder(
      column: $table.originalQuestionNumber, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get knowledgePoint => $composableBuilder(
      column: $table.knowledgePoint, builder: (column) => column);

  GeneratedColumn<String> get questionType => $composableBuilder(
      column: $table.questionType, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PapersTableAnnotationComposer get paperId {
    final $$PapersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paperId,
        referencedTable: $db.papers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PapersTableAnnotationComposer(
              $db: $db,
              $table: $db.papers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> blocksRefs<T extends Object>(
      Expression<T> Function($$BlocksTableAnnotationComposer a) f) {
    final $$BlocksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.blocks,
        getReferencedColumn: (t) => t.questionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlocksTableAnnotationComposer(
              $db: $db,
              $table: $db.blocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> answerResourcesRefs<T extends Object>(
      Expression<T> Function($$AnswerResourcesTableAnnotationComposer a) f) {
    final $$AnswerResourcesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.answerResources,
        getReferencedColumn: (t) => t.questionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnswerResourcesTableAnnotationComposer(
              $db: $db,
              $table: $db.answerResources,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> aiUnderstandingsRefs<T extends Object>(
      Expression<T> Function($$AiUnderstandingsTableAnnotationComposer a) f) {
    final $$AiUnderstandingsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aiUnderstandings,
        getReferencedColumn: (t) => t.questionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AiUnderstandingsTableAnnotationComposer(
              $db: $db,
              $table: $db.aiUnderstandings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> aiMistakesRefs<T extends Object>(
      Expression<T> Function($$AiMistakesTableAnnotationComposer a) f) {
    final $$AiMistakesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aiMistakes,
        getReferencedColumn: (t) => t.questionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AiMistakesTableAnnotationComposer(
              $db: $db,
              $table: $db.aiMistakes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> generatedExercisesRefs<T extends Object>(
      Expression<T> Function($$GeneratedExercisesTableAnnotationComposer a) f) {
    final $$GeneratedExercisesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.generatedExercises,
            getReferencedColumn: (t) => t.sourceQuestionId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$GeneratedExercisesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.generatedExercises,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$QuestionsTableTableManager extends RootTableManager<
    _$MistakeDatabase,
    $QuestionsTable,
    Question,
    $$QuestionsTableFilterComposer,
    $$QuestionsTableOrderingComposer,
    $$QuestionsTableAnnotationComposer,
    $$QuestionsTableCreateCompanionBuilder,
    $$QuestionsTableUpdateCompanionBuilder,
    (Question, $$QuestionsTableReferences),
    Question,
    PrefetchHooks Function(
        {bool paperId,
        bool blocksRefs,
        bool answerResourcesRefs,
        bool aiUnderstandingsRefs,
        bool aiMistakesRefs,
        bool generatedExercisesRefs})> {
  $$QuestionsTableTableManager(_$MistakeDatabase db, $QuestionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> paperId = const Value.absent(),
            Value<String?> originalQuestionNumber = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> knowledgePoint = const Value.absent(),
            Value<String?> questionType = const Value.absent(),
            Value<String?> difficulty = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              QuestionsCompanion(
            id: id,
            paperId: paperId,
            originalQuestionNumber: originalQuestionNumber,
            title: title,
            knowledgePoint: knowledgePoint,
            questionType: questionType,
            difficulty: difficulty,
            tags: tags,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int paperId,
            Value<String?> originalQuestionNumber = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> knowledgePoint = const Value.absent(),
            Value<String?> questionType = const Value.absent(),
            Value<String?> difficulty = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              QuestionsCompanion.insert(
            id: id,
            paperId: paperId,
            originalQuestionNumber: originalQuestionNumber,
            title: title,
            knowledgePoint: knowledgePoint,
            questionType: questionType,
            difficulty: difficulty,
            tags: tags,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$QuestionsTable, Question>(table),
                    $$QuestionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {paperId = false,
              blocksRefs = false,
              answerResourcesRefs = false,
              aiUnderstandingsRefs = false,
              aiMistakesRefs = false,
              generatedExercisesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (blocksRefs) db.blocks,
                if (answerResourcesRefs) db.answerResources,
                if (aiUnderstandingsRefs) db.aiUnderstandings,
                if (aiMistakesRefs) db.aiMistakes,
                if (generatedExercisesRefs) db.generatedExercises
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (paperId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.paperId,
                    referencedTable:
                        $$QuestionsTableReferences._paperIdTable(db),
                    referencedColumn:
                        $$QuestionsTableReferences._paperIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (blocksRefs)
                    await $_getPrefetchedData<Question, $QuestionsTable, Block>(
                        currentTable: table,
                        referencedTable:
                            $$QuestionsTableReferences._blocksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$QuestionsTableReferences(db, table, p0)
                                .blocksRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.questionId == item.id),
                        typedResults: items),
                  if (answerResourcesRefs)
                    await $_getPrefetchedData<Question, $QuestionsTable,
                            AnswerResource>(
                        currentTable: table,
                        referencedTable: $$QuestionsTableReferences
                            ._answerResourcesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$QuestionsTableReferences(db, table, p0)
                                .answerResourcesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.questionId == item.id),
                        typedResults: items),
                  if (aiUnderstandingsRefs)
                    await $_getPrefetchedData<Question, $QuestionsTable,
                            AiUnderstanding>(
                        currentTable: table,
                        referencedTable: $$QuestionsTableReferences
                            ._aiUnderstandingsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$QuestionsTableReferences(db, table, p0)
                                .aiUnderstandingsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.questionId == item.id),
                        typedResults: items),
                  if (aiMistakesRefs)
                    await $_getPrefetchedData<Question, $QuestionsTable,
                            AiMistake>(
                        currentTable: table,
                        referencedTable:
                            $$QuestionsTableReferences._aiMistakesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$QuestionsTableReferences(db, table, p0)
                                .aiMistakesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.questionId == item.id),
                        typedResults: items),
                  if (generatedExercisesRefs)
                    await $_getPrefetchedData<Question, $QuestionsTable,
                            GeneratedExercise>(
                        currentTable: table,
                        referencedTable: $$QuestionsTableReferences
                            ._generatedExercisesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$QuestionsTableReferences(db, table, p0)
                                .generatedExercisesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sourceQuestionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$QuestionsTableProcessedTableManager = ProcessedTableManager<
    _$MistakeDatabase,
    $QuestionsTable,
    Question,
    $$QuestionsTableFilterComposer,
    $$QuestionsTableOrderingComposer,
    $$QuestionsTableAnnotationComposer,
    $$QuestionsTableCreateCompanionBuilder,
    $$QuestionsTableUpdateCompanionBuilder,
    (Question, $$QuestionsTableReferences),
    Question,
    PrefetchHooks Function(
        {bool paperId,
        bool blocksRefs,
        bool answerResourcesRefs,
        bool aiUnderstandingsRefs,
        bool aiMistakesRefs,
        bool generatedExercisesRefs})>;
typedef $$BlocksTableCreateCompanionBuilder = BlocksCompanion Function({
  Value<int> id,
  required int questionId,
  required int pageId,
  required String blockType,
  required double x,
  required double y,
  required double width,
  required double height,
  Value<int> sortOrder,
  Value<String?> processedImagePath,
  Value<String> processingStatus,
  Value<double?> printScaleOverride,
  Value<DateTime> createdAt,
});
typedef $$BlocksTableUpdateCompanionBuilder = BlocksCompanion Function({
  Value<int> id,
  Value<int> questionId,
  Value<int> pageId,
  Value<String> blockType,
  Value<double> x,
  Value<double> y,
  Value<double> width,
  Value<double> height,
  Value<int> sortOrder,
  Value<String?> processedImagePath,
  Value<String> processingStatus,
  Value<double?> printScaleOverride,
  Value<DateTime> createdAt,
});

final class $$BlocksTableReferences
    extends BaseReferences<_$MistakeDatabase, $BlocksTable, Block> {
  $$BlocksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuestionsTable _questionIdTable(_$MistakeDatabase db) =>
      db.questions.createAlias('blocks__question_id__questions__id');

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<int>('question_id')!;

    final manager = $$QuestionsTableTableManager($_db, $_db.questions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PagesTable _pageIdTable(_$MistakeDatabase db) =>
      db.pages.createAlias('blocks__page_id__pages__id');

  $$PagesTableProcessedTableManager get pageId {
    final $_column = $_itemColumn<int>('page_id')!;

    final manager = $$PagesTableTableManager($_db, $_db.pages)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$BlockVersionsTable, List<BlockVersion>>
      _blockVersionsRefsTable(_$MistakeDatabase db) =>
          MultiTypedResultKey.fromTable(db.blockVersions,
              aliasName: 'blocks__id__block_versions__block_id');

  $$BlockVersionsTableProcessedTableManager get blockVersionsRefs {
    final manager = $$BlockVersionsTableTableManager($_db, $_db.blockVersions)
        .filter((f) => f.blockId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_blockVersionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BlocksTableFilterComposer
    extends Composer<_$MistakeDatabase, $BlocksTable> {
  $$BlocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get blockType => $composableBuilder(
      column: $table.blockType, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get processedImagePath => $composableBuilder(
      column: $table.processedImagePath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get processingStatus => $composableBuilder(
      column: $table.processingStatus,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get printScaleOverride => $composableBuilder(
      column: $table.printScaleOverride,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableFilterComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PagesTableFilterComposer get pageId {
    final $$PagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pageId,
        referencedTable: $db.pages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PagesTableFilterComposer(
              $db: $db,
              $table: $db.pages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> blockVersionsRefs(
      Expression<bool> Function($$BlockVersionsTableFilterComposer f) f) {
    final $$BlockVersionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.blockVersions,
        getReferencedColumn: (t) => t.blockId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlockVersionsTableFilterComposer(
              $db: $db,
              $table: $db.blockVersions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BlocksTableOrderingComposer
    extends Composer<_$MistakeDatabase, $BlocksTable> {
  $$BlocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get blockType => $composableBuilder(
      column: $table.blockType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get processedImagePath => $composableBuilder(
      column: $table.processedImagePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get processingStatus => $composableBuilder(
      column: $table.processingStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get printScaleOverride => $composableBuilder(
      column: $table.printScaleOverride,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableOrderingComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PagesTableOrderingComposer get pageId {
    final $$PagesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pageId,
        referencedTable: $db.pages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PagesTableOrderingComposer(
              $db: $db,
              $table: $db.pages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BlocksTableAnnotationComposer
    extends Composer<_$MistakeDatabase, $BlocksTable> {
  $$BlocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get blockType =>
      $composableBuilder(column: $table.blockType, builder: (column) => column);

  GeneratedColumn<double> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<double> get y =>
      $composableBuilder(column: $table.y, builder: (column) => column);

  GeneratedColumn<double> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get processedImagePath => $composableBuilder(
      column: $table.processedImagePath, builder: (column) => column);

  GeneratedColumn<String> get processingStatus => $composableBuilder(
      column: $table.processingStatus, builder: (column) => column);

  GeneratedColumn<double> get printScaleOverride => $composableBuilder(
      column: $table.printScaleOverride, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableAnnotationComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PagesTableAnnotationComposer get pageId {
    final $$PagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pageId,
        referencedTable: $db.pages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PagesTableAnnotationComposer(
              $db: $db,
              $table: $db.pages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> blockVersionsRefs<T extends Object>(
      Expression<T> Function($$BlockVersionsTableAnnotationComposer a) f) {
    final $$BlockVersionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.blockVersions,
        getReferencedColumn: (t) => t.blockId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlockVersionsTableAnnotationComposer(
              $db: $db,
              $table: $db.blockVersions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BlocksTableTableManager extends RootTableManager<
    _$MistakeDatabase,
    $BlocksTable,
    Block,
    $$BlocksTableFilterComposer,
    $$BlocksTableOrderingComposer,
    $$BlocksTableAnnotationComposer,
    $$BlocksTableCreateCompanionBuilder,
    $$BlocksTableUpdateCompanionBuilder,
    (Block, $$BlocksTableReferences),
    Block,
    PrefetchHooks Function(
        {bool questionId, bool pageId, bool blockVersionsRefs})> {
  $$BlocksTableTableManager(_$MistakeDatabase db, $BlocksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BlocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BlocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BlocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> questionId = const Value.absent(),
            Value<int> pageId = const Value.absent(),
            Value<String> blockType = const Value.absent(),
            Value<double> x = const Value.absent(),
            Value<double> y = const Value.absent(),
            Value<double> width = const Value.absent(),
            Value<double> height = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<String?> processedImagePath = const Value.absent(),
            Value<String> processingStatus = const Value.absent(),
            Value<double?> printScaleOverride = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BlocksCompanion(
            id: id,
            questionId: questionId,
            pageId: pageId,
            blockType: blockType,
            x: x,
            y: y,
            width: width,
            height: height,
            sortOrder: sortOrder,
            processedImagePath: processedImagePath,
            processingStatus: processingStatus,
            printScaleOverride: printScaleOverride,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int questionId,
            required int pageId,
            required String blockType,
            required double x,
            required double y,
            required double width,
            required double height,
            Value<int> sortOrder = const Value.absent(),
            Value<String?> processedImagePath = const Value.absent(),
            Value<String> processingStatus = const Value.absent(),
            Value<double?> printScaleOverride = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BlocksCompanion.insert(
            id: id,
            questionId: questionId,
            pageId: pageId,
            blockType: blockType,
            x: x,
            y: y,
            width: width,
            height: height,
            sortOrder: sortOrder,
            processedImagePath: processedImagePath,
            processingStatus: processingStatus,
            printScaleOverride: printScaleOverride,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$BlocksTable, Block>(table),
                    $$BlocksTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {questionId = false, pageId = false, blockVersionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (blockVersionsRefs) db.blockVersions
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (questionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.questionId,
                    referencedTable:
                        $$BlocksTableReferences._questionIdTable(db),
                    referencedColumn:
                        $$BlocksTableReferences._questionIdTable(db).id,
                  ) as T;
                }
                if (pageId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.pageId,
                    referencedTable: $$BlocksTableReferences._pageIdTable(db),
                    referencedColumn:
                        $$BlocksTableReferences._pageIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (blockVersionsRefs)
                    await $_getPrefetchedData<Block, $BlocksTable,
                            BlockVersion>(
                        currentTable: table,
                        referencedTable:
                            $$BlocksTableReferences._blockVersionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BlocksTableReferences(db, table, p0)
                                .blockVersionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.blockId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BlocksTableProcessedTableManager = ProcessedTableManager<
    _$MistakeDatabase,
    $BlocksTable,
    Block,
    $$BlocksTableFilterComposer,
    $$BlocksTableOrderingComposer,
    $$BlocksTableAnnotationComposer,
    $$BlocksTableCreateCompanionBuilder,
    $$BlocksTableUpdateCompanionBuilder,
    (Block, $$BlocksTableReferences),
    Block,
    PrefetchHooks Function(
        {bool questionId, bool pageId, bool blockVersionsRefs})>;
typedef $$AnswerResourcesTableCreateCompanionBuilder = AnswerResourcesCompanion
    Function({
  Value<int> id,
  required int questionId,
  Value<String> type,
  Value<String> format,
  Value<String> sourceType,
  Value<String?> sourceDescription,
  Value<String?> contentText,
  Value<String?> imagePath,
  Value<bool> isVerified,
  Value<DateTime> createdAt,
});
typedef $$AnswerResourcesTableUpdateCompanionBuilder = AnswerResourcesCompanion
    Function({
  Value<int> id,
  Value<int> questionId,
  Value<String> type,
  Value<String> format,
  Value<String> sourceType,
  Value<String?> sourceDescription,
  Value<String?> contentText,
  Value<String?> imagePath,
  Value<bool> isVerified,
  Value<DateTime> createdAt,
});

final class $$AnswerResourcesTableReferences extends BaseReferences<
    _$MistakeDatabase, $AnswerResourcesTable, AnswerResource> {
  $$AnswerResourcesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $QuestionsTable _questionIdTable(_$MistakeDatabase db) =>
      db.questions.createAlias('answer_resources__question_id__questions__id');

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<int>('question_id')!;

    final manager = $$QuestionsTableTableManager($_db, $_db.questions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AnswerResourcesTableFilterComposer
    extends Composer<_$MistakeDatabase, $AnswerResourcesTable> {
  $$AnswerResourcesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get format => $composableBuilder(
      column: $table.format, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceDescription => $composableBuilder(
      column: $table.sourceDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentText => $composableBuilder(
      column: $table.contentText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isVerified => $composableBuilder(
      column: $table.isVerified, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableFilterComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AnswerResourcesTableOrderingComposer
    extends Composer<_$MistakeDatabase, $AnswerResourcesTable> {
  $$AnswerResourcesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get format => $composableBuilder(
      column: $table.format, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceDescription => $composableBuilder(
      column: $table.sourceDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentText => $composableBuilder(
      column: $table.contentText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isVerified => $composableBuilder(
      column: $table.isVerified, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableOrderingComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AnswerResourcesTableAnnotationComposer
    extends Composer<_$MistakeDatabase, $AnswerResourcesTable> {
  $$AnswerResourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => column);

  GeneratedColumn<String> get sourceDescription => $composableBuilder(
      column: $table.sourceDescription, builder: (column) => column);

  GeneratedColumn<String> get contentText => $composableBuilder(
      column: $table.contentText, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<bool> get isVerified => $composableBuilder(
      column: $table.isVerified, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableAnnotationComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AnswerResourcesTableTableManager extends RootTableManager<
    _$MistakeDatabase,
    $AnswerResourcesTable,
    AnswerResource,
    $$AnswerResourcesTableFilterComposer,
    $$AnswerResourcesTableOrderingComposer,
    $$AnswerResourcesTableAnnotationComposer,
    $$AnswerResourcesTableCreateCompanionBuilder,
    $$AnswerResourcesTableUpdateCompanionBuilder,
    (AnswerResource, $$AnswerResourcesTableReferences),
    AnswerResource,
    PrefetchHooks Function({bool questionId})> {
  $$AnswerResourcesTableTableManager(
      _$MistakeDatabase db, $AnswerResourcesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnswerResourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnswerResourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnswerResourcesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> questionId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> format = const Value.absent(),
            Value<String> sourceType = const Value.absent(),
            Value<String?> sourceDescription = const Value.absent(),
            Value<String?> contentText = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<bool> isVerified = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              AnswerResourcesCompanion(
            id: id,
            questionId: questionId,
            type: type,
            format: format,
            sourceType: sourceType,
            sourceDescription: sourceDescription,
            contentText: contentText,
            imagePath: imagePath,
            isVerified: isVerified,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int questionId,
            Value<String> type = const Value.absent(),
            Value<String> format = const Value.absent(),
            Value<String> sourceType = const Value.absent(),
            Value<String?> sourceDescription = const Value.absent(),
            Value<String?> contentText = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<bool> isVerified = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              AnswerResourcesCompanion.insert(
            id: id,
            questionId: questionId,
            type: type,
            format: format,
            sourceType: sourceType,
            sourceDescription: sourceDescription,
            contentText: contentText,
            imagePath: imagePath,
            isVerified: isVerified,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AnswerResourcesTable, AnswerResource>(table),
                    $$AnswerResourcesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({questionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (questionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.questionId,
                    referencedTable:
                        $$AnswerResourcesTableReferences._questionIdTable(db),
                    referencedColumn: $$AnswerResourcesTableReferences
                        ._questionIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AnswerResourcesTableProcessedTableManager = ProcessedTableManager<
    _$MistakeDatabase,
    $AnswerResourcesTable,
    AnswerResource,
    $$AnswerResourcesTableFilterComposer,
    $$AnswerResourcesTableOrderingComposer,
    $$AnswerResourcesTableAnnotationComposer,
    $$AnswerResourcesTableCreateCompanionBuilder,
    $$AnswerResourcesTableUpdateCompanionBuilder,
    (AnswerResource, $$AnswerResourcesTableReferences),
    AnswerResource,
    PrefetchHooks Function({bool questionId})>;
typedef $$BlockVersionsTableCreateCompanionBuilder = BlockVersionsCompanion
    Function({
  Value<int> id,
  required int blockId,
  required String method,
  Value<String?> sourceImagePath,
  Value<String?> processedImagePath,
  Value<String?> maskPath,
  Value<String?> model,
  Value<bool> verified,
  Value<bool> useForPrint,
  Value<DateTime> createdAt,
});
typedef $$BlockVersionsTableUpdateCompanionBuilder = BlockVersionsCompanion
    Function({
  Value<int> id,
  Value<int> blockId,
  Value<String> method,
  Value<String?> sourceImagePath,
  Value<String?> processedImagePath,
  Value<String?> maskPath,
  Value<String?> model,
  Value<bool> verified,
  Value<bool> useForPrint,
  Value<DateTime> createdAt,
});

final class $$BlockVersionsTableReferences extends BaseReferences<
    _$MistakeDatabase, $BlockVersionsTable, BlockVersion> {
  $$BlockVersionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $BlocksTable _blockIdTable(_$MistakeDatabase db) =>
      db.blocks.createAlias('block_versions__block_id__blocks__id');

  $$BlocksTableProcessedTableManager get blockId {
    final $_column = $_itemColumn<int>('block_id')!;

    final manager = $$BlocksTableTableManager($_db, $_db.blocks)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_blockIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BlockVersionsTableFilterComposer
    extends Composer<_$MistakeDatabase, $BlockVersionsTable> {
  $$BlockVersionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceImagePath => $composableBuilder(
      column: $table.sourceImagePath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get processedImagePath => $composableBuilder(
      column: $table.processedImagePath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get maskPath => $composableBuilder(
      column: $table.maskPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get verified => $composableBuilder(
      column: $table.verified, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get useForPrint => $composableBuilder(
      column: $table.useForPrint, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$BlocksTableFilterComposer get blockId {
    final $$BlocksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.blockId,
        referencedTable: $db.blocks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlocksTableFilterComposer(
              $db: $db,
              $table: $db.blocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BlockVersionsTableOrderingComposer
    extends Composer<_$MistakeDatabase, $BlockVersionsTable> {
  $$BlockVersionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceImagePath => $composableBuilder(
      column: $table.sourceImagePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get processedImagePath => $composableBuilder(
      column: $table.processedImagePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get maskPath => $composableBuilder(
      column: $table.maskPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get verified => $composableBuilder(
      column: $table.verified, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get useForPrint => $composableBuilder(
      column: $table.useForPrint, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$BlocksTableOrderingComposer get blockId {
    final $$BlocksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.blockId,
        referencedTable: $db.blocks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlocksTableOrderingComposer(
              $db: $db,
              $table: $db.blocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BlockVersionsTableAnnotationComposer
    extends Composer<_$MistakeDatabase, $BlockVersionsTable> {
  $$BlockVersionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get sourceImagePath => $composableBuilder(
      column: $table.sourceImagePath, builder: (column) => column);

  GeneratedColumn<String> get processedImagePath => $composableBuilder(
      column: $table.processedImagePath, builder: (column) => column);

  GeneratedColumn<String> get maskPath =>
      $composableBuilder(column: $table.maskPath, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<bool> get verified =>
      $composableBuilder(column: $table.verified, builder: (column) => column);

  GeneratedColumn<bool> get useForPrint => $composableBuilder(
      column: $table.useForPrint, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BlocksTableAnnotationComposer get blockId {
    final $$BlocksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.blockId,
        referencedTable: $db.blocks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlocksTableAnnotationComposer(
              $db: $db,
              $table: $db.blocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BlockVersionsTableTableManager extends RootTableManager<
    _$MistakeDatabase,
    $BlockVersionsTable,
    BlockVersion,
    $$BlockVersionsTableFilterComposer,
    $$BlockVersionsTableOrderingComposer,
    $$BlockVersionsTableAnnotationComposer,
    $$BlockVersionsTableCreateCompanionBuilder,
    $$BlockVersionsTableUpdateCompanionBuilder,
    (BlockVersion, $$BlockVersionsTableReferences),
    BlockVersion,
    PrefetchHooks Function({bool blockId})> {
  $$BlockVersionsTableTableManager(
      _$MistakeDatabase db, $BlockVersionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BlockVersionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BlockVersionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BlockVersionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> blockId = const Value.absent(),
            Value<String> method = const Value.absent(),
            Value<String?> sourceImagePath = const Value.absent(),
            Value<String?> processedImagePath = const Value.absent(),
            Value<String?> maskPath = const Value.absent(),
            Value<String?> model = const Value.absent(),
            Value<bool> verified = const Value.absent(),
            Value<bool> useForPrint = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BlockVersionsCompanion(
            id: id,
            blockId: blockId,
            method: method,
            sourceImagePath: sourceImagePath,
            processedImagePath: processedImagePath,
            maskPath: maskPath,
            model: model,
            verified: verified,
            useForPrint: useForPrint,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int blockId,
            required String method,
            Value<String?> sourceImagePath = const Value.absent(),
            Value<String?> processedImagePath = const Value.absent(),
            Value<String?> maskPath = const Value.absent(),
            Value<String?> model = const Value.absent(),
            Value<bool> verified = const Value.absent(),
            Value<bool> useForPrint = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BlockVersionsCompanion.insert(
            id: id,
            blockId: blockId,
            method: method,
            sourceImagePath: sourceImagePath,
            processedImagePath: processedImagePath,
            maskPath: maskPath,
            model: model,
            verified: verified,
            useForPrint: useForPrint,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$BlockVersionsTable, BlockVersion>(table),
                    $$BlockVersionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({blockId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (blockId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.blockId,
                    referencedTable:
                        $$BlockVersionsTableReferences._blockIdTable(db),
                    referencedColumn:
                        $$BlockVersionsTableReferences._blockIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BlockVersionsTableProcessedTableManager = ProcessedTableManager<
    _$MistakeDatabase,
    $BlockVersionsTable,
    BlockVersion,
    $$BlockVersionsTableFilterComposer,
    $$BlockVersionsTableOrderingComposer,
    $$BlockVersionsTableAnnotationComposer,
    $$BlockVersionsTableCreateCompanionBuilder,
    $$BlockVersionsTableUpdateCompanionBuilder,
    (BlockVersion, $$BlockVersionsTableReferences),
    BlockVersion,
    PrefetchHooks Function({bool blockId})>;
typedef $$AiUnderstandingsTableCreateCompanionBuilder
    = AiUnderstandingsCompanion Function({
  Value<int> id,
  required int questionId,
  Value<String> status,
  Value<String?> questionType,
  Value<String?> knowledgePoint,
  Value<String?> difficulty,
  Value<String?> summary,
  Value<String?> answer,
  Value<String?> solution,
  Value<String?> approach,
  Value<String?> rawJson,
  Value<String?> model,
  Value<String?> error,
  Value<DateTime> updatedAt,
});
typedef $$AiUnderstandingsTableUpdateCompanionBuilder
    = AiUnderstandingsCompanion Function({
  Value<int> id,
  Value<int> questionId,
  Value<String> status,
  Value<String?> questionType,
  Value<String?> knowledgePoint,
  Value<String?> difficulty,
  Value<String?> summary,
  Value<String?> answer,
  Value<String?> solution,
  Value<String?> approach,
  Value<String?> rawJson,
  Value<String?> model,
  Value<String?> error,
  Value<DateTime> updatedAt,
});

final class $$AiUnderstandingsTableReferences extends BaseReferences<
    _$MistakeDatabase, $AiUnderstandingsTable, AiUnderstanding> {
  $$AiUnderstandingsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $QuestionsTable _questionIdTable(_$MistakeDatabase db) =>
      db.questions.createAlias('ai_understandings__question_id__questions__id');

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<int>('question_id')!;

    final manager = $$QuestionsTableTableManager($_db, $_db.questions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AiUnderstandingsTableFilterComposer
    extends Composer<_$MistakeDatabase, $AiUnderstandingsTable> {
  $$AiUnderstandingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionType => $composableBuilder(
      column: $table.questionType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get knowledgePoint => $composableBuilder(
      column: $table.knowledgePoint,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get answer => $composableBuilder(
      column: $table.answer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get solution => $composableBuilder(
      column: $table.solution, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get approach => $composableBuilder(
      column: $table.approach, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rawJson => $composableBuilder(
      column: $table.rawJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get error => $composableBuilder(
      column: $table.error, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableFilterComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AiUnderstandingsTableOrderingComposer
    extends Composer<_$MistakeDatabase, $AiUnderstandingsTable> {
  $$AiUnderstandingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionType => $composableBuilder(
      column: $table.questionType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get knowledgePoint => $composableBuilder(
      column: $table.knowledgePoint,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get answer => $composableBuilder(
      column: $table.answer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get solution => $composableBuilder(
      column: $table.solution, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get approach => $composableBuilder(
      column: $table.approach, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rawJson => $composableBuilder(
      column: $table.rawJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get error => $composableBuilder(
      column: $table.error, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableOrderingComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AiUnderstandingsTableAnnotationComposer
    extends Composer<_$MistakeDatabase, $AiUnderstandingsTable> {
  $$AiUnderstandingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get questionType => $composableBuilder(
      column: $table.questionType, builder: (column) => column);

  GeneratedColumn<String> get knowledgePoint => $composableBuilder(
      column: $table.knowledgePoint, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get answer =>
      $composableBuilder(column: $table.answer, builder: (column) => column);

  GeneratedColumn<String> get solution =>
      $composableBuilder(column: $table.solution, builder: (column) => column);

  GeneratedColumn<String> get approach =>
      $composableBuilder(column: $table.approach, builder: (column) => column);

  GeneratedColumn<String> get rawJson =>
      $composableBuilder(column: $table.rawJson, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get error =>
      $composableBuilder(column: $table.error, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableAnnotationComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AiUnderstandingsTableTableManager extends RootTableManager<
    _$MistakeDatabase,
    $AiUnderstandingsTable,
    AiUnderstanding,
    $$AiUnderstandingsTableFilterComposer,
    $$AiUnderstandingsTableOrderingComposer,
    $$AiUnderstandingsTableAnnotationComposer,
    $$AiUnderstandingsTableCreateCompanionBuilder,
    $$AiUnderstandingsTableUpdateCompanionBuilder,
    (AiUnderstanding, $$AiUnderstandingsTableReferences),
    AiUnderstanding,
    PrefetchHooks Function({bool questionId})> {
  $$AiUnderstandingsTableTableManager(
      _$MistakeDatabase db, $AiUnderstandingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiUnderstandingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiUnderstandingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiUnderstandingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> questionId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> questionType = const Value.absent(),
            Value<String?> knowledgePoint = const Value.absent(),
            Value<String?> difficulty = const Value.absent(),
            Value<String?> summary = const Value.absent(),
            Value<String?> answer = const Value.absent(),
            Value<String?> solution = const Value.absent(),
            Value<String?> approach = const Value.absent(),
            Value<String?> rawJson = const Value.absent(),
            Value<String?> model = const Value.absent(),
            Value<String?> error = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              AiUnderstandingsCompanion(
            id: id,
            questionId: questionId,
            status: status,
            questionType: questionType,
            knowledgePoint: knowledgePoint,
            difficulty: difficulty,
            summary: summary,
            answer: answer,
            solution: solution,
            approach: approach,
            rawJson: rawJson,
            model: model,
            error: error,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int questionId,
            Value<String> status = const Value.absent(),
            Value<String?> questionType = const Value.absent(),
            Value<String?> knowledgePoint = const Value.absent(),
            Value<String?> difficulty = const Value.absent(),
            Value<String?> summary = const Value.absent(),
            Value<String?> answer = const Value.absent(),
            Value<String?> solution = const Value.absent(),
            Value<String?> approach = const Value.absent(),
            Value<String?> rawJson = const Value.absent(),
            Value<String?> model = const Value.absent(),
            Value<String?> error = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              AiUnderstandingsCompanion.insert(
            id: id,
            questionId: questionId,
            status: status,
            questionType: questionType,
            knowledgePoint: knowledgePoint,
            difficulty: difficulty,
            summary: summary,
            answer: answer,
            solution: solution,
            approach: approach,
            rawJson: rawJson,
            model: model,
            error: error,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AiUnderstandingsTable, AiUnderstanding>(table),
                    $$AiUnderstandingsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({questionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (questionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.questionId,
                    referencedTable:
                        $$AiUnderstandingsTableReferences._questionIdTable(db),
                    referencedColumn: $$AiUnderstandingsTableReferences
                        ._questionIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AiUnderstandingsTableProcessedTableManager = ProcessedTableManager<
    _$MistakeDatabase,
    $AiUnderstandingsTable,
    AiUnderstanding,
    $$AiUnderstandingsTableFilterComposer,
    $$AiUnderstandingsTableOrderingComposer,
    $$AiUnderstandingsTableAnnotationComposer,
    $$AiUnderstandingsTableCreateCompanionBuilder,
    $$AiUnderstandingsTableUpdateCompanionBuilder,
    (AiUnderstanding, $$AiUnderstandingsTableReferences),
    AiUnderstanding,
    PrefetchHooks Function({bool questionId})>;
typedef $$AiMistakesTableCreateCompanionBuilder = AiMistakesCompanion Function({
  Value<int> id,
  required int questionId,
  Value<String> status,
  Value<String?> errorType,
  Value<String?> errorStep,
  Value<String?> reason,
  Value<String?> reviewSuggestion,
  Value<String?> rawJson,
  Value<String?> model,
  Value<String?> error,
  Value<DateTime> updatedAt,
});
typedef $$AiMistakesTableUpdateCompanionBuilder = AiMistakesCompanion Function({
  Value<int> id,
  Value<int> questionId,
  Value<String> status,
  Value<String?> errorType,
  Value<String?> errorStep,
  Value<String?> reason,
  Value<String?> reviewSuggestion,
  Value<String?> rawJson,
  Value<String?> model,
  Value<String?> error,
  Value<DateTime> updatedAt,
});

final class $$AiMistakesTableReferences
    extends BaseReferences<_$MistakeDatabase, $AiMistakesTable, AiMistake> {
  $$AiMistakesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuestionsTable _questionIdTable(_$MistakeDatabase db) =>
      db.questions.createAlias('ai_mistakes__question_id__questions__id');

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<int>('question_id')!;

    final manager = $$QuestionsTableTableManager($_db, $_db.questions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AiMistakesTableFilterComposer
    extends Composer<_$MistakeDatabase, $AiMistakesTable> {
  $$AiMistakesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorType => $composableBuilder(
      column: $table.errorType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorStep => $composableBuilder(
      column: $table.errorStep, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reviewSuggestion => $composableBuilder(
      column: $table.reviewSuggestion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rawJson => $composableBuilder(
      column: $table.rawJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get error => $composableBuilder(
      column: $table.error, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableFilterComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AiMistakesTableOrderingComposer
    extends Composer<_$MistakeDatabase, $AiMistakesTable> {
  $$AiMistakesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorType => $composableBuilder(
      column: $table.errorType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorStep => $composableBuilder(
      column: $table.errorStep, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reviewSuggestion => $composableBuilder(
      column: $table.reviewSuggestion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rawJson => $composableBuilder(
      column: $table.rawJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get error => $composableBuilder(
      column: $table.error, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableOrderingComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AiMistakesTableAnnotationComposer
    extends Composer<_$MistakeDatabase, $AiMistakesTable> {
  $$AiMistakesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorType =>
      $composableBuilder(column: $table.errorType, builder: (column) => column);

  GeneratedColumn<String> get errorStep =>
      $composableBuilder(column: $table.errorStep, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get reviewSuggestion => $composableBuilder(
      column: $table.reviewSuggestion, builder: (column) => column);

  GeneratedColumn<String> get rawJson =>
      $composableBuilder(column: $table.rawJson, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get error =>
      $composableBuilder(column: $table.error, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableAnnotationComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AiMistakesTableTableManager extends RootTableManager<
    _$MistakeDatabase,
    $AiMistakesTable,
    AiMistake,
    $$AiMistakesTableFilterComposer,
    $$AiMistakesTableOrderingComposer,
    $$AiMistakesTableAnnotationComposer,
    $$AiMistakesTableCreateCompanionBuilder,
    $$AiMistakesTableUpdateCompanionBuilder,
    (AiMistake, $$AiMistakesTableReferences),
    AiMistake,
    PrefetchHooks Function({bool questionId})> {
  $$AiMistakesTableTableManager(_$MistakeDatabase db, $AiMistakesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiMistakesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiMistakesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiMistakesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> questionId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> errorType = const Value.absent(),
            Value<String?> errorStep = const Value.absent(),
            Value<String?> reason = const Value.absent(),
            Value<String?> reviewSuggestion = const Value.absent(),
            Value<String?> rawJson = const Value.absent(),
            Value<String?> model = const Value.absent(),
            Value<String?> error = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              AiMistakesCompanion(
            id: id,
            questionId: questionId,
            status: status,
            errorType: errorType,
            errorStep: errorStep,
            reason: reason,
            reviewSuggestion: reviewSuggestion,
            rawJson: rawJson,
            model: model,
            error: error,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int questionId,
            Value<String> status = const Value.absent(),
            Value<String?> errorType = const Value.absent(),
            Value<String?> errorStep = const Value.absent(),
            Value<String?> reason = const Value.absent(),
            Value<String?> reviewSuggestion = const Value.absent(),
            Value<String?> rawJson = const Value.absent(),
            Value<String?> model = const Value.absent(),
            Value<String?> error = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              AiMistakesCompanion.insert(
            id: id,
            questionId: questionId,
            status: status,
            errorType: errorType,
            errorStep: errorStep,
            reason: reason,
            reviewSuggestion: reviewSuggestion,
            rawJson: rawJson,
            model: model,
            error: error,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AiMistakesTable, AiMistake>(table),
                    $$AiMistakesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({questionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (questionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.questionId,
                    referencedTable:
                        $$AiMistakesTableReferences._questionIdTable(db),
                    referencedColumn:
                        $$AiMistakesTableReferences._questionIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AiMistakesTableProcessedTableManager = ProcessedTableManager<
    _$MistakeDatabase,
    $AiMistakesTable,
    AiMistake,
    $$AiMistakesTableFilterComposer,
    $$AiMistakesTableOrderingComposer,
    $$AiMistakesTableAnnotationComposer,
    $$AiMistakesTableCreateCompanionBuilder,
    $$AiMistakesTableUpdateCompanionBuilder,
    (AiMistake, $$AiMistakesTableReferences),
    AiMistake,
    PrefetchHooks Function({bool questionId})>;
typedef $$GeneratedExercisesTableCreateCompanionBuilder
    = GeneratedExercisesCompanion Function({
  Value<int> id,
  required int sourceQuestionId,
  required String difficulty,
  required String contentJson,
  Value<DateTime> createdAt,
});
typedef $$GeneratedExercisesTableUpdateCompanionBuilder
    = GeneratedExercisesCompanion Function({
  Value<int> id,
  Value<int> sourceQuestionId,
  Value<String> difficulty,
  Value<String> contentJson,
  Value<DateTime> createdAt,
});

final class $$GeneratedExercisesTableReferences extends BaseReferences<
    _$MistakeDatabase, $GeneratedExercisesTable, GeneratedExercise> {
  $$GeneratedExercisesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $QuestionsTable _sourceQuestionIdTable(_$MistakeDatabase db) => db
      .questions
      .createAlias('generated_exercises__source_question_id__questions__id');

  $$QuestionsTableProcessedTableManager get sourceQuestionId {
    final $_column = $_itemColumn<int>('source_question_id')!;

    final manager = $$QuestionsTableTableManager($_db, $_db.questions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceQuestionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GeneratedExercisesTableFilterComposer
    extends Composer<_$MistakeDatabase, $GeneratedExercisesTable> {
  $$GeneratedExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentJson => $composableBuilder(
      column: $table.contentJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$QuestionsTableFilterComposer get sourceQuestionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sourceQuestionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableFilterComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GeneratedExercisesTableOrderingComposer
    extends Composer<_$MistakeDatabase, $GeneratedExercisesTable> {
  $$GeneratedExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentJson => $composableBuilder(
      column: $table.contentJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$QuestionsTableOrderingComposer get sourceQuestionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sourceQuestionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableOrderingComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GeneratedExercisesTableAnnotationComposer
    extends Composer<_$MistakeDatabase, $GeneratedExercisesTable> {
  $$GeneratedExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<String> get contentJson => $composableBuilder(
      column: $table.contentJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get sourceQuestionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sourceQuestionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableAnnotationComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GeneratedExercisesTableTableManager extends RootTableManager<
    _$MistakeDatabase,
    $GeneratedExercisesTable,
    GeneratedExercise,
    $$GeneratedExercisesTableFilterComposer,
    $$GeneratedExercisesTableOrderingComposer,
    $$GeneratedExercisesTableAnnotationComposer,
    $$GeneratedExercisesTableCreateCompanionBuilder,
    $$GeneratedExercisesTableUpdateCompanionBuilder,
    (GeneratedExercise, $$GeneratedExercisesTableReferences),
    GeneratedExercise,
    PrefetchHooks Function({bool sourceQuestionId})> {
  $$GeneratedExercisesTableTableManager(
      _$MistakeDatabase db, $GeneratedExercisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GeneratedExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GeneratedExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GeneratedExercisesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> sourceQuestionId = const Value.absent(),
            Value<String> difficulty = const Value.absent(),
            Value<String> contentJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              GeneratedExercisesCompanion(
            id: id,
            sourceQuestionId: sourceQuestionId,
            difficulty: difficulty,
            contentJson: contentJson,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int sourceQuestionId,
            required String difficulty,
            required String contentJson,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              GeneratedExercisesCompanion.insert(
            id: id,
            sourceQuestionId: sourceQuestionId,
            difficulty: difficulty,
            contentJson: contentJson,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$GeneratedExercisesTable, GeneratedExercise>(
                        table),
                    $$GeneratedExercisesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({sourceQuestionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (sourceQuestionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sourceQuestionId,
                    referencedTable: $$GeneratedExercisesTableReferences
                        ._sourceQuestionIdTable(db),
                    referencedColumn: $$GeneratedExercisesTableReferences
                        ._sourceQuestionIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$GeneratedExercisesTableProcessedTableManager = ProcessedTableManager<
    _$MistakeDatabase,
    $GeneratedExercisesTable,
    GeneratedExercise,
    $$GeneratedExercisesTableFilterComposer,
    $$GeneratedExercisesTableOrderingComposer,
    $$GeneratedExercisesTableAnnotationComposer,
    $$GeneratedExercisesTableCreateCompanionBuilder,
    $$GeneratedExercisesTableUpdateCompanionBuilder,
    (GeneratedExercise, $$GeneratedExercisesTableReferences),
    GeneratedExercise,
    PrefetchHooks Function({bool sourceQuestionId})>;
typedef $$PrintItemsTableCreateCompanionBuilder = PrintItemsCompanion Function({
  Value<int> id,
  Value<String> kind,
  Value<int?> questionId,
  Value<int?> exerciseId,
  Value<int> order,
  Value<int> answerSpaceMm,
  Value<bool> forcePageBreakBefore,
  Value<double?> scaleOverride,
  Value<bool> showSource,
  Value<bool> showOriginalNumber,
  Value<bool> showAnswer,
  Value<DateTime> createdAt,
});
typedef $$PrintItemsTableUpdateCompanionBuilder = PrintItemsCompanion Function({
  Value<int> id,
  Value<String> kind,
  Value<int?> questionId,
  Value<int?> exerciseId,
  Value<int> order,
  Value<int> answerSpaceMm,
  Value<bool> forcePageBreakBefore,
  Value<double?> scaleOverride,
  Value<bool> showSource,
  Value<bool> showOriginalNumber,
  Value<bool> showAnswer,
  Value<DateTime> createdAt,
});

class $$PrintItemsTableFilterComposer
    extends Composer<_$MistakeDatabase, $PrintItemsTable> {
  $$PrintItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get answerSpaceMm => $composableBuilder(
      column: $table.answerSpaceMm, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get forcePageBreakBefore => $composableBuilder(
      column: $table.forcePageBreakBefore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get scaleOverride => $composableBuilder(
      column: $table.scaleOverride, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showSource => $composableBuilder(
      column: $table.showSource, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showOriginalNumber => $composableBuilder(
      column: $table.showOriginalNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showAnswer => $composableBuilder(
      column: $table.showAnswer, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$PrintItemsTableOrderingComposer
    extends Composer<_$MistakeDatabase, $PrintItemsTable> {
  $$PrintItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get answerSpaceMm => $composableBuilder(
      column: $table.answerSpaceMm,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get forcePageBreakBefore => $composableBuilder(
      column: $table.forcePageBreakBefore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get scaleOverride => $composableBuilder(
      column: $table.scaleOverride,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showSource => $composableBuilder(
      column: $table.showSource, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showOriginalNumber => $composableBuilder(
      column: $table.showOriginalNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showAnswer => $composableBuilder(
      column: $table.showAnswer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$PrintItemsTableAnnotationComposer
    extends Composer<_$MistakeDatabase, $PrintItemsTable> {
  $$PrintItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => column);

  GeneratedColumn<int> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<int> get answerSpaceMm => $composableBuilder(
      column: $table.answerSpaceMm, builder: (column) => column);

  GeneratedColumn<bool> get forcePageBreakBefore => $composableBuilder(
      column: $table.forcePageBreakBefore, builder: (column) => column);

  GeneratedColumn<double> get scaleOverride => $composableBuilder(
      column: $table.scaleOverride, builder: (column) => column);

  GeneratedColumn<bool> get showSource => $composableBuilder(
      column: $table.showSource, builder: (column) => column);

  GeneratedColumn<bool> get showOriginalNumber => $composableBuilder(
      column: $table.showOriginalNumber, builder: (column) => column);

  GeneratedColumn<bool> get showAnswer => $composableBuilder(
      column: $table.showAnswer, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PrintItemsTableTableManager extends RootTableManager<
    _$MistakeDatabase,
    $PrintItemsTable,
    PrintItem,
    $$PrintItemsTableFilterComposer,
    $$PrintItemsTableOrderingComposer,
    $$PrintItemsTableAnnotationComposer,
    $$PrintItemsTableCreateCompanionBuilder,
    $$PrintItemsTableUpdateCompanionBuilder,
    (PrintItem, BaseReferences<_$MistakeDatabase, $PrintItemsTable, PrintItem>),
    PrintItem,
    PrefetchHooks Function()> {
  $$PrintItemsTableTableManager(_$MistakeDatabase db, $PrintItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrintItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrintItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrintItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> kind = const Value.absent(),
            Value<int?> questionId = const Value.absent(),
            Value<int?> exerciseId = const Value.absent(),
            Value<int> order = const Value.absent(),
            Value<int> answerSpaceMm = const Value.absent(),
            Value<bool> forcePageBreakBefore = const Value.absent(),
            Value<double?> scaleOverride = const Value.absent(),
            Value<bool> showSource = const Value.absent(),
            Value<bool> showOriginalNumber = const Value.absent(),
            Value<bool> showAnswer = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              PrintItemsCompanion(
            id: id,
            kind: kind,
            questionId: questionId,
            exerciseId: exerciseId,
            order: order,
            answerSpaceMm: answerSpaceMm,
            forcePageBreakBefore: forcePageBreakBefore,
            scaleOverride: scaleOverride,
            showSource: showSource,
            showOriginalNumber: showOriginalNumber,
            showAnswer: showAnswer,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> kind = const Value.absent(),
            Value<int?> questionId = const Value.absent(),
            Value<int?> exerciseId = const Value.absent(),
            Value<int> order = const Value.absent(),
            Value<int> answerSpaceMm = const Value.absent(),
            Value<bool> forcePageBreakBefore = const Value.absent(),
            Value<double?> scaleOverride = const Value.absent(),
            Value<bool> showSource = const Value.absent(),
            Value<bool> showOriginalNumber = const Value.absent(),
            Value<bool> showAnswer = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              PrintItemsCompanion.insert(
            id: id,
            kind: kind,
            questionId: questionId,
            exerciseId: exerciseId,
            order: order,
            answerSpaceMm: answerSpaceMm,
            forcePageBreakBefore: forcePageBreakBefore,
            scaleOverride: scaleOverride,
            showSource: showSource,
            showOriginalNumber: showOriginalNumber,
            showAnswer: showAnswer,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$PrintItemsTable, PrintItem>(table),
                    BaseReferences<_$MistakeDatabase, $PrintItemsTable,
                        PrintItem>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PrintItemsTableProcessedTableManager = ProcessedTableManager<
    _$MistakeDatabase,
    $PrintItemsTable,
    PrintItem,
    $$PrintItemsTableFilterComposer,
    $$PrintItemsTableOrderingComposer,
    $$PrintItemsTableAnnotationComposer,
    $$PrintItemsTableCreateCompanionBuilder,
    $$PrintItemsTableUpdateCompanionBuilder,
    (PrintItem, BaseReferences<_$MistakeDatabase, $PrintItemsTable, PrintItem>),
    PrintItem,
    PrefetchHooks Function()>;

class $MistakeDatabaseManager {
  final _$MistakeDatabase _db;
  $MistakeDatabaseManager(this._db);
  $$PapersTableTableManager get papers =>
      $$PapersTableTableManager(_db, _db.papers);
  $$PagesTableTableManager get pages =>
      $$PagesTableTableManager(_db, _db.pages);
  $$QuestionsTableTableManager get questions =>
      $$QuestionsTableTableManager(_db, _db.questions);
  $$BlocksTableTableManager get blocks =>
      $$BlocksTableTableManager(_db, _db.blocks);
  $$AnswerResourcesTableTableManager get answerResources =>
      $$AnswerResourcesTableTableManager(_db, _db.answerResources);
  $$BlockVersionsTableTableManager get blockVersions =>
      $$BlockVersionsTableTableManager(_db, _db.blockVersions);
  $$AiUnderstandingsTableTableManager get aiUnderstandings =>
      $$AiUnderstandingsTableTableManager(_db, _db.aiUnderstandings);
  $$AiMistakesTableTableManager get aiMistakes =>
      $$AiMistakesTableTableManager(_db, _db.aiMistakes);
  $$GeneratedExercisesTableTableManager get generatedExercises =>
      $$GeneratedExercisesTableTableManager(_db, _db.generatedExercises);
  $$PrintItemsTableTableManager get printItems =>
      $$PrintItemsTableTableManager(_db, _db.printItems);
}

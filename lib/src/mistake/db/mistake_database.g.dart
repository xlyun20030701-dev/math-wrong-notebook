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
          ..write('tags: $tags, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, paperId, originalQuestionNumber, title,
      knowledgePoint, tags, note, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Question &&
          other.id == this.id &&
          other.paperId == this.paperId &&
          other.originalQuestionNumber == this.originalQuestionNumber &&
          other.title == this.title &&
          other.knowledgePoint == this.knowledgePoint &&
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

abstract class _$MistakeDatabase extends GeneratedDatabase {
  _$MistakeDatabase(QueryExecutor e) : super(e);
  $MistakeDatabaseManager get managers => $MistakeDatabaseManager(this);
  late final $PapersTable papers = $PapersTable(this);
  late final $PagesTable pages = $PagesTable(this);
  late final $QuestionsTable questions = $QuestionsTable(this);
  late final $BlocksTable blocks = $BlocksTable(this);
  late final $AnswerResourcesTable answerResources =
      $AnswerResourcesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [papers, pages, questions, blocks, answerResources];
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
        {bool paperId, bool blocksRefs, bool answerResourcesRefs})> {
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
              answerResourcesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (blocksRefs) db.blocks,
                if (answerResourcesRefs) db.answerResources
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
        {bool paperId, bool blocksRefs, bool answerResourcesRefs})>;
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
    PrefetchHooks Function({bool questionId, bool pageId})> {
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
          prefetchHooksCallback: ({questionId = false, pageId = false}) {
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
                return [];
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
    PrefetchHooks Function({bool questionId, bool pageId})>;
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
}

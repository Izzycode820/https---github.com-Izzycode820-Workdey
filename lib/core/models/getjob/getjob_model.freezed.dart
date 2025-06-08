// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'getjob_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Job _$JobFromJson(Map<String, dynamic> json) {
  return _Job.fromJson(json);
}

/// @nodoc
mixin _$Job {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'job_type')
  String get jobType => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  int get poster =>
      throw _privateConstructorUsedError; // Can be String if just ID
  String get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'job_nature')
  String? get jobNature => throw _privateConstructorUsedError;
  @JsonKey(name: 'working_days')
  List<String>? get workingDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'due_date')
  DateTime? get dueDate => throw _privateConstructorUsedError;
  List<String>? get requirements => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'roles_description')
  String? get rolesDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'type_specific')
  Map<String, dynamic> get typeSpecific => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt =>
      throw _privateConstructorUsedError; // Computed fields from serializer
  @JsonKey(name: 'post_time')
  String? get postTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'salary_display')
  String? get salaryDisplay => throw _privateConstructorUsedError;
  @JsonKey(name: 'verification_badges')
  Map<String, dynamic>? get verificationBadges =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'has_applied')
  bool get hasApplied => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_saved')
  bool get isSaved => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_in')
  String? get expiresIn => throw _privateConstructorUsedError;
  @JsonKey(name: 'poster_picture')
  String? get posterPicture => throw _privateConstructorUsedError;

  /// Serializes this Job to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JobCopyWith<Job> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobCopyWith<$Res> {
  factory $JobCopyWith(Job value, $Res Function(Job) then) =
      _$JobCopyWithImpl<$Res, Job>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'job_type') String jobType,
      String title,
      String category,
      int poster,
      String location,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'job_nature') String? jobNature,
      @JsonKey(name: 'working_days') List<String>? workingDays,
      @JsonKey(name: 'due_date') DateTime? dueDate,
      List<String>? requirements,
      String description,
      @JsonKey(name: 'roles_description') String? rolesDescription,
      @JsonKey(name: 'type_specific') Map<String, dynamic> typeSpecific,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'post_time') String? postTime,
      @JsonKey(name: 'salary_display') String? salaryDisplay,
      @JsonKey(name: 'verification_badges')
      Map<String, dynamic>? verificationBadges,
      @JsonKey(name: 'has_applied') bool hasApplied,
      @JsonKey(name: 'is_saved') bool isSaved,
      @JsonKey(name: 'expires_in') String? expiresIn,
      @JsonKey(name: 'poster_picture') String? posterPicture});
}

/// @nodoc
class _$JobCopyWithImpl<$Res, $Val extends Job> implements $JobCopyWith<$Res> {
  _$JobCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jobType = null,
    Object? title = null,
    Object? category = null,
    Object? poster = null,
    Object? location = null,
    Object? createdAt = null,
    Object? jobNature = freezed,
    Object? workingDays = freezed,
    Object? dueDate = freezed,
    Object? requirements = freezed,
    Object? description = null,
    Object? rolesDescription = freezed,
    Object? typeSpecific = null,
    Object? updatedAt = null,
    Object? postTime = freezed,
    Object? salaryDisplay = freezed,
    Object? verificationBadges = freezed,
    Object? hasApplied = null,
    Object? isSaved = null,
    Object? expiresIn = freezed,
    Object? posterPicture = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      jobType: null == jobType
          ? _value.jobType
          : jobType // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      poster: null == poster
          ? _value.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      jobNature: freezed == jobNature
          ? _value.jobNature
          : jobNature // ignore: cast_nullable_to_non_nullable
              as String?,
      workingDays: freezed == workingDays
          ? _value.workingDays
          : workingDays // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      requirements: freezed == requirements
          ? _value.requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      rolesDescription: freezed == rolesDescription
          ? _value.rolesDescription
          : rolesDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      typeSpecific: null == typeSpecific
          ? _value.typeSpecific
          : typeSpecific // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      postTime: freezed == postTime
          ? _value.postTime
          : postTime // ignore: cast_nullable_to_non_nullable
              as String?,
      salaryDisplay: freezed == salaryDisplay
          ? _value.salaryDisplay
          : salaryDisplay // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationBadges: freezed == verificationBadges
          ? _value.verificationBadges
          : verificationBadges // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      hasApplied: null == hasApplied
          ? _value.hasApplied
          : hasApplied // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaved: null == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      expiresIn: freezed == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPicture: freezed == posterPicture
          ? _value.posterPicture
          : posterPicture // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JobImplCopyWith<$Res> implements $JobCopyWith<$Res> {
  factory _$$JobImplCopyWith(_$JobImpl value, $Res Function(_$JobImpl) then) =
      __$$JobImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'job_type') String jobType,
      String title,
      String category,
      int poster,
      String location,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'job_nature') String? jobNature,
      @JsonKey(name: 'working_days') List<String>? workingDays,
      @JsonKey(name: 'due_date') DateTime? dueDate,
      List<String>? requirements,
      String description,
      @JsonKey(name: 'roles_description') String? rolesDescription,
      @JsonKey(name: 'type_specific') Map<String, dynamic> typeSpecific,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'post_time') String? postTime,
      @JsonKey(name: 'salary_display') String? salaryDisplay,
      @JsonKey(name: 'verification_badges')
      Map<String, dynamic>? verificationBadges,
      @JsonKey(name: 'has_applied') bool hasApplied,
      @JsonKey(name: 'is_saved') bool isSaved,
      @JsonKey(name: 'expires_in') String? expiresIn,
      @JsonKey(name: 'poster_picture') String? posterPicture});
}

/// @nodoc
class __$$JobImplCopyWithImpl<$Res> extends _$JobCopyWithImpl<$Res, _$JobImpl>
    implements _$$JobImplCopyWith<$Res> {
  __$$JobImplCopyWithImpl(_$JobImpl _value, $Res Function(_$JobImpl) _then)
      : super(_value, _then);

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jobType = null,
    Object? title = null,
    Object? category = null,
    Object? poster = null,
    Object? location = null,
    Object? createdAt = null,
    Object? jobNature = freezed,
    Object? workingDays = freezed,
    Object? dueDate = freezed,
    Object? requirements = freezed,
    Object? description = null,
    Object? rolesDescription = freezed,
    Object? typeSpecific = null,
    Object? updatedAt = null,
    Object? postTime = freezed,
    Object? salaryDisplay = freezed,
    Object? verificationBadges = freezed,
    Object? hasApplied = null,
    Object? isSaved = null,
    Object? expiresIn = freezed,
    Object? posterPicture = freezed,
  }) {
    return _then(_$JobImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      jobType: null == jobType
          ? _value.jobType
          : jobType // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      poster: null == poster
          ? _value.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      jobNature: freezed == jobNature
          ? _value.jobNature
          : jobNature // ignore: cast_nullable_to_non_nullable
              as String?,
      workingDays: freezed == workingDays
          ? _value._workingDays
          : workingDays // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      requirements: freezed == requirements
          ? _value._requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      rolesDescription: freezed == rolesDescription
          ? _value.rolesDescription
          : rolesDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      typeSpecific: null == typeSpecific
          ? _value._typeSpecific
          : typeSpecific // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      postTime: freezed == postTime
          ? _value.postTime
          : postTime // ignore: cast_nullable_to_non_nullable
              as String?,
      salaryDisplay: freezed == salaryDisplay
          ? _value.salaryDisplay
          : salaryDisplay // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationBadges: freezed == verificationBadges
          ? _value._verificationBadges
          : verificationBadges // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      hasApplied: null == hasApplied
          ? _value.hasApplied
          : hasApplied // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaved: null == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      expiresIn: freezed == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPicture: freezed == posterPicture
          ? _value.posterPicture
          : posterPicture // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$JobImpl with DiagnosticableTreeMixin implements _Job {
  const _$JobImpl(
      {required this.id,
      @JsonKey(name: 'job_type') required this.jobType,
      required this.title,
      required this.category,
      required this.poster,
      required this.location,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'job_nature') this.jobNature,
      @JsonKey(name: 'working_days') final List<String>? workingDays,
      @JsonKey(name: 'due_date') this.dueDate,
      final List<String>? requirements,
      required this.description,
      @JsonKey(name: 'roles_description') this.rolesDescription,
      @JsonKey(name: 'type_specific')
      required final Map<String, dynamic> typeSpecific,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(name: 'post_time') this.postTime,
      @JsonKey(name: 'salary_display') this.salaryDisplay,
      @JsonKey(name: 'verification_badges')
      final Map<String, dynamic>? verificationBadges,
      @JsonKey(name: 'has_applied') this.hasApplied = false,
      @JsonKey(name: 'is_saved') this.isSaved = false,
      @JsonKey(name: 'expires_in') this.expiresIn,
      @JsonKey(name: 'poster_picture') this.posterPicture})
      : _workingDays = workingDays,
        _requirements = requirements,
        _typeSpecific = typeSpecific,
        _verificationBadges = verificationBadges;

  factory _$JobImpl.fromJson(Map<String, dynamic> json) =>
      _$$JobImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'job_type')
  final String jobType;
  @override
  final String title;
  @override
  final String category;
  @override
  final int poster;
// Can be String if just ID
  @override
  final String location;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'job_nature')
  final String? jobNature;
  final List<String>? _workingDays;
  @override
  @JsonKey(name: 'working_days')
  List<String>? get workingDays {
    final value = _workingDays;
    if (value == null) return null;
    if (_workingDays is EqualUnmodifiableListView) return _workingDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'due_date')
  final DateTime? dueDate;
  final List<String>? _requirements;
  @override
  List<String>? get requirements {
    final value = _requirements;
    if (value == null) return null;
    if (_requirements is EqualUnmodifiableListView) return _requirements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String description;
  @override
  @JsonKey(name: 'roles_description')
  final String? rolesDescription;
  final Map<String, dynamic> _typeSpecific;
  @override
  @JsonKey(name: 'type_specific')
  Map<String, dynamic> get typeSpecific {
    if (_typeSpecific is EqualUnmodifiableMapView) return _typeSpecific;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_typeSpecific);
  }

  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
// Computed fields from serializer
  @override
  @JsonKey(name: 'post_time')
  final String? postTime;
  @override
  @JsonKey(name: 'salary_display')
  final String? salaryDisplay;
  final Map<String, dynamic>? _verificationBadges;
  @override
  @JsonKey(name: 'verification_badges')
  Map<String, dynamic>? get verificationBadges {
    final value = _verificationBadges;
    if (value == null) return null;
    if (_verificationBadges is EqualUnmodifiableMapView)
      return _verificationBadges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'has_applied')
  final bool hasApplied;
  @override
  @JsonKey(name: 'is_saved')
  final bool isSaved;
  @override
  @JsonKey(name: 'expires_in')
  final String? expiresIn;
  @override
  @JsonKey(name: 'poster_picture')
  final String? posterPicture;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Job(id: $id, jobType: $jobType, title: $title, category: $category, poster: $poster, location: $location, createdAt: $createdAt, jobNature: $jobNature, workingDays: $workingDays, dueDate: $dueDate, requirements: $requirements, description: $description, rolesDescription: $rolesDescription, typeSpecific: $typeSpecific, updatedAt: $updatedAt, postTime: $postTime, salaryDisplay: $salaryDisplay, verificationBadges: $verificationBadges, hasApplied: $hasApplied, isSaved: $isSaved, expiresIn: $expiresIn, posterPicture: $posterPicture)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Job'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('jobType', jobType))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('poster', poster))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('jobNature', jobNature))
      ..add(DiagnosticsProperty('workingDays', workingDays))
      ..add(DiagnosticsProperty('dueDate', dueDate))
      ..add(DiagnosticsProperty('requirements', requirements))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('rolesDescription', rolesDescription))
      ..add(DiagnosticsProperty('typeSpecific', typeSpecific))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('postTime', postTime))
      ..add(DiagnosticsProperty('salaryDisplay', salaryDisplay))
      ..add(DiagnosticsProperty('verificationBadges', verificationBadges))
      ..add(DiagnosticsProperty('hasApplied', hasApplied))
      ..add(DiagnosticsProperty('isSaved', isSaved))
      ..add(DiagnosticsProperty('expiresIn', expiresIn))
      ..add(DiagnosticsProperty('posterPicture', posterPicture));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JobImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.jobType, jobType) || other.jobType == jobType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.poster, poster) || other.poster == poster) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.jobNature, jobNature) ||
                other.jobNature == jobNature) &&
            const DeepCollectionEquality()
                .equals(other._workingDays, _workingDays) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            const DeepCollectionEquality()
                .equals(other._requirements, _requirements) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.rolesDescription, rolesDescription) ||
                other.rolesDescription == rolesDescription) &&
            const DeepCollectionEquality()
                .equals(other._typeSpecific, _typeSpecific) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.postTime, postTime) ||
                other.postTime == postTime) &&
            (identical(other.salaryDisplay, salaryDisplay) ||
                other.salaryDisplay == salaryDisplay) &&
            const DeepCollectionEquality()
                .equals(other._verificationBadges, _verificationBadges) &&
            (identical(other.hasApplied, hasApplied) ||
                other.hasApplied == hasApplied) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.posterPicture, posterPicture) ||
                other.posterPicture == posterPicture));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        jobType,
        title,
        category,
        poster,
        location,
        createdAt,
        jobNature,
        const DeepCollectionEquality().hash(_workingDays),
        dueDate,
        const DeepCollectionEquality().hash(_requirements),
        description,
        rolesDescription,
        const DeepCollectionEquality().hash(_typeSpecific),
        updatedAt,
        postTime,
        salaryDisplay,
        const DeepCollectionEquality().hash(_verificationBadges),
        hasApplied,
        isSaved,
        expiresIn,
        posterPicture
      ]);

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JobImplCopyWith<_$JobImpl> get copyWith =>
      __$$JobImplCopyWithImpl<_$JobImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JobImplToJson(
      this,
    );
  }
}

abstract class _Job implements Job {
  const factory _Job(
          {required final int id,
          @JsonKey(name: 'job_type') required final String jobType,
          required final String title,
          required final String category,
          required final int poster,
          required final String location,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'job_nature') final String? jobNature,
          @JsonKey(name: 'working_days') final List<String>? workingDays,
          @JsonKey(name: 'due_date') final DateTime? dueDate,
          final List<String>? requirements,
          required final String description,
          @JsonKey(name: 'roles_description') final String? rolesDescription,
          @JsonKey(name: 'type_specific')
          required final Map<String, dynamic> typeSpecific,
          @JsonKey(name: 'updated_at') required final DateTime updatedAt,
          @JsonKey(name: 'post_time') final String? postTime,
          @JsonKey(name: 'salary_display') final String? salaryDisplay,
          @JsonKey(name: 'verification_badges')
          final Map<String, dynamic>? verificationBadges,
          @JsonKey(name: 'has_applied') final bool hasApplied,
          @JsonKey(name: 'is_saved') final bool isSaved,
          @JsonKey(name: 'expires_in') final String? expiresIn,
          @JsonKey(name: 'poster_picture') final String? posterPicture}) =
      _$JobImpl;

  factory _Job.fromJson(Map<String, dynamic> json) = _$JobImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'job_type')
  String get jobType;
  @override
  String get title;
  @override
  String get category;
  @override
  int get poster; // Can be String if just ID
  @override
  String get location;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'job_nature')
  String? get jobNature;
  @override
  @JsonKey(name: 'working_days')
  List<String>? get workingDays;
  @override
  @JsonKey(name: 'due_date')
  DateTime? get dueDate;
  @override
  List<String>? get requirements;
  @override
  String get description;
  @override
  @JsonKey(name: 'roles_description')
  String? get rolesDescription;
  @override
  @JsonKey(name: 'type_specific')
  Map<String, dynamic> get typeSpecific;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt; // Computed fields from serializer
  @override
  @JsonKey(name: 'post_time')
  String? get postTime;
  @override
  @JsonKey(name: 'salary_display')
  String? get salaryDisplay;
  @override
  @JsonKey(name: 'verification_badges')
  Map<String, dynamic>? get verificationBadges;
  @override
  @JsonKey(name: 'has_applied')
  bool get hasApplied;
  @override
  @JsonKey(name: 'is_saved')
  bool get isSaved;
  @override
  @JsonKey(name: 'expires_in')
  String? get expiresIn;
  @override
  @JsonKey(name: 'poster_picture')
  String? get posterPicture;

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JobImplCopyWith<_$JobImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_job_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostJob _$PostJobFromJson(Map<String, dynamic> json) {
  return _PostJob.fromJson(json);
}

/// @nodoc
mixin _$PostJob {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'job_type')
  String get jobType => throw _privateConstructorUsedError; // Match backend
  String get title => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'Job nature')
  String? get jobNature => throw _privateConstructorUsedError; // Match backend
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'roles_description')
  String? get rolesDescription =>
      throw _privateConstructorUsedError; // Match backend
  @JsonKey(name: 'requirements')
  List<String> get requirements => throw _privateConstructorUsedError;
  @JsonKey(name: 'working_days')
  List<String> get workingDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'due_date')
  String? get dueDate => throw _privateConstructorUsedError; // Match backend
  @JsonKey(name: 'type_specific')
  Map<String, dynamic> get typeSpecific => throw _privateConstructorUsedError;

  /// Serializes this PostJob to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostJob
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostJobCopyWith<PostJob> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostJobCopyWith<$Res> {
  factory $PostJobCopyWith(PostJob value, $Res Function(PostJob) then) =
      _$PostJobCopyWithImpl<$Res, PostJob>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'job_type') String jobType,
      String title,
      String category,
      String location,
      @JsonKey(name: 'Job nature') String? jobNature,
      String description,
      @JsonKey(name: 'roles_description') String? rolesDescription,
      @JsonKey(name: 'requirements') List<String> requirements,
      @JsonKey(name: 'working_days') List<String> workingDays,
      @JsonKey(name: 'due_date') String? dueDate,
      @JsonKey(name: 'type_specific') Map<String, dynamic> typeSpecific});
}

/// @nodoc
class _$PostJobCopyWithImpl<$Res, $Val extends PostJob>
    implements $PostJobCopyWith<$Res> {
  _$PostJobCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostJob
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? jobType = null,
    Object? title = null,
    Object? category = null,
    Object? location = null,
    Object? jobNature = freezed,
    Object? description = null,
    Object? rolesDescription = freezed,
    Object? requirements = null,
    Object? workingDays = null,
    Object? dueDate = freezed,
    Object? typeSpecific = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      jobNature: freezed == jobNature
          ? _value.jobNature
          : jobNature // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      rolesDescription: freezed == rolesDescription
          ? _value.rolesDescription
          : rolesDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      requirements: null == requirements
          ? _value.requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      workingDays: null == workingDays
          ? _value.workingDays
          : workingDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      typeSpecific: null == typeSpecific
          ? _value.typeSpecific
          : typeSpecific // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostJobImplCopyWith<$Res> implements $PostJobCopyWith<$Res> {
  factory _$$PostJobImplCopyWith(
          _$PostJobImpl value, $Res Function(_$PostJobImpl) then) =
      __$$PostJobImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'job_type') String jobType,
      String title,
      String category,
      String location,
      @JsonKey(name: 'Job nature') String? jobNature,
      String description,
      @JsonKey(name: 'roles_description') String? rolesDescription,
      @JsonKey(name: 'requirements') List<String> requirements,
      @JsonKey(name: 'working_days') List<String> workingDays,
      @JsonKey(name: 'due_date') String? dueDate,
      @JsonKey(name: 'type_specific') Map<String, dynamic> typeSpecific});
}

/// @nodoc
class __$$PostJobImplCopyWithImpl<$Res>
    extends _$PostJobCopyWithImpl<$Res, _$PostJobImpl>
    implements _$$PostJobImplCopyWith<$Res> {
  __$$PostJobImplCopyWithImpl(
      _$PostJobImpl _value, $Res Function(_$PostJobImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostJob
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? jobType = null,
    Object? title = null,
    Object? category = null,
    Object? location = null,
    Object? jobNature = freezed,
    Object? description = null,
    Object? rolesDescription = freezed,
    Object? requirements = null,
    Object? workingDays = null,
    Object? dueDate = freezed,
    Object? typeSpecific = null,
  }) {
    return _then(_$PostJobImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      jobNature: freezed == jobNature
          ? _value.jobNature
          : jobNature // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      rolesDescription: freezed == rolesDescription
          ? _value.rolesDescription
          : rolesDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      requirements: null == requirements
          ? _value._requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      workingDays: null == workingDays
          ? _value._workingDays
          : workingDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      typeSpecific: null == typeSpecific
          ? _value._typeSpecific
          : typeSpecific // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PostJobImpl with DiagnosticableTreeMixin implements _PostJob {
  const _$PostJobImpl(
      {this.id,
      @JsonKey(name: 'job_type') required this.jobType,
      required this.title,
      required this.category,
      required this.location,
      @JsonKey(name: 'Job nature') this.jobNature,
      required this.description,
      @JsonKey(name: 'roles_description') this.rolesDescription,
      @JsonKey(name: 'requirements') final List<String> requirements = const [],
      @JsonKey(name: 'working_days') final List<String> workingDays = const [],
      @JsonKey(name: 'due_date') this.dueDate,
      @JsonKey(name: 'type_specific')
      final Map<String, dynamic> typeSpecific = const {}})
      : _requirements = requirements,
        _workingDays = workingDays,
        _typeSpecific = typeSpecific;

  factory _$PostJobImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostJobImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'job_type')
  final String jobType;
// Match backend
  @override
  final String title;
  @override
  final String category;
  @override
  final String location;
  @override
  @JsonKey(name: 'Job nature')
  final String? jobNature;
// Match backend
  @override
  final String description;
  @override
  @JsonKey(name: 'roles_description')
  final String? rolesDescription;
// Match backend
  final List<String> _requirements;
// Match backend
  @override
  @JsonKey(name: 'requirements')
  List<String> get requirements {
    if (_requirements is EqualUnmodifiableListView) return _requirements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requirements);
  }

  final List<String> _workingDays;
  @override
  @JsonKey(name: 'working_days')
  List<String> get workingDays {
    if (_workingDays is EqualUnmodifiableListView) return _workingDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workingDays);
  }

  @override
  @JsonKey(name: 'due_date')
  final String? dueDate;
// Match backend
  final Map<String, dynamic> _typeSpecific;
// Match backend
  @override
  @JsonKey(name: 'type_specific')
  Map<String, dynamic> get typeSpecific {
    if (_typeSpecific is EqualUnmodifiableMapView) return _typeSpecific;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_typeSpecific);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PostJob(id: $id, jobType: $jobType, title: $title, category: $category, location: $location, jobNature: $jobNature, description: $description, rolesDescription: $rolesDescription, requirements: $requirements, workingDays: $workingDays, dueDate: $dueDate, typeSpecific: $typeSpecific)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PostJob'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('jobType', jobType))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('jobNature', jobNature))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('rolesDescription', rolesDescription))
      ..add(DiagnosticsProperty('requirements', requirements))
      ..add(DiagnosticsProperty('workingDays', workingDays))
      ..add(DiagnosticsProperty('dueDate', dueDate))
      ..add(DiagnosticsProperty('typeSpecific', typeSpecific));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostJobImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.jobType, jobType) || other.jobType == jobType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.jobNature, jobNature) ||
                other.jobNature == jobNature) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.rolesDescription, rolesDescription) ||
                other.rolesDescription == rolesDescription) &&
            const DeepCollectionEquality()
                .equals(other._requirements, _requirements) &&
            const DeepCollectionEquality()
                .equals(other._workingDays, _workingDays) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            const DeepCollectionEquality()
                .equals(other._typeSpecific, _typeSpecific));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      jobType,
      title,
      category,
      location,
      jobNature,
      description,
      rolesDescription,
      const DeepCollectionEquality().hash(_requirements),
      const DeepCollectionEquality().hash(_workingDays),
      dueDate,
      const DeepCollectionEquality().hash(_typeSpecific));

  /// Create a copy of PostJob
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostJobImplCopyWith<_$PostJobImpl> get copyWith =>
      __$$PostJobImplCopyWithImpl<_$PostJobImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostJobImplToJson(
      this,
    );
  }
}

abstract class _PostJob implements PostJob {
  const factory _PostJob(
      {final int? id,
      @JsonKey(name: 'job_type') required final String jobType,
      required final String title,
      required final String category,
      required final String location,
      @JsonKey(name: 'Job nature') final String? jobNature,
      required final String description,
      @JsonKey(name: 'roles_description') final String? rolesDescription,
      @JsonKey(name: 'requirements') final List<String> requirements,
      @JsonKey(name: 'working_days') final List<String> workingDays,
      @JsonKey(name: 'due_date') final String? dueDate,
      @JsonKey(name: 'type_specific')
      final Map<String, dynamic> typeSpecific}) = _$PostJobImpl;

  factory _PostJob.fromJson(Map<String, dynamic> json) = _$PostJobImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'job_type')
  String get jobType; // Match backend
  @override
  String get title;
  @override
  String get category;
  @override
  String get location;
  @override
  @JsonKey(name: 'Job nature')
  String? get jobNature; // Match backend
  @override
  String get description;
  @override
  @JsonKey(name: 'roles_description')
  String? get rolesDescription; // Match backend
  @override
  @JsonKey(name: 'requirements')
  List<String> get requirements;
  @override
  @JsonKey(name: 'working_days')
  List<String> get workingDays;
  @override
  @JsonKey(name: 'due_date')
  String? get dueDate; // Match backend
  @override
  @JsonKey(name: 'type_specific')
  Map<String, dynamic> get typeSpecific;

  /// Create a copy of PostJob
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostJobImplCopyWith<_$PostJobImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

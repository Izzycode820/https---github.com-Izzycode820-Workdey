// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'applicant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Application _$ApplicationFromJson(Map<String, dynamic> json) {
  return _Application.fromJson(json);
}

/// @nodoc
mixin _$Application {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'applied_at')
  DateTime get appliedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'applicant_details')
  ApplicantDetails get details => throw _privateConstructorUsedError;
  @JsonKey(name: 'response')
  ApplicationResponse? get response => throw _privateConstructorUsedError;
  @JsonKey(name: 'match_stats')
  MatchStats? get matchStats => throw _privateConstructorUsedError;
  @JsonKey(name: 'completion')
  JobCompletion? get completion => throw _privateConstructorUsedError;

  /// Serializes this Application to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApplicationCopyWith<Application> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicationCopyWith<$Res> {
  factory $ApplicationCopyWith(
          Application value, $Res Function(Application) then) =
      _$ApplicationCopyWithImpl<$Res, Application>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'status') String status,
      @JsonKey(name: 'applied_at') DateTime appliedAt,
      @JsonKey(name: 'applicant_details') ApplicantDetails details,
      @JsonKey(name: 'response') ApplicationResponse? response,
      @JsonKey(name: 'match_stats') MatchStats? matchStats,
      @JsonKey(name: 'completion') JobCompletion? completion});

  $ApplicantDetailsCopyWith<$Res> get details;
  $ApplicationResponseCopyWith<$Res>? get response;
  $MatchStatsCopyWith<$Res>? get matchStats;
  $JobCompletionCopyWith<$Res>? get completion;
}

/// @nodoc
class _$ApplicationCopyWithImpl<$Res, $Val extends Application>
    implements $ApplicationCopyWith<$Res> {
  _$ApplicationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? appliedAt = null,
    Object? details = null,
    Object? response = freezed,
    Object? matchStats = freezed,
    Object? completion = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      appliedAt: null == appliedAt
          ? _value.appliedAt
          : appliedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as ApplicantDetails,
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ApplicationResponse?,
      matchStats: freezed == matchStats
          ? _value.matchStats
          : matchStats // ignore: cast_nullable_to_non_nullable
              as MatchStats?,
      completion: freezed == completion
          ? _value.completion
          : completion // ignore: cast_nullable_to_non_nullable
              as JobCompletion?,
    ) as $Val);
  }

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApplicantDetailsCopyWith<$Res> get details {
    return $ApplicantDetailsCopyWith<$Res>(_value.details, (value) {
      return _then(_value.copyWith(details: value) as $Val);
    });
  }

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApplicationResponseCopyWith<$Res>? get response {
    if (_value.response == null) {
      return null;
    }

    return $ApplicationResponseCopyWith<$Res>(_value.response!, (value) {
      return _then(_value.copyWith(response: value) as $Val);
    });
  }

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MatchStatsCopyWith<$Res>? get matchStats {
    if (_value.matchStats == null) {
      return null;
    }

    return $MatchStatsCopyWith<$Res>(_value.matchStats!, (value) {
      return _then(_value.copyWith(matchStats: value) as $Val);
    });
  }

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $JobCompletionCopyWith<$Res>? get completion {
    if (_value.completion == null) {
      return null;
    }

    return $JobCompletionCopyWith<$Res>(_value.completion!, (value) {
      return _then(_value.copyWith(completion: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApplicationImplCopyWith<$Res>
    implements $ApplicationCopyWith<$Res> {
  factory _$$ApplicationImplCopyWith(
          _$ApplicationImpl value, $Res Function(_$ApplicationImpl) then) =
      __$$ApplicationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'status') String status,
      @JsonKey(name: 'applied_at') DateTime appliedAt,
      @JsonKey(name: 'applicant_details') ApplicantDetails details,
      @JsonKey(name: 'response') ApplicationResponse? response,
      @JsonKey(name: 'match_stats') MatchStats? matchStats,
      @JsonKey(name: 'completion') JobCompletion? completion});

  @override
  $ApplicantDetailsCopyWith<$Res> get details;
  @override
  $ApplicationResponseCopyWith<$Res>? get response;
  @override
  $MatchStatsCopyWith<$Res>? get matchStats;
  @override
  $JobCompletionCopyWith<$Res>? get completion;
}

/// @nodoc
class __$$ApplicationImplCopyWithImpl<$Res>
    extends _$ApplicationCopyWithImpl<$Res, _$ApplicationImpl>
    implements _$$ApplicationImplCopyWith<$Res> {
  __$$ApplicationImplCopyWithImpl(
      _$ApplicationImpl _value, $Res Function(_$ApplicationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? appliedAt = null,
    Object? details = null,
    Object? response = freezed,
    Object? matchStats = freezed,
    Object? completion = freezed,
  }) {
    return _then(_$ApplicationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      appliedAt: null == appliedAt
          ? _value.appliedAt
          : appliedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as ApplicantDetails,
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ApplicationResponse?,
      matchStats: freezed == matchStats
          ? _value.matchStats
          : matchStats // ignore: cast_nullable_to_non_nullable
              as MatchStats?,
      completion: freezed == completion
          ? _value.completion
          : completion // ignore: cast_nullable_to_non_nullable
              as JobCompletion?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApplicationImpl implements _Application {
  const _$ApplicationImpl(
      {required this.id,
      @JsonKey(name: 'status') required this.status,
      @JsonKey(name: 'applied_at') required this.appliedAt,
      @JsonKey(name: 'applicant_details') required this.details,
      @JsonKey(name: 'response') this.response,
      @JsonKey(name: 'match_stats') this.matchStats,
      @JsonKey(name: 'completion') this.completion});

  factory _$ApplicationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplicationImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'status')
  final String status;
  @override
  @JsonKey(name: 'applied_at')
  final DateTime appliedAt;
  @override
  @JsonKey(name: 'applicant_details')
  final ApplicantDetails details;
  @override
  @JsonKey(name: 'response')
  final ApplicationResponse? response;
  @override
  @JsonKey(name: 'match_stats')
  final MatchStats? matchStats;
  @override
  @JsonKey(name: 'completion')
  final JobCompletion? completion;

  @override
  String toString() {
    return 'Application(id: $id, status: $status, appliedAt: $appliedAt, details: $details, response: $response, matchStats: $matchStats, completion: $completion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplicationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.appliedAt, appliedAt) ||
                other.appliedAt == appliedAt) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.matchStats, matchStats) ||
                other.matchStats == matchStats) &&
            (identical(other.completion, completion) ||
                other.completion == completion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, status, appliedAt, details,
      response, matchStats, completion);

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplicationImplCopyWith<_$ApplicationImpl> get copyWith =>
      __$$ApplicationImplCopyWithImpl<_$ApplicationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplicationImplToJson(
      this,
    );
  }
}

abstract class _Application implements Application {
  const factory _Application(
          {required final int id,
          @JsonKey(name: 'status') required final String status,
          @JsonKey(name: 'applied_at') required final DateTime appliedAt,
          @JsonKey(name: 'applicant_details')
          required final ApplicantDetails details,
          @JsonKey(name: 'response') final ApplicationResponse? response,
          @JsonKey(name: 'match_stats') final MatchStats? matchStats,
          @JsonKey(name: 'completion') final JobCompletion? completion}) =
      _$ApplicationImpl;

  factory _Application.fromJson(Map<String, dynamic> json) =
      _$ApplicationImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'status')
  String get status;
  @override
  @JsonKey(name: 'applied_at')
  DateTime get appliedAt;
  @override
  @JsonKey(name: 'applicant_details')
  ApplicantDetails get details;
  @override
  @JsonKey(name: 'response')
  ApplicationResponse? get response;
  @override
  @JsonKey(name: 'match_stats')
  MatchStats? get matchStats;
  @override
  @JsonKey(name: 'completion')
  JobCompletion? get completion;

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplicationImplCopyWith<_$ApplicationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApplicantDetails _$ApplicantDetailsFromJson(Map<String, dynamic> json) {
  return _ApplicantDetails.fromJson(json);
}

/// @nodoc
mixin _$ApplicantDetails {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 0)
  int get verification_level => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_jobs', defaultValue: 0)
  int get completedJobs => throw _privateConstructorUsedError;

  /// Serializes this ApplicantDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApplicantDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApplicantDetailsCopyWith<ApplicantDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicantDetailsCopyWith<$Res> {
  factory $ApplicantDetailsCopyWith(
          ApplicantDetails value, $Res Function(ApplicantDetails) then) =
      _$ApplicantDetailsCopyWithImpl<$Res, ApplicantDetails>;
  @useResult
  $Res call(
      {String name,
      @JsonKey(defaultValue: 0) int verification_level,
      @JsonKey(name: 'completed_jobs', defaultValue: 0) int completedJobs});
}

/// @nodoc
class _$ApplicantDetailsCopyWithImpl<$Res, $Val extends ApplicantDetails>
    implements $ApplicantDetailsCopyWith<$Res> {
  _$ApplicantDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApplicantDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? verification_level = null,
    Object? completedJobs = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      verification_level: null == verification_level
          ? _value.verification_level
          : verification_level // ignore: cast_nullable_to_non_nullable
              as int,
      completedJobs: null == completedJobs
          ? _value.completedJobs
          : completedJobs // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApplicantDetailsImplCopyWith<$Res>
    implements $ApplicantDetailsCopyWith<$Res> {
  factory _$$ApplicantDetailsImplCopyWith(_$ApplicantDetailsImpl value,
          $Res Function(_$ApplicantDetailsImpl) then) =
      __$$ApplicantDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      @JsonKey(defaultValue: 0) int verification_level,
      @JsonKey(name: 'completed_jobs', defaultValue: 0) int completedJobs});
}

/// @nodoc
class __$$ApplicantDetailsImplCopyWithImpl<$Res>
    extends _$ApplicantDetailsCopyWithImpl<$Res, _$ApplicantDetailsImpl>
    implements _$$ApplicantDetailsImplCopyWith<$Res> {
  __$$ApplicantDetailsImplCopyWithImpl(_$ApplicantDetailsImpl _value,
      $Res Function(_$ApplicantDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApplicantDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? verification_level = null,
    Object? completedJobs = null,
  }) {
    return _then(_$ApplicantDetailsImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      verification_level: null == verification_level
          ? _value.verification_level
          : verification_level // ignore: cast_nullable_to_non_nullable
              as int,
      completedJobs: null == completedJobs
          ? _value.completedJobs
          : completedJobs // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApplicantDetailsImpl implements _ApplicantDetails {
  const _$ApplicantDetailsImpl(
      {required this.name,
      @JsonKey(defaultValue: 0) required this.verification_level,
      @JsonKey(name: 'completed_jobs', defaultValue: 0)
      required this.completedJobs});

  factory _$ApplicantDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplicantDetailsImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(defaultValue: 0)
  final int verification_level;
  @override
  @JsonKey(name: 'completed_jobs', defaultValue: 0)
  final int completedJobs;

  @override
  String toString() {
    return 'ApplicantDetails(name: $name, verification_level: $verification_level, completedJobs: $completedJobs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplicantDetailsImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.verification_level, verification_level) ||
                other.verification_level == verification_level) &&
            (identical(other.completedJobs, completedJobs) ||
                other.completedJobs == completedJobs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, verification_level, completedJobs);

  /// Create a copy of ApplicantDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplicantDetailsImplCopyWith<_$ApplicantDetailsImpl> get copyWith =>
      __$$ApplicantDetailsImplCopyWithImpl<_$ApplicantDetailsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplicantDetailsImplToJson(
      this,
    );
  }
}

abstract class _ApplicantDetails implements ApplicantDetails {
  const factory _ApplicantDetails(
      {required final String name,
      @JsonKey(defaultValue: 0) required final int verification_level,
      @JsonKey(name: 'completed_jobs', defaultValue: 0)
      required final int completedJobs}) = _$ApplicantDetailsImpl;

  factory _ApplicantDetails.fromJson(Map<String, dynamic> json) =
      _$ApplicantDetailsImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(defaultValue: 0)
  int get verification_level;
  @override
  @JsonKey(name: 'completed_jobs', defaultValue: 0)
  int get completedJobs;

  /// Create a copy of ApplicantDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplicantDetailsImplCopyWith<_$ApplicantDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApplicationResponse _$ApplicationResponseFromJson(Map<String, dynamic> json) {
  return _ApplicationResponse.fromJson(json);
}

/// @nodoc
mixin _$ApplicationResponse {
  @JsonKey(name: 'skills_met')
  List<String> get skillsMet => throw _privateConstructorUsedError;
  @JsonKey(name: 'optional_skills_met')
  List<String> get optionalSkillsMet => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;

  /// Serializes this ApplicationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApplicationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApplicationResponseCopyWith<ApplicationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicationResponseCopyWith<$Res> {
  factory $ApplicationResponseCopyWith(
          ApplicationResponse value, $Res Function(ApplicationResponse) then) =
      _$ApplicationResponseCopyWithImpl<$Res, ApplicationResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'skills_met') List<String> skillsMet,
      @JsonKey(name: 'optional_skills_met') List<String> optionalSkillsMet,
      String notes});
}

/// @nodoc
class _$ApplicationResponseCopyWithImpl<$Res, $Val extends ApplicationResponse>
    implements $ApplicationResponseCopyWith<$Res> {
  _$ApplicationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApplicationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skillsMet = null,
    Object? optionalSkillsMet = null,
    Object? notes = null,
  }) {
    return _then(_value.copyWith(
      skillsMet: null == skillsMet
          ? _value.skillsMet
          : skillsMet // ignore: cast_nullable_to_non_nullable
              as List<String>,
      optionalSkillsMet: null == optionalSkillsMet
          ? _value.optionalSkillsMet
          : optionalSkillsMet // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApplicationResponseImplCopyWith<$Res>
    implements $ApplicationResponseCopyWith<$Res> {
  factory _$$ApplicationResponseImplCopyWith(_$ApplicationResponseImpl value,
          $Res Function(_$ApplicationResponseImpl) then) =
      __$$ApplicationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'skills_met') List<String> skillsMet,
      @JsonKey(name: 'optional_skills_met') List<String> optionalSkillsMet,
      String notes});
}

/// @nodoc
class __$$ApplicationResponseImplCopyWithImpl<$Res>
    extends _$ApplicationResponseCopyWithImpl<$Res, _$ApplicationResponseImpl>
    implements _$$ApplicationResponseImplCopyWith<$Res> {
  __$$ApplicationResponseImplCopyWithImpl(_$ApplicationResponseImpl _value,
      $Res Function(_$ApplicationResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApplicationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skillsMet = null,
    Object? optionalSkillsMet = null,
    Object? notes = null,
  }) {
    return _then(_$ApplicationResponseImpl(
      skillsMet: null == skillsMet
          ? _value._skillsMet
          : skillsMet // ignore: cast_nullable_to_non_nullable
              as List<String>,
      optionalSkillsMet: null == optionalSkillsMet
          ? _value._optionalSkillsMet
          : optionalSkillsMet // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApplicationResponseImpl implements _ApplicationResponse {
  const _$ApplicationResponseImpl(
      {@JsonKey(name: 'skills_met') required final List<String> skillsMet,
      @JsonKey(name: 'optional_skills_met')
      required final List<String> optionalSkillsMet,
      required this.notes})
      : _skillsMet = skillsMet,
        _optionalSkillsMet = optionalSkillsMet;

  factory _$ApplicationResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplicationResponseImplFromJson(json);

  final List<String> _skillsMet;
  @override
  @JsonKey(name: 'skills_met')
  List<String> get skillsMet {
    if (_skillsMet is EqualUnmodifiableListView) return _skillsMet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skillsMet);
  }

  final List<String> _optionalSkillsMet;
  @override
  @JsonKey(name: 'optional_skills_met')
  List<String> get optionalSkillsMet {
    if (_optionalSkillsMet is EqualUnmodifiableListView)
      return _optionalSkillsMet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_optionalSkillsMet);
  }

  @override
  final String notes;

  @override
  String toString() {
    return 'ApplicationResponse(skillsMet: $skillsMet, optionalSkillsMet: $optionalSkillsMet, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplicationResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._skillsMet, _skillsMet) &&
            const DeepCollectionEquality()
                .equals(other._optionalSkillsMet, _optionalSkillsMet) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_skillsMet),
      const DeepCollectionEquality().hash(_optionalSkillsMet),
      notes);

  /// Create a copy of ApplicationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplicationResponseImplCopyWith<_$ApplicationResponseImpl> get copyWith =>
      __$$ApplicationResponseImplCopyWithImpl<_$ApplicationResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplicationResponseImplToJson(
      this,
    );
  }
}

abstract class _ApplicationResponse implements ApplicationResponse {
  const factory _ApplicationResponse(
      {@JsonKey(name: 'skills_met') required final List<String> skillsMet,
      @JsonKey(name: 'optional_skills_met')
      required final List<String> optionalSkillsMet,
      required final String notes}) = _$ApplicationResponseImpl;

  factory _ApplicationResponse.fromJson(Map<String, dynamic> json) =
      _$ApplicationResponseImpl.fromJson;

  @override
  @JsonKey(name: 'skills_met')
  List<String> get skillsMet;
  @override
  @JsonKey(name: 'optional_skills_met')
  List<String> get optionalSkillsMet;
  @override
  String get notes;

  /// Create a copy of ApplicationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplicationResponseImplCopyWith<_$ApplicationResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchStats _$MatchStatsFromJson(Map<String, dynamic> json) {
  return _MatchStats.fromJson(json);
}

/// @nodoc
mixin _$MatchStats {
  @JsonKey(name: 'required_match')
  String get requiredMatch => throw _privateConstructorUsedError;
  @JsonKey(name: 'optional_match')
  int get optionalMatch => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;

  /// Serializes this MatchStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchStatsCopyWith<MatchStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchStatsCopyWith<$Res> {
  factory $MatchStatsCopyWith(
          MatchStats value, $Res Function(MatchStats) then) =
      _$MatchStatsCopyWithImpl<$Res, MatchStats>;
  @useResult
  $Res call(
      {@JsonKey(name: 'required_match') String requiredMatch,
      @JsonKey(name: 'optional_match') int optionalMatch,
      double percentage});
}

/// @nodoc
class _$MatchStatsCopyWithImpl<$Res, $Val extends MatchStats>
    implements $MatchStatsCopyWith<$Res> {
  _$MatchStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requiredMatch = null,
    Object? optionalMatch = null,
    Object? percentage = null,
  }) {
    return _then(_value.copyWith(
      requiredMatch: null == requiredMatch
          ? _value.requiredMatch
          : requiredMatch // ignore: cast_nullable_to_non_nullable
              as String,
      optionalMatch: null == optionalMatch
          ? _value.optionalMatch
          : optionalMatch // ignore: cast_nullable_to_non_nullable
              as int,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchStatsImplCopyWith<$Res>
    implements $MatchStatsCopyWith<$Res> {
  factory _$$MatchStatsImplCopyWith(
          _$MatchStatsImpl value, $Res Function(_$MatchStatsImpl) then) =
      __$$MatchStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'required_match') String requiredMatch,
      @JsonKey(name: 'optional_match') int optionalMatch,
      double percentage});
}

/// @nodoc
class __$$MatchStatsImplCopyWithImpl<$Res>
    extends _$MatchStatsCopyWithImpl<$Res, _$MatchStatsImpl>
    implements _$$MatchStatsImplCopyWith<$Res> {
  __$$MatchStatsImplCopyWithImpl(
      _$MatchStatsImpl _value, $Res Function(_$MatchStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requiredMatch = null,
    Object? optionalMatch = null,
    Object? percentage = null,
  }) {
    return _then(_$MatchStatsImpl(
      requiredMatch: null == requiredMatch
          ? _value.requiredMatch
          : requiredMatch // ignore: cast_nullable_to_non_nullable
              as String,
      optionalMatch: null == optionalMatch
          ? _value.optionalMatch
          : optionalMatch // ignore: cast_nullable_to_non_nullable
              as int,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchStatsImpl implements _MatchStats {
  const _$MatchStatsImpl(
      {@JsonKey(name: 'required_match') required this.requiredMatch,
      @JsonKey(name: 'optional_match') required this.optionalMatch,
      required this.percentage});

  factory _$MatchStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchStatsImplFromJson(json);

  @override
  @JsonKey(name: 'required_match')
  final String requiredMatch;
  @override
  @JsonKey(name: 'optional_match')
  final int optionalMatch;
  @override
  final double percentage;

  @override
  String toString() {
    return 'MatchStats(requiredMatch: $requiredMatch, optionalMatch: $optionalMatch, percentage: $percentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchStatsImpl &&
            (identical(other.requiredMatch, requiredMatch) ||
                other.requiredMatch == requiredMatch) &&
            (identical(other.optionalMatch, optionalMatch) ||
                other.optionalMatch == optionalMatch) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, requiredMatch, optionalMatch, percentage);

  /// Create a copy of MatchStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchStatsImplCopyWith<_$MatchStatsImpl> get copyWith =>
      __$$MatchStatsImplCopyWithImpl<_$MatchStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchStatsImplToJson(
      this,
    );
  }
}

abstract class _MatchStats implements MatchStats {
  const factory _MatchStats(
      {@JsonKey(name: 'required_match') required final String requiredMatch,
      @JsonKey(name: 'optional_match') required final int optionalMatch,
      required final double percentage}) = _$MatchStatsImpl;

  factory _MatchStats.fromJson(Map<String, dynamic> json) =
      _$MatchStatsImpl.fromJson;

  @override
  @JsonKey(name: 'required_match')
  String get requiredMatch;
  @override
  @JsonKey(name: 'optional_match')
  int get optionalMatch;
  @override
  double get percentage;

  /// Create a copy of MatchStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchStatsImplCopyWith<_$MatchStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JobCompletion _$JobCompletionFromJson(Map<String, dynamic> json) {
  return _JobCompletion.fromJson(json);
}

/// @nodoc
mixin _$JobCompletion {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'employer_confirmed')
  bool get employerConfirmed => throw _privateConstructorUsedError;
  @JsonKey(name: 'worker_confirmed')
  bool get workerConfirmed => throw _privateConstructorUsedError;
  @JsonKey(name: 'employer_confirmed_at')
  DateTime? get employerConfirmedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'worker_confirmed_at')
  DateTime? get workerConfirmedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'actual_start_date')
  DateTime? get actualStartDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'actual_end_date')
  DateTime? get actualEndDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'final_payment')
  int? get finalPayment => throw _privateConstructorUsedError;
  @JsonKey(name: 'completion_notes')
  String? get completionNotes => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_mutually_confirmed')
  bool get isMutuallyConfirmed => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_confirm')
  Map<String, dynamic>? get canConfirm => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this JobCompletion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JobCompletion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JobCompletionCopyWith<JobCompletion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobCompletionCopyWith<$Res> {
  factory $JobCompletionCopyWith(
          JobCompletion value, $Res Function(JobCompletion) then) =
      _$JobCompletionCopyWithImpl<$Res, JobCompletion>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'employer_confirmed') bool employerConfirmed,
      @JsonKey(name: 'worker_confirmed') bool workerConfirmed,
      @JsonKey(name: 'employer_confirmed_at') DateTime? employerConfirmedAt,
      @JsonKey(name: 'worker_confirmed_at') DateTime? workerConfirmedAt,
      @JsonKey(name: 'actual_start_date') DateTime? actualStartDate,
      @JsonKey(name: 'actual_end_date') DateTime? actualEndDate,
      @JsonKey(name: 'final_payment') int? finalPayment,
      @JsonKey(name: 'completion_notes') String? completionNotes,
      @JsonKey(name: 'is_mutually_confirmed') bool isMutuallyConfirmed,
      @JsonKey(name: 'can_confirm') Map<String, dynamic>? canConfirm,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$JobCompletionCopyWithImpl<$Res, $Val extends JobCompletion>
    implements $JobCompletionCopyWith<$Res> {
  _$JobCompletionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JobCompletion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employerConfirmed = null,
    Object? workerConfirmed = null,
    Object? employerConfirmedAt = freezed,
    Object? workerConfirmedAt = freezed,
    Object? actualStartDate = freezed,
    Object? actualEndDate = freezed,
    Object? finalPayment = freezed,
    Object? completionNotes = freezed,
    Object? isMutuallyConfirmed = null,
    Object? canConfirm = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      employerConfirmed: null == employerConfirmed
          ? _value.employerConfirmed
          : employerConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
      workerConfirmed: null == workerConfirmed
          ? _value.workerConfirmed
          : workerConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
      employerConfirmedAt: freezed == employerConfirmedAt
          ? _value.employerConfirmedAt
          : employerConfirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      workerConfirmedAt: freezed == workerConfirmedAt
          ? _value.workerConfirmedAt
          : workerConfirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualStartDate: freezed == actualStartDate
          ? _value.actualStartDate
          : actualStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualEndDate: freezed == actualEndDate
          ? _value.actualEndDate
          : actualEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      finalPayment: freezed == finalPayment
          ? _value.finalPayment
          : finalPayment // ignore: cast_nullable_to_non_nullable
              as int?,
      completionNotes: freezed == completionNotes
          ? _value.completionNotes
          : completionNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      isMutuallyConfirmed: null == isMutuallyConfirmed
          ? _value.isMutuallyConfirmed
          : isMutuallyConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
      canConfirm: freezed == canConfirm
          ? _value.canConfirm
          : canConfirm // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JobCompletionImplCopyWith<$Res>
    implements $JobCompletionCopyWith<$Res> {
  factory _$$JobCompletionImplCopyWith(
          _$JobCompletionImpl value, $Res Function(_$JobCompletionImpl) then) =
      __$$JobCompletionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'employer_confirmed') bool employerConfirmed,
      @JsonKey(name: 'worker_confirmed') bool workerConfirmed,
      @JsonKey(name: 'employer_confirmed_at') DateTime? employerConfirmedAt,
      @JsonKey(name: 'worker_confirmed_at') DateTime? workerConfirmedAt,
      @JsonKey(name: 'actual_start_date') DateTime? actualStartDate,
      @JsonKey(name: 'actual_end_date') DateTime? actualEndDate,
      @JsonKey(name: 'final_payment') int? finalPayment,
      @JsonKey(name: 'completion_notes') String? completionNotes,
      @JsonKey(name: 'is_mutually_confirmed') bool isMutuallyConfirmed,
      @JsonKey(name: 'can_confirm') Map<String, dynamic>? canConfirm,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$JobCompletionImplCopyWithImpl<$Res>
    extends _$JobCompletionCopyWithImpl<$Res, _$JobCompletionImpl>
    implements _$$JobCompletionImplCopyWith<$Res> {
  __$$JobCompletionImplCopyWithImpl(
      _$JobCompletionImpl _value, $Res Function(_$JobCompletionImpl) _then)
      : super(_value, _then);

  /// Create a copy of JobCompletion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employerConfirmed = null,
    Object? workerConfirmed = null,
    Object? employerConfirmedAt = freezed,
    Object? workerConfirmedAt = freezed,
    Object? actualStartDate = freezed,
    Object? actualEndDate = freezed,
    Object? finalPayment = freezed,
    Object? completionNotes = freezed,
    Object? isMutuallyConfirmed = null,
    Object? canConfirm = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$JobCompletionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      employerConfirmed: null == employerConfirmed
          ? _value.employerConfirmed
          : employerConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
      workerConfirmed: null == workerConfirmed
          ? _value.workerConfirmed
          : workerConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
      employerConfirmedAt: freezed == employerConfirmedAt
          ? _value.employerConfirmedAt
          : employerConfirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      workerConfirmedAt: freezed == workerConfirmedAt
          ? _value.workerConfirmedAt
          : workerConfirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualStartDate: freezed == actualStartDate
          ? _value.actualStartDate
          : actualStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualEndDate: freezed == actualEndDate
          ? _value.actualEndDate
          : actualEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      finalPayment: freezed == finalPayment
          ? _value.finalPayment
          : finalPayment // ignore: cast_nullable_to_non_nullable
              as int?,
      completionNotes: freezed == completionNotes
          ? _value.completionNotes
          : completionNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      isMutuallyConfirmed: null == isMutuallyConfirmed
          ? _value.isMutuallyConfirmed
          : isMutuallyConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
      canConfirm: freezed == canConfirm
          ? _value._canConfirm
          : canConfirm // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JobCompletionImpl implements _JobCompletion {
  const _$JobCompletionImpl(
      {required this.id,
      @JsonKey(name: 'employer_confirmed') required this.employerConfirmed,
      @JsonKey(name: 'worker_confirmed') required this.workerConfirmed,
      @JsonKey(name: 'employer_confirmed_at') this.employerConfirmedAt,
      @JsonKey(name: 'worker_confirmed_at') this.workerConfirmedAt,
      @JsonKey(name: 'actual_start_date') this.actualStartDate,
      @JsonKey(name: 'actual_end_date') this.actualEndDate,
      @JsonKey(name: 'final_payment') this.finalPayment,
      @JsonKey(name: 'completion_notes') this.completionNotes,
      @JsonKey(name: 'is_mutually_confirmed') required this.isMutuallyConfirmed,
      @JsonKey(name: 'can_confirm') final Map<String, dynamic>? canConfirm,
      @JsonKey(name: 'created_at') required this.createdAt})
      : _canConfirm = canConfirm;

  factory _$JobCompletionImpl.fromJson(Map<String, dynamic> json) =>
      _$$JobCompletionImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'employer_confirmed')
  final bool employerConfirmed;
  @override
  @JsonKey(name: 'worker_confirmed')
  final bool workerConfirmed;
  @override
  @JsonKey(name: 'employer_confirmed_at')
  final DateTime? employerConfirmedAt;
  @override
  @JsonKey(name: 'worker_confirmed_at')
  final DateTime? workerConfirmedAt;
  @override
  @JsonKey(name: 'actual_start_date')
  final DateTime? actualStartDate;
  @override
  @JsonKey(name: 'actual_end_date')
  final DateTime? actualEndDate;
  @override
  @JsonKey(name: 'final_payment')
  final int? finalPayment;
  @override
  @JsonKey(name: 'completion_notes')
  final String? completionNotes;
  @override
  @JsonKey(name: 'is_mutually_confirmed')
  final bool isMutuallyConfirmed;
  final Map<String, dynamic>? _canConfirm;
  @override
  @JsonKey(name: 'can_confirm')
  Map<String, dynamic>? get canConfirm {
    final value = _canConfirm;
    if (value == null) return null;
    if (_canConfirm is EqualUnmodifiableMapView) return _canConfirm;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'JobCompletion(id: $id, employerConfirmed: $employerConfirmed, workerConfirmed: $workerConfirmed, employerConfirmedAt: $employerConfirmedAt, workerConfirmedAt: $workerConfirmedAt, actualStartDate: $actualStartDate, actualEndDate: $actualEndDate, finalPayment: $finalPayment, completionNotes: $completionNotes, isMutuallyConfirmed: $isMutuallyConfirmed, canConfirm: $canConfirm, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JobCompletionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employerConfirmed, employerConfirmed) ||
                other.employerConfirmed == employerConfirmed) &&
            (identical(other.workerConfirmed, workerConfirmed) ||
                other.workerConfirmed == workerConfirmed) &&
            (identical(other.employerConfirmedAt, employerConfirmedAt) ||
                other.employerConfirmedAt == employerConfirmedAt) &&
            (identical(other.workerConfirmedAt, workerConfirmedAt) ||
                other.workerConfirmedAt == workerConfirmedAt) &&
            (identical(other.actualStartDate, actualStartDate) ||
                other.actualStartDate == actualStartDate) &&
            (identical(other.actualEndDate, actualEndDate) ||
                other.actualEndDate == actualEndDate) &&
            (identical(other.finalPayment, finalPayment) ||
                other.finalPayment == finalPayment) &&
            (identical(other.completionNotes, completionNotes) ||
                other.completionNotes == completionNotes) &&
            (identical(other.isMutuallyConfirmed, isMutuallyConfirmed) ||
                other.isMutuallyConfirmed == isMutuallyConfirmed) &&
            const DeepCollectionEquality()
                .equals(other._canConfirm, _canConfirm) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      employerConfirmed,
      workerConfirmed,
      employerConfirmedAt,
      workerConfirmedAt,
      actualStartDate,
      actualEndDate,
      finalPayment,
      completionNotes,
      isMutuallyConfirmed,
      const DeepCollectionEquality().hash(_canConfirm),
      createdAt);

  /// Create a copy of JobCompletion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JobCompletionImplCopyWith<_$JobCompletionImpl> get copyWith =>
      __$$JobCompletionImplCopyWithImpl<_$JobCompletionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JobCompletionImplToJson(
      this,
    );
  }
}

abstract class _JobCompletion implements JobCompletion {
  const factory _JobCompletion(
      {required final int id,
      @JsonKey(name: 'employer_confirmed')
      required final bool employerConfirmed,
      @JsonKey(name: 'worker_confirmed') required final bool workerConfirmed,
      @JsonKey(name: 'employer_confirmed_at')
      final DateTime? employerConfirmedAt,
      @JsonKey(name: 'worker_confirmed_at') final DateTime? workerConfirmedAt,
      @JsonKey(name: 'actual_start_date') final DateTime? actualStartDate,
      @JsonKey(name: 'actual_end_date') final DateTime? actualEndDate,
      @JsonKey(name: 'final_payment') final int? finalPayment,
      @JsonKey(name: 'completion_notes') final String? completionNotes,
      @JsonKey(name: 'is_mutually_confirmed')
      required final bool isMutuallyConfirmed,
      @JsonKey(name: 'can_confirm') final Map<String, dynamic>? canConfirm,
      @JsonKey(name: 'created_at')
      required final DateTime createdAt}) = _$JobCompletionImpl;

  factory _JobCompletion.fromJson(Map<String, dynamic> json) =
      _$JobCompletionImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'employer_confirmed')
  bool get employerConfirmed;
  @override
  @JsonKey(name: 'worker_confirmed')
  bool get workerConfirmed;
  @override
  @JsonKey(name: 'employer_confirmed_at')
  DateTime? get employerConfirmedAt;
  @override
  @JsonKey(name: 'worker_confirmed_at')
  DateTime? get workerConfirmedAt;
  @override
  @JsonKey(name: 'actual_start_date')
  DateTime? get actualStartDate;
  @override
  @JsonKey(name: 'actual_end_date')
  DateTime? get actualEndDate;
  @override
  @JsonKey(name: 'final_payment')
  int? get finalPayment;
  @override
  @JsonKey(name: 'completion_notes')
  String? get completionNotes;
  @override
  @JsonKey(name: 'is_mutually_confirmed')
  bool get isMutuallyConfirmed;
  @override
  @JsonKey(name: 'can_confirm')
  Map<String, dynamic>? get canConfirm;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of JobCompletion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JobCompletionImplCopyWith<_$JobCompletionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProfileReviewer _$ProfileReviewerFromJson(Map<String, dynamic> json) {
  return _ProfileReviewer.fromJson(json);
}

/// @nodoc
mixin _$ProfileReviewer {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;

  /// Serializes this ProfileReviewer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileReviewer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileReviewerCopyWith<ProfileReviewer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileReviewerCopyWith<$Res> {
  factory $ProfileReviewerCopyWith(
          ProfileReviewer value, $Res Function(ProfileReviewer) then) =
      _$ProfileReviewerCopyWithImpl<$Res, ProfileReviewer>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'first_name') String firstName,
      @JsonKey(name: 'last_name') String lastName,
      String email});
}

/// @nodoc
class _$ProfileReviewerCopyWithImpl<$Res, $Val extends ProfileReviewer>
    implements $ProfileReviewerCopyWith<$Res> {
  _$ProfileReviewerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileReviewer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileReviewerImplCopyWith<$Res>
    implements $ProfileReviewerCopyWith<$Res> {
  factory _$$ProfileReviewerImplCopyWith(_$ProfileReviewerImpl value,
          $Res Function(_$ProfileReviewerImpl) then) =
      __$$ProfileReviewerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'first_name') String firstName,
      @JsonKey(name: 'last_name') String lastName,
      String email});
}

/// @nodoc
class __$$ProfileReviewerImplCopyWithImpl<$Res>
    extends _$ProfileReviewerCopyWithImpl<$Res, _$ProfileReviewerImpl>
    implements _$$ProfileReviewerImplCopyWith<$Res> {
  __$$ProfileReviewerImplCopyWithImpl(
      _$ProfileReviewerImpl _value, $Res Function(_$ProfileReviewerImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileReviewer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
  }) {
    return _then(_$ProfileReviewerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileReviewerImpl
    with DiagnosticableTreeMixin
    implements _ProfileReviewer {
  const _$ProfileReviewerImpl(
      {required this.id,
      @JsonKey(name: 'first_name') required this.firstName,
      @JsonKey(name: 'last_name') required this.lastName,
      required this.email});

  factory _$ProfileReviewerImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileReviewerImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'first_name')
  final String firstName;
  @override
  @JsonKey(name: 'last_name')
  final String lastName;
  @override
  final String email;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfileReviewer(id: $id, firstName: $firstName, lastName: $lastName, email: $email)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileReviewer'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('firstName', firstName))
      ..add(DiagnosticsProperty('lastName', lastName))
      ..add(DiagnosticsProperty('email', email));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileReviewerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, firstName, lastName, email);

  /// Create a copy of ProfileReviewer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileReviewerImplCopyWith<_$ProfileReviewerImpl> get copyWith =>
      __$$ProfileReviewerImplCopyWithImpl<_$ProfileReviewerImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileReviewerImplToJson(
      this,
    );
  }
}

abstract class _ProfileReviewer implements ProfileReviewer {
  const factory _ProfileReviewer(
      {required final int id,
      @JsonKey(name: 'first_name') required final String firstName,
      @JsonKey(name: 'last_name') required final String lastName,
      required final String email}) = _$ProfileReviewerImpl;

  factory _ProfileReviewer.fromJson(Map<String, dynamic> json) =
      _$ProfileReviewerImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'first_name')
  String get firstName;
  @override
  @JsonKey(name: 'last_name')
  String get lastName;
  @override
  String get email;

  /// Create a copy of ProfileReviewer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileReviewerImplCopyWith<_$ProfileReviewerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfileReview _$ProfileReviewFromJson(Map<String, dynamic> json) {
  return _ProfileReview.fromJson(json);
}

/// @nodoc
mixin _$ProfileReview {
  int get id => throw _privateConstructorUsedError;
  ProfileReviewer get reviewer => throw _privateConstructorUsedError;
  @JsonKey(name: 'overall_rating')
  int get overallRating => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  int? get job => throw _privateConstructorUsedError;

  /// Serializes this ProfileReview to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileReviewCopyWith<ProfileReview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileReviewCopyWith<$Res> {
  factory $ProfileReviewCopyWith(
          ProfileReview value, $Res Function(ProfileReview) then) =
      _$ProfileReviewCopyWithImpl<$Res, ProfileReview>;
  @useResult
  $Res call(
      {int id,
      ProfileReviewer reviewer,
      @JsonKey(name: 'overall_rating') int overallRating,
      String comment,
      @JsonKey(name: 'created_at') DateTime createdAt,
      int? job});

  $ProfileReviewerCopyWith<$Res> get reviewer;
}

/// @nodoc
class _$ProfileReviewCopyWithImpl<$Res, $Val extends ProfileReview>
    implements $ProfileReviewCopyWith<$Res> {
  _$ProfileReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reviewer = null,
    Object? overallRating = null,
    Object? comment = null,
    Object? createdAt = null,
    Object? job = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      reviewer: null == reviewer
          ? _value.reviewer
          : reviewer // ignore: cast_nullable_to_non_nullable
              as ProfileReviewer,
      overallRating: null == overallRating
          ? _value.overallRating
          : overallRating // ignore: cast_nullable_to_non_nullable
              as int,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      job: freezed == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  /// Create a copy of ProfileReview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfileReviewerCopyWith<$Res> get reviewer {
    return $ProfileReviewerCopyWith<$Res>(_value.reviewer, (value) {
      return _then(_value.copyWith(reviewer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileReviewImplCopyWith<$Res>
    implements $ProfileReviewCopyWith<$Res> {
  factory _$$ProfileReviewImplCopyWith(
          _$ProfileReviewImpl value, $Res Function(_$ProfileReviewImpl) then) =
      __$$ProfileReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      ProfileReviewer reviewer,
      @JsonKey(name: 'overall_rating') int overallRating,
      String comment,
      @JsonKey(name: 'created_at') DateTime createdAt,
      int? job});

  @override
  $ProfileReviewerCopyWith<$Res> get reviewer;
}

/// @nodoc
class __$$ProfileReviewImplCopyWithImpl<$Res>
    extends _$ProfileReviewCopyWithImpl<$Res, _$ProfileReviewImpl>
    implements _$$ProfileReviewImplCopyWith<$Res> {
  __$$ProfileReviewImplCopyWithImpl(
      _$ProfileReviewImpl _value, $Res Function(_$ProfileReviewImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reviewer = null,
    Object? overallRating = null,
    Object? comment = null,
    Object? createdAt = null,
    Object? job = freezed,
  }) {
    return _then(_$ProfileReviewImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      reviewer: null == reviewer
          ? _value.reviewer
          : reviewer // ignore: cast_nullable_to_non_nullable
              as ProfileReviewer,
      overallRating: null == overallRating
          ? _value.overallRating
          : overallRating // ignore: cast_nullable_to_non_nullable
              as int,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      job: freezed == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileReviewImpl extends _ProfileReview with DiagnosticableTreeMixin {
  const _$ProfileReviewImpl(
      {required this.id,
      required this.reviewer,
      @JsonKey(name: 'overall_rating') required this.overallRating,
      required this.comment,
      @JsonKey(name: 'created_at') required this.createdAt,
      this.job})
      : super._();

  factory _$ProfileReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileReviewImplFromJson(json);

  @override
  final int id;
  @override
  final ProfileReviewer reviewer;
  @override
  @JsonKey(name: 'overall_rating')
  final int overallRating;
  @override
  final String comment;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  final int? job;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfileReview(id: $id, reviewer: $reviewer, overallRating: $overallRating, comment: $comment, createdAt: $createdAt, job: $job)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileReview'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('reviewer', reviewer))
      ..add(DiagnosticsProperty('overallRating', overallRating))
      ..add(DiagnosticsProperty('comment', comment))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('job', job));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileReviewImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.reviewer, reviewer) ||
                other.reviewer == reviewer) &&
            (identical(other.overallRating, overallRating) ||
                other.overallRating == overallRating) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.job, job) || other.job == job));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, reviewer, overallRating, comment, createdAt, job);

  /// Create a copy of ProfileReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileReviewImplCopyWith<_$ProfileReviewImpl> get copyWith =>
      __$$ProfileReviewImplCopyWithImpl<_$ProfileReviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileReviewImplToJson(
      this,
    );
  }
}

abstract class _ProfileReview extends ProfileReview {
  const factory _ProfileReview(
      {required final int id,
      required final ProfileReviewer reviewer,
      @JsonKey(name: 'overall_rating') required final int overallRating,
      required final String comment,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      final int? job}) = _$ProfileReviewImpl;
  const _ProfileReview._() : super._();

  factory _ProfileReview.fromJson(Map<String, dynamic> json) =
      _$ProfileReviewImpl.fromJson;

  @override
  int get id;
  @override
  ProfileReviewer get reviewer;
  @override
  @JsonKey(name: 'overall_rating')
  int get overallRating;
  @override
  String get comment;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  int? get job;

  /// Create a copy of ProfileReview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileReviewImplCopyWith<_$ProfileReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReviewerInfo _$ReviewerInfoFromJson(Map<String, dynamic> json) {
  return _ReviewerInfo.fromJson(json);
}

/// @nodoc
mixin _$ReviewerInfo {
  String get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'verified_level')
  int? get verifiedLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'trust_level')
  String? get trustLevel => throw _privateConstructorUsedError;

  /// Serializes this ReviewerInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewerInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewerInfoCopyWith<ReviewerInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewerInfoCopyWith<$Res> {
  factory $ReviewerInfoCopyWith(
          ReviewerInfo value, $Res Function(ReviewerInfo) then) =
      _$ReviewerInfoCopyWithImpl<$Res, ReviewerInfo>;
  @useResult
  $Res call(
      {String role,
      @JsonKey(name: 'verified_level') int? verifiedLevel,
      @JsonKey(name: 'trust_level') String? trustLevel});
}

/// @nodoc
class _$ReviewerInfoCopyWithImpl<$Res, $Val extends ReviewerInfo>
    implements $ReviewerInfoCopyWith<$Res> {
  _$ReviewerInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewerInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? role = null,
    Object? verifiedLevel = freezed,
    Object? trustLevel = freezed,
  }) {
    return _then(_value.copyWith(
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      verifiedLevel: freezed == verifiedLevel
          ? _value.verifiedLevel
          : verifiedLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      trustLevel: freezed == trustLevel
          ? _value.trustLevel
          : trustLevel // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewerInfoImplCopyWith<$Res>
    implements $ReviewerInfoCopyWith<$Res> {
  factory _$$ReviewerInfoImplCopyWith(
          _$ReviewerInfoImpl value, $Res Function(_$ReviewerInfoImpl) then) =
      __$$ReviewerInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String role,
      @JsonKey(name: 'verified_level') int? verifiedLevel,
      @JsonKey(name: 'trust_level') String? trustLevel});
}

/// @nodoc
class __$$ReviewerInfoImplCopyWithImpl<$Res>
    extends _$ReviewerInfoCopyWithImpl<$Res, _$ReviewerInfoImpl>
    implements _$$ReviewerInfoImplCopyWith<$Res> {
  __$$ReviewerInfoImplCopyWithImpl(
      _$ReviewerInfoImpl _value, $Res Function(_$ReviewerInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewerInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? role = null,
    Object? verifiedLevel = freezed,
    Object? trustLevel = freezed,
  }) {
    return _then(_$ReviewerInfoImpl(
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      verifiedLevel: freezed == verifiedLevel
          ? _value.verifiedLevel
          : verifiedLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      trustLevel: freezed == trustLevel
          ? _value.trustLevel
          : trustLevel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewerInfoImpl with DiagnosticableTreeMixin implements _ReviewerInfo {
  const _$ReviewerInfoImpl(
      {required this.role,
      @JsonKey(name: 'verified_level') this.verifiedLevel,
      @JsonKey(name: 'trust_level') this.trustLevel});

  factory _$ReviewerInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewerInfoImplFromJson(json);

  @override
  final String role;
  @override
  @JsonKey(name: 'verified_level')
  final int? verifiedLevel;
  @override
  @JsonKey(name: 'trust_level')
  final String? trustLevel;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReviewerInfo(role: $role, verifiedLevel: $verifiedLevel, trustLevel: $trustLevel)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReviewerInfo'))
      ..add(DiagnosticsProperty('role', role))
      ..add(DiagnosticsProperty('verifiedLevel', verifiedLevel))
      ..add(DiagnosticsProperty('trustLevel', trustLevel));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewerInfoImpl &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.verifiedLevel, verifiedLevel) ||
                other.verifiedLevel == verifiedLevel) &&
            (identical(other.trustLevel, trustLevel) ||
                other.trustLevel == trustLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, role, verifiedLevel, trustLevel);

  /// Create a copy of ReviewerInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewerInfoImplCopyWith<_$ReviewerInfoImpl> get copyWith =>
      __$$ReviewerInfoImplCopyWithImpl<_$ReviewerInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewerInfoImplToJson(
      this,
    );
  }
}

abstract class _ReviewerInfo implements ReviewerInfo {
  const factory _ReviewerInfo(
          {required final String role,
          @JsonKey(name: 'verified_level') final int? verifiedLevel,
          @JsonKey(name: 'trust_level') final String? trustLevel}) =
      _$ReviewerInfoImpl;

  factory _ReviewerInfo.fromJson(Map<String, dynamic> json) =
      _$ReviewerInfoImpl.fromJson;

  @override
  String get role;
  @override
  @JsonKey(name: 'verified_level')
  int? get verifiedLevel;
  @override
  @JsonKey(name: 'trust_level')
  String? get trustLevel;

  /// Create a copy of ReviewerInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewerInfoImplCopyWith<_$ReviewerInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReviewReply _$ReviewReplyFromJson(Map<String, dynamic> json) {
  return _ReviewReply.fromJson(json);
}

/// @nodoc
mixin _$ReviewReply {
  @JsonKey(name: 'reply_text')
  String get replyText => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ReviewReply to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewReplyCopyWith<ReviewReply> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewReplyCopyWith<$Res> {
  factory $ReviewReplyCopyWith(
          ReviewReply value, $Res Function(ReviewReply) then) =
      _$ReviewReplyCopyWithImpl<$Res, ReviewReply>;
  @useResult
  $Res call(
      {@JsonKey(name: 'reply_text') String replyText,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$ReviewReplyCopyWithImpl<$Res, $Val extends ReviewReply>
    implements $ReviewReplyCopyWith<$Res> {
  _$ReviewReplyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewReply
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replyText = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      replyText: null == replyText
          ? _value.replyText
          : replyText // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewReplyImplCopyWith<$Res>
    implements $ReviewReplyCopyWith<$Res> {
  factory _$$ReviewReplyImplCopyWith(
          _$ReviewReplyImpl value, $Res Function(_$ReviewReplyImpl) then) =
      __$$ReviewReplyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'reply_text') String replyText,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$ReviewReplyImplCopyWithImpl<$Res>
    extends _$ReviewReplyCopyWithImpl<$Res, _$ReviewReplyImpl>
    implements _$$ReviewReplyImplCopyWith<$Res> {
  __$$ReviewReplyImplCopyWithImpl(
      _$ReviewReplyImpl _value, $Res Function(_$ReviewReplyImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewReply
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replyText = null,
    Object? createdAt = null,
  }) {
    return _then(_$ReviewReplyImpl(
      replyText: null == replyText
          ? _value.replyText
          : replyText // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewReplyImpl extends _ReviewReply with DiagnosticableTreeMixin {
  const _$ReviewReplyImpl(
      {@JsonKey(name: 'reply_text') required this.replyText,
      @JsonKey(name: 'created_at') required this.createdAt})
      : super._();

  factory _$ReviewReplyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewReplyImplFromJson(json);

  @override
  @JsonKey(name: 'reply_text')
  final String replyText;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReviewReply(replyText: $replyText, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReviewReply'))
      ..add(DiagnosticsProperty('replyText', replyText))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewReplyImpl &&
            (identical(other.replyText, replyText) ||
                other.replyText == replyText) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, replyText, createdAt);

  /// Create a copy of ReviewReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewReplyImplCopyWith<_$ReviewReplyImpl> get copyWith =>
      __$$ReviewReplyImplCopyWithImpl<_$ReviewReplyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewReplyImplToJson(
      this,
    );
  }
}

abstract class _ReviewReply extends ReviewReply {
  const factory _ReviewReply(
          {@JsonKey(name: 'reply_text') required final String replyText,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$ReviewReplyImpl;
  const _ReviewReply._() : super._();

  factory _ReviewReply.fromJson(Map<String, dynamic> json) =
      _$ReviewReplyImpl.fromJson;

  @override
  @JsonKey(name: 'reply_text')
  String get replyText;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of ReviewReply
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewReplyImplCopyWith<_$ReviewReplyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DetailedReview _$DetailedReviewFromJson(Map<String, dynamic> json) {
  return _DetailedReview.fromJson(json);
}

/// @nodoc
mixin _$DetailedReview {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'review_type')
  String get reviewType => throw _privateConstructorUsedError;
  @JsonKey(name: 'overall_rating')
  int get overallRating => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_ratings')
  Map<String, dynamic>? get categoryRatings =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'work_complexity')
  String? get workComplexity => throw _privateConstructorUsedError;
  @JsonKey(name: 'complexity_display')
  String? get complexityDisplay => throw _privateConstructorUsedError;
  @JsonKey(name: 'would_work_again')
  bool? get wouldWorkAgain => throw _privateConstructorUsedError;
  @JsonKey(name: 'reviewer_info')
  ReviewerInfo get reviewerInfo => throw _privateConstructorUsedError;
  ReviewReply? get reply => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_ago')
  String get timeAgo => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this DetailedReview to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DetailedReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DetailedReviewCopyWith<DetailedReview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailedReviewCopyWith<$Res> {
  factory $DetailedReviewCopyWith(
          DetailedReview value, $Res Function(DetailedReview) then) =
      _$DetailedReviewCopyWithImpl<$Res, DetailedReview>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'review_type') String reviewType,
      @JsonKey(name: 'overall_rating') int overallRating,
      String comment,
      @JsonKey(name: 'category_ratings') Map<String, dynamic>? categoryRatings,
      @JsonKey(name: 'work_complexity') String? workComplexity,
      @JsonKey(name: 'complexity_display') String? complexityDisplay,
      @JsonKey(name: 'would_work_again') bool? wouldWorkAgain,
      @JsonKey(name: 'reviewer_info') ReviewerInfo reviewerInfo,
      ReviewReply? reply,
      @JsonKey(name: 'time_ago') String timeAgo,
      @JsonKey(name: 'created_at') DateTime createdAt});

  $ReviewerInfoCopyWith<$Res> get reviewerInfo;
  $ReviewReplyCopyWith<$Res>? get reply;
}

/// @nodoc
class _$DetailedReviewCopyWithImpl<$Res, $Val extends DetailedReview>
    implements $DetailedReviewCopyWith<$Res> {
  _$DetailedReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DetailedReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reviewType = null,
    Object? overallRating = null,
    Object? comment = null,
    Object? categoryRatings = freezed,
    Object? workComplexity = freezed,
    Object? complexityDisplay = freezed,
    Object? wouldWorkAgain = freezed,
    Object? reviewerInfo = null,
    Object? reply = freezed,
    Object? timeAgo = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      reviewType: null == reviewType
          ? _value.reviewType
          : reviewType // ignore: cast_nullable_to_non_nullable
              as String,
      overallRating: null == overallRating
          ? _value.overallRating
          : overallRating // ignore: cast_nullable_to_non_nullable
              as int,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      categoryRatings: freezed == categoryRatings
          ? _value.categoryRatings
          : categoryRatings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      workComplexity: freezed == workComplexity
          ? _value.workComplexity
          : workComplexity // ignore: cast_nullable_to_non_nullable
              as String?,
      complexityDisplay: freezed == complexityDisplay
          ? _value.complexityDisplay
          : complexityDisplay // ignore: cast_nullable_to_non_nullable
              as String?,
      wouldWorkAgain: freezed == wouldWorkAgain
          ? _value.wouldWorkAgain
          : wouldWorkAgain // ignore: cast_nullable_to_non_nullable
              as bool?,
      reviewerInfo: null == reviewerInfo
          ? _value.reviewerInfo
          : reviewerInfo // ignore: cast_nullable_to_non_nullable
              as ReviewerInfo,
      reply: freezed == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as ReviewReply?,
      timeAgo: null == timeAgo
          ? _value.timeAgo
          : timeAgo // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of DetailedReview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReviewerInfoCopyWith<$Res> get reviewerInfo {
    return $ReviewerInfoCopyWith<$Res>(_value.reviewerInfo, (value) {
      return _then(_value.copyWith(reviewerInfo: value) as $Val);
    });
  }

  /// Create a copy of DetailedReview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReviewReplyCopyWith<$Res>? get reply {
    if (_value.reply == null) {
      return null;
    }

    return $ReviewReplyCopyWith<$Res>(_value.reply!, (value) {
      return _then(_value.copyWith(reply: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DetailedReviewImplCopyWith<$Res>
    implements $DetailedReviewCopyWith<$Res> {
  factory _$$DetailedReviewImplCopyWith(_$DetailedReviewImpl value,
          $Res Function(_$DetailedReviewImpl) then) =
      __$$DetailedReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'review_type') String reviewType,
      @JsonKey(name: 'overall_rating') int overallRating,
      String comment,
      @JsonKey(name: 'category_ratings') Map<String, dynamic>? categoryRatings,
      @JsonKey(name: 'work_complexity') String? workComplexity,
      @JsonKey(name: 'complexity_display') String? complexityDisplay,
      @JsonKey(name: 'would_work_again') bool? wouldWorkAgain,
      @JsonKey(name: 'reviewer_info') ReviewerInfo reviewerInfo,
      ReviewReply? reply,
      @JsonKey(name: 'time_ago') String timeAgo,
      @JsonKey(name: 'created_at') DateTime createdAt});

  @override
  $ReviewerInfoCopyWith<$Res> get reviewerInfo;
  @override
  $ReviewReplyCopyWith<$Res>? get reply;
}

/// @nodoc
class __$$DetailedReviewImplCopyWithImpl<$Res>
    extends _$DetailedReviewCopyWithImpl<$Res, _$DetailedReviewImpl>
    implements _$$DetailedReviewImplCopyWith<$Res> {
  __$$DetailedReviewImplCopyWithImpl(
      _$DetailedReviewImpl _value, $Res Function(_$DetailedReviewImpl) _then)
      : super(_value, _then);

  /// Create a copy of DetailedReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reviewType = null,
    Object? overallRating = null,
    Object? comment = null,
    Object? categoryRatings = freezed,
    Object? workComplexity = freezed,
    Object? complexityDisplay = freezed,
    Object? wouldWorkAgain = freezed,
    Object? reviewerInfo = null,
    Object? reply = freezed,
    Object? timeAgo = null,
    Object? createdAt = null,
  }) {
    return _then(_$DetailedReviewImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      reviewType: null == reviewType
          ? _value.reviewType
          : reviewType // ignore: cast_nullable_to_non_nullable
              as String,
      overallRating: null == overallRating
          ? _value.overallRating
          : overallRating // ignore: cast_nullable_to_non_nullable
              as int,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      categoryRatings: freezed == categoryRatings
          ? _value._categoryRatings
          : categoryRatings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      workComplexity: freezed == workComplexity
          ? _value.workComplexity
          : workComplexity // ignore: cast_nullable_to_non_nullable
              as String?,
      complexityDisplay: freezed == complexityDisplay
          ? _value.complexityDisplay
          : complexityDisplay // ignore: cast_nullable_to_non_nullable
              as String?,
      wouldWorkAgain: freezed == wouldWorkAgain
          ? _value.wouldWorkAgain
          : wouldWorkAgain // ignore: cast_nullable_to_non_nullable
              as bool?,
      reviewerInfo: null == reviewerInfo
          ? _value.reviewerInfo
          : reviewerInfo // ignore: cast_nullable_to_non_nullable
              as ReviewerInfo,
      reply: freezed == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as ReviewReply?,
      timeAgo: null == timeAgo
          ? _value.timeAgo
          : timeAgo // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DetailedReviewImpl extends _DetailedReview
    with DiagnosticableTreeMixin {
  const _$DetailedReviewImpl(
      {required this.id,
      @JsonKey(name: 'review_type') required this.reviewType,
      @JsonKey(name: 'overall_rating') required this.overallRating,
      required this.comment,
      @JsonKey(name: 'category_ratings')
      final Map<String, dynamic>? categoryRatings,
      @JsonKey(name: 'work_complexity') this.workComplexity,
      @JsonKey(name: 'complexity_display') this.complexityDisplay,
      @JsonKey(name: 'would_work_again') this.wouldWorkAgain,
      @JsonKey(name: 'reviewer_info') required this.reviewerInfo,
      this.reply,
      @JsonKey(name: 'time_ago') required this.timeAgo,
      @JsonKey(name: 'created_at') required this.createdAt})
      : _categoryRatings = categoryRatings,
        super._();

  factory _$DetailedReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetailedReviewImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'review_type')
  final String reviewType;
  @override
  @JsonKey(name: 'overall_rating')
  final int overallRating;
  @override
  final String comment;
  final Map<String, dynamic>? _categoryRatings;
  @override
  @JsonKey(name: 'category_ratings')
  Map<String, dynamic>? get categoryRatings {
    final value = _categoryRatings;
    if (value == null) return null;
    if (_categoryRatings is EqualUnmodifiableMapView) return _categoryRatings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'work_complexity')
  final String? workComplexity;
  @override
  @JsonKey(name: 'complexity_display')
  final String? complexityDisplay;
  @override
  @JsonKey(name: 'would_work_again')
  final bool? wouldWorkAgain;
  @override
  @JsonKey(name: 'reviewer_info')
  final ReviewerInfo reviewerInfo;
  @override
  final ReviewReply? reply;
  @override
  @JsonKey(name: 'time_ago')
  final String timeAgo;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DetailedReview(id: $id, reviewType: $reviewType, overallRating: $overallRating, comment: $comment, categoryRatings: $categoryRatings, workComplexity: $workComplexity, complexityDisplay: $complexityDisplay, wouldWorkAgain: $wouldWorkAgain, reviewerInfo: $reviewerInfo, reply: $reply, timeAgo: $timeAgo, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DetailedReview'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('reviewType', reviewType))
      ..add(DiagnosticsProperty('overallRating', overallRating))
      ..add(DiagnosticsProperty('comment', comment))
      ..add(DiagnosticsProperty('categoryRatings', categoryRatings))
      ..add(DiagnosticsProperty('workComplexity', workComplexity))
      ..add(DiagnosticsProperty('complexityDisplay', complexityDisplay))
      ..add(DiagnosticsProperty('wouldWorkAgain', wouldWorkAgain))
      ..add(DiagnosticsProperty('reviewerInfo', reviewerInfo))
      ..add(DiagnosticsProperty('reply', reply))
      ..add(DiagnosticsProperty('timeAgo', timeAgo))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailedReviewImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.reviewType, reviewType) ||
                other.reviewType == reviewType) &&
            (identical(other.overallRating, overallRating) ||
                other.overallRating == overallRating) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            const DeepCollectionEquality()
                .equals(other._categoryRatings, _categoryRatings) &&
            (identical(other.workComplexity, workComplexity) ||
                other.workComplexity == workComplexity) &&
            (identical(other.complexityDisplay, complexityDisplay) ||
                other.complexityDisplay == complexityDisplay) &&
            (identical(other.wouldWorkAgain, wouldWorkAgain) ||
                other.wouldWorkAgain == wouldWorkAgain) &&
            (identical(other.reviewerInfo, reviewerInfo) ||
                other.reviewerInfo == reviewerInfo) &&
            (identical(other.reply, reply) || other.reply == reply) &&
            (identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      reviewType,
      overallRating,
      comment,
      const DeepCollectionEquality().hash(_categoryRatings),
      workComplexity,
      complexityDisplay,
      wouldWorkAgain,
      reviewerInfo,
      reply,
      timeAgo,
      createdAt);

  /// Create a copy of DetailedReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailedReviewImplCopyWith<_$DetailedReviewImpl> get copyWith =>
      __$$DetailedReviewImplCopyWithImpl<_$DetailedReviewImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DetailedReviewImplToJson(
      this,
    );
  }
}

abstract class _DetailedReview extends DetailedReview {
  const factory _DetailedReview(
      {required final int id,
      @JsonKey(name: 'review_type') required final String reviewType,
      @JsonKey(name: 'overall_rating') required final int overallRating,
      required final String comment,
      @JsonKey(name: 'category_ratings')
      final Map<String, dynamic>? categoryRatings,
      @JsonKey(name: 'work_complexity') final String? workComplexity,
      @JsonKey(name: 'complexity_display') final String? complexityDisplay,
      @JsonKey(name: 'would_work_again') final bool? wouldWorkAgain,
      @JsonKey(name: 'reviewer_info') required final ReviewerInfo reviewerInfo,
      final ReviewReply? reply,
      @JsonKey(name: 'time_ago') required final String timeAgo,
      @JsonKey(name: 'created_at')
      required final DateTime createdAt}) = _$DetailedReviewImpl;
  const _DetailedReview._() : super._();

  factory _DetailedReview.fromJson(Map<String, dynamic> json) =
      _$DetailedReviewImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'review_type')
  String get reviewType;
  @override
  @JsonKey(name: 'overall_rating')
  int get overallRating;
  @override
  String get comment;
  @override
  @JsonKey(name: 'category_ratings')
  Map<String, dynamic>? get categoryRatings;
  @override
  @JsonKey(name: 'work_complexity')
  String? get workComplexity;
  @override
  @JsonKey(name: 'complexity_display')
  String? get complexityDisplay;
  @override
  @JsonKey(name: 'would_work_again')
  bool? get wouldWorkAgain;
  @override
  @JsonKey(name: 'reviewer_info')
  ReviewerInfo get reviewerInfo;
  @override
  ReviewReply? get reply;
  @override
  @JsonKey(name: 'time_ago')
  String get timeAgo;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of DetailedReview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetailedReviewImplCopyWith<_$DetailedReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReviewSummary _$ReviewSummaryFromJson(Map<String, dynamic> json) {
  return _ReviewSummary.fromJson(json);
}

/// @nodoc
mixin _$ReviewSummary {
  @JsonKey(name: 'total_reviews', defaultValue: 0)
  int get totalReviews => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_rating', defaultValue: 0.0)
  double get averageRating => throw _privateConstructorUsedError;
  @JsonKey(name: 'five_star_count')
  int? get fiveStarCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'four_star_count')
  int? get fourStarCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'three_star_count')
  int? get threeStarCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'two_star_count')
  int? get twoStarCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'one_star_count')
  int? get oneStarCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'positive_percentage')
  double? get positivePercentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'would_work_again_percentage')
  double? get wouldWorkAgainPercentage => throw _privateConstructorUsedError;

  /// Serializes this ReviewSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewSummaryCopyWith<ReviewSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewSummaryCopyWith<$Res> {
  factory $ReviewSummaryCopyWith(
          ReviewSummary value, $Res Function(ReviewSummary) then) =
      _$ReviewSummaryCopyWithImpl<$Res, ReviewSummary>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_reviews', defaultValue: 0) int totalReviews,
      @JsonKey(name: 'average_rating', defaultValue: 0.0) double averageRating,
      @JsonKey(name: 'five_star_count') int? fiveStarCount,
      @JsonKey(name: 'four_star_count') int? fourStarCount,
      @JsonKey(name: 'three_star_count') int? threeStarCount,
      @JsonKey(name: 'two_star_count') int? twoStarCount,
      @JsonKey(name: 'one_star_count') int? oneStarCount,
      @JsonKey(name: 'positive_percentage') double? positivePercentage,
      @JsonKey(name: 'would_work_again_percentage')
      double? wouldWorkAgainPercentage});
}

/// @nodoc
class _$ReviewSummaryCopyWithImpl<$Res, $Val extends ReviewSummary>
    implements $ReviewSummaryCopyWith<$Res> {
  _$ReviewSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalReviews = null,
    Object? averageRating = null,
    Object? fiveStarCount = freezed,
    Object? fourStarCount = freezed,
    Object? threeStarCount = freezed,
    Object? twoStarCount = freezed,
    Object? oneStarCount = freezed,
    Object? positivePercentage = freezed,
    Object? wouldWorkAgainPercentage = freezed,
  }) {
    return _then(_value.copyWith(
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      fiveStarCount: freezed == fiveStarCount
          ? _value.fiveStarCount
          : fiveStarCount // ignore: cast_nullable_to_non_nullable
              as int?,
      fourStarCount: freezed == fourStarCount
          ? _value.fourStarCount
          : fourStarCount // ignore: cast_nullable_to_non_nullable
              as int?,
      threeStarCount: freezed == threeStarCount
          ? _value.threeStarCount
          : threeStarCount // ignore: cast_nullable_to_non_nullable
              as int?,
      twoStarCount: freezed == twoStarCount
          ? _value.twoStarCount
          : twoStarCount // ignore: cast_nullable_to_non_nullable
              as int?,
      oneStarCount: freezed == oneStarCount
          ? _value.oneStarCount
          : oneStarCount // ignore: cast_nullable_to_non_nullable
              as int?,
      positivePercentage: freezed == positivePercentage
          ? _value.positivePercentage
          : positivePercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      wouldWorkAgainPercentage: freezed == wouldWorkAgainPercentage
          ? _value.wouldWorkAgainPercentage
          : wouldWorkAgainPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewSummaryImplCopyWith<$Res>
    implements $ReviewSummaryCopyWith<$Res> {
  factory _$$ReviewSummaryImplCopyWith(
          _$ReviewSummaryImpl value, $Res Function(_$ReviewSummaryImpl) then) =
      __$$ReviewSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_reviews', defaultValue: 0) int totalReviews,
      @JsonKey(name: 'average_rating', defaultValue: 0.0) double averageRating,
      @JsonKey(name: 'five_star_count') int? fiveStarCount,
      @JsonKey(name: 'four_star_count') int? fourStarCount,
      @JsonKey(name: 'three_star_count') int? threeStarCount,
      @JsonKey(name: 'two_star_count') int? twoStarCount,
      @JsonKey(name: 'one_star_count') int? oneStarCount,
      @JsonKey(name: 'positive_percentage') double? positivePercentage,
      @JsonKey(name: 'would_work_again_percentage')
      double? wouldWorkAgainPercentage});
}

/// @nodoc
class __$$ReviewSummaryImplCopyWithImpl<$Res>
    extends _$ReviewSummaryCopyWithImpl<$Res, _$ReviewSummaryImpl>
    implements _$$ReviewSummaryImplCopyWith<$Res> {
  __$$ReviewSummaryImplCopyWithImpl(
      _$ReviewSummaryImpl _value, $Res Function(_$ReviewSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalReviews = null,
    Object? averageRating = null,
    Object? fiveStarCount = freezed,
    Object? fourStarCount = freezed,
    Object? threeStarCount = freezed,
    Object? twoStarCount = freezed,
    Object? oneStarCount = freezed,
    Object? positivePercentage = freezed,
    Object? wouldWorkAgainPercentage = freezed,
  }) {
    return _then(_$ReviewSummaryImpl(
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      fiveStarCount: freezed == fiveStarCount
          ? _value.fiveStarCount
          : fiveStarCount // ignore: cast_nullable_to_non_nullable
              as int?,
      fourStarCount: freezed == fourStarCount
          ? _value.fourStarCount
          : fourStarCount // ignore: cast_nullable_to_non_nullable
              as int?,
      threeStarCount: freezed == threeStarCount
          ? _value.threeStarCount
          : threeStarCount // ignore: cast_nullable_to_non_nullable
              as int?,
      twoStarCount: freezed == twoStarCount
          ? _value.twoStarCount
          : twoStarCount // ignore: cast_nullable_to_non_nullable
              as int?,
      oneStarCount: freezed == oneStarCount
          ? _value.oneStarCount
          : oneStarCount // ignore: cast_nullable_to_non_nullable
              as int?,
      positivePercentage: freezed == positivePercentage
          ? _value.positivePercentage
          : positivePercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      wouldWorkAgainPercentage: freezed == wouldWorkAgainPercentage
          ? _value.wouldWorkAgainPercentage
          : wouldWorkAgainPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewSummaryImpl extends _ReviewSummary with DiagnosticableTreeMixin {
  const _$ReviewSummaryImpl(
      {@JsonKey(name: 'total_reviews', defaultValue: 0)
      required this.totalReviews,
      @JsonKey(name: 'average_rating', defaultValue: 0.0)
      required this.averageRating,
      @JsonKey(name: 'five_star_count') this.fiveStarCount,
      @JsonKey(name: 'four_star_count') this.fourStarCount,
      @JsonKey(name: 'three_star_count') this.threeStarCount,
      @JsonKey(name: 'two_star_count') this.twoStarCount,
      @JsonKey(name: 'one_star_count') this.oneStarCount,
      @JsonKey(name: 'positive_percentage') this.positivePercentage,
      @JsonKey(name: 'would_work_again_percentage')
      this.wouldWorkAgainPercentage})
      : super._();

  factory _$ReviewSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewSummaryImplFromJson(json);

  @override
  @JsonKey(name: 'total_reviews', defaultValue: 0)
  final int totalReviews;
  @override
  @JsonKey(name: 'average_rating', defaultValue: 0.0)
  final double averageRating;
  @override
  @JsonKey(name: 'five_star_count')
  final int? fiveStarCount;
  @override
  @JsonKey(name: 'four_star_count')
  final int? fourStarCount;
  @override
  @JsonKey(name: 'three_star_count')
  final int? threeStarCount;
  @override
  @JsonKey(name: 'two_star_count')
  final int? twoStarCount;
  @override
  @JsonKey(name: 'one_star_count')
  final int? oneStarCount;
  @override
  @JsonKey(name: 'positive_percentage')
  final double? positivePercentage;
  @override
  @JsonKey(name: 'would_work_again_percentage')
  final double? wouldWorkAgainPercentage;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReviewSummary(totalReviews: $totalReviews, averageRating: $averageRating, fiveStarCount: $fiveStarCount, fourStarCount: $fourStarCount, threeStarCount: $threeStarCount, twoStarCount: $twoStarCount, oneStarCount: $oneStarCount, positivePercentage: $positivePercentage, wouldWorkAgainPercentage: $wouldWorkAgainPercentage)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReviewSummary'))
      ..add(DiagnosticsProperty('totalReviews', totalReviews))
      ..add(DiagnosticsProperty('averageRating', averageRating))
      ..add(DiagnosticsProperty('fiveStarCount', fiveStarCount))
      ..add(DiagnosticsProperty('fourStarCount', fourStarCount))
      ..add(DiagnosticsProperty('threeStarCount', threeStarCount))
      ..add(DiagnosticsProperty('twoStarCount', twoStarCount))
      ..add(DiagnosticsProperty('oneStarCount', oneStarCount))
      ..add(DiagnosticsProperty('positivePercentage', positivePercentage))
      ..add(DiagnosticsProperty(
          'wouldWorkAgainPercentage', wouldWorkAgainPercentage));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewSummaryImpl &&
            (identical(other.totalReviews, totalReviews) ||
                other.totalReviews == totalReviews) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.fiveStarCount, fiveStarCount) ||
                other.fiveStarCount == fiveStarCount) &&
            (identical(other.fourStarCount, fourStarCount) ||
                other.fourStarCount == fourStarCount) &&
            (identical(other.threeStarCount, threeStarCount) ||
                other.threeStarCount == threeStarCount) &&
            (identical(other.twoStarCount, twoStarCount) ||
                other.twoStarCount == twoStarCount) &&
            (identical(other.oneStarCount, oneStarCount) ||
                other.oneStarCount == oneStarCount) &&
            (identical(other.positivePercentage, positivePercentage) ||
                other.positivePercentage == positivePercentage) &&
            (identical(
                    other.wouldWorkAgainPercentage, wouldWorkAgainPercentage) ||
                other.wouldWorkAgainPercentage == wouldWorkAgainPercentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalReviews,
      averageRating,
      fiveStarCount,
      fourStarCount,
      threeStarCount,
      twoStarCount,
      oneStarCount,
      positivePercentage,
      wouldWorkAgainPercentage);

  /// Create a copy of ReviewSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewSummaryImplCopyWith<_$ReviewSummaryImpl> get copyWith =>
      __$$ReviewSummaryImplCopyWithImpl<_$ReviewSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewSummaryImplToJson(
      this,
    );
  }
}

abstract class _ReviewSummary extends ReviewSummary {
  const factory _ReviewSummary(
      {@JsonKey(name: 'total_reviews', defaultValue: 0)
      required final int totalReviews,
      @JsonKey(name: 'average_rating', defaultValue: 0.0)
      required final double averageRating,
      @JsonKey(name: 'five_star_count') final int? fiveStarCount,
      @JsonKey(name: 'four_star_count') final int? fourStarCount,
      @JsonKey(name: 'three_star_count') final int? threeStarCount,
      @JsonKey(name: 'two_star_count') final int? twoStarCount,
      @JsonKey(name: 'one_star_count') final int? oneStarCount,
      @JsonKey(name: 'positive_percentage') final double? positivePercentage,
      @JsonKey(name: 'would_work_again_percentage')
      final double? wouldWorkAgainPercentage}) = _$ReviewSummaryImpl;
  const _ReviewSummary._() : super._();

  factory _ReviewSummary.fromJson(Map<String, dynamic> json) =
      _$ReviewSummaryImpl.fromJson;

  @override
  @JsonKey(name: 'total_reviews', defaultValue: 0)
  int get totalReviews;
  @override
  @JsonKey(name: 'average_rating', defaultValue: 0.0)
  double get averageRating;
  @override
  @JsonKey(name: 'five_star_count')
  int? get fiveStarCount;
  @override
  @JsonKey(name: 'four_star_count')
  int? get fourStarCount;
  @override
  @JsonKey(name: 'three_star_count')
  int? get threeStarCount;
  @override
  @JsonKey(name: 'two_star_count')
  int? get twoStarCount;
  @override
  @JsonKey(name: 'one_star_count')
  int? get oneStarCount;
  @override
  @JsonKey(name: 'positive_percentage')
  double? get positivePercentage;
  @override
  @JsonKey(name: 'would_work_again_percentage')
  double? get wouldWorkAgainPercentage;

  /// Create a copy of ReviewSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewSummaryImplCopyWith<_$ReviewSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReviewsResponse _$ReviewsResponseFromJson(Map<String, dynamic> json) {
  return _ReviewsResponse.fromJson(json);
}

/// @nodoc
mixin _$ReviewsResponse {
  ReviewSummary get summary => throw _privateConstructorUsedError;
  List<DetailedReview> get reviews => throw _privateConstructorUsedError;

  /// Serializes this ReviewsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewsResponseCopyWith<ReviewsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewsResponseCopyWith<$Res> {
  factory $ReviewsResponseCopyWith(
          ReviewsResponse value, $Res Function(ReviewsResponse) then) =
      _$ReviewsResponseCopyWithImpl<$Res, ReviewsResponse>;
  @useResult
  $Res call({ReviewSummary summary, List<DetailedReview> reviews});

  $ReviewSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class _$ReviewsResponseCopyWithImpl<$Res, $Val extends ReviewsResponse>
    implements $ReviewsResponseCopyWith<$Res> {
  _$ReviewsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summary = null,
    Object? reviews = null,
  }) {
    return _then(_value.copyWith(
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as ReviewSummary,
      reviews: null == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<DetailedReview>,
    ) as $Val);
  }

  /// Create a copy of ReviewsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReviewSummaryCopyWith<$Res> get summary {
    return $ReviewSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReviewsResponseImplCopyWith<$Res>
    implements $ReviewsResponseCopyWith<$Res> {
  factory _$$ReviewsResponseImplCopyWith(_$ReviewsResponseImpl value,
          $Res Function(_$ReviewsResponseImpl) then) =
      __$$ReviewsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ReviewSummary summary, List<DetailedReview> reviews});

  @override
  $ReviewSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$$ReviewsResponseImplCopyWithImpl<$Res>
    extends _$ReviewsResponseCopyWithImpl<$Res, _$ReviewsResponseImpl>
    implements _$$ReviewsResponseImplCopyWith<$Res> {
  __$$ReviewsResponseImplCopyWithImpl(
      _$ReviewsResponseImpl _value, $Res Function(_$ReviewsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summary = null,
    Object? reviews = null,
  }) {
    return _then(_$ReviewsResponseImpl(
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as ReviewSummary,
      reviews: null == reviews
          ? _value._reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<DetailedReview>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewsResponseImpl
    with DiagnosticableTreeMixin
    implements _ReviewsResponse {
  const _$ReviewsResponseImpl(
      {required this.summary, required final List<DetailedReview> reviews})
      : _reviews = reviews;

  factory _$ReviewsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewsResponseImplFromJson(json);

  @override
  final ReviewSummary summary;
  final List<DetailedReview> _reviews;
  @override
  List<DetailedReview> get reviews {
    if (_reviews is EqualUnmodifiableListView) return _reviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviews);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReviewsResponse(summary: $summary, reviews: $reviews)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReviewsResponse'))
      ..add(DiagnosticsProperty('summary', summary))
      ..add(DiagnosticsProperty('reviews', reviews));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewsResponseImpl &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other._reviews, _reviews));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, summary, const DeepCollectionEquality().hash(_reviews));

  /// Create a copy of ReviewsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewsResponseImplCopyWith<_$ReviewsResponseImpl> get copyWith =>
      __$$ReviewsResponseImplCopyWithImpl<_$ReviewsResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewsResponseImplToJson(
      this,
    );
  }
}

abstract class _ReviewsResponse implements ReviewsResponse {
  const factory _ReviewsResponse(
      {required final ReviewSummary summary,
      required final List<DetailedReview> reviews}) = _$ReviewsResponseImpl;

  factory _ReviewsResponse.fromJson(Map<String, dynamic> json) =
      _$ReviewsResponseImpl.fromJson;

  @override
  ReviewSummary get summary;
  @override
  List<DetailedReview> get reviews;

  /// Create a copy of ReviewsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewsResponseImplCopyWith<_$ReviewsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfileReviewsResponse _$ProfileReviewsResponseFromJson(
    Map<String, dynamic> json) {
  return _ProfileReviewsResponse.fromJson(json);
}

/// @nodoc
mixin _$ProfileReviewsResponse {
  List<ProfileReview> get reviews => throw _privateConstructorUsedError;

  /// Serializes this ProfileReviewsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileReviewsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileReviewsResponseCopyWith<ProfileReviewsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileReviewsResponseCopyWith<$Res> {
  factory $ProfileReviewsResponseCopyWith(ProfileReviewsResponse value,
          $Res Function(ProfileReviewsResponse) then) =
      _$ProfileReviewsResponseCopyWithImpl<$Res, ProfileReviewsResponse>;
  @useResult
  $Res call({List<ProfileReview> reviews});
}

/// @nodoc
class _$ProfileReviewsResponseCopyWithImpl<$Res,
        $Val extends ProfileReviewsResponse>
    implements $ProfileReviewsResponseCopyWith<$Res> {
  _$ProfileReviewsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileReviewsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviews = null,
  }) {
    return _then(_value.copyWith(
      reviews: null == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ProfileReview>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileReviewsResponseImplCopyWith<$Res>
    implements $ProfileReviewsResponseCopyWith<$Res> {
  factory _$$ProfileReviewsResponseImplCopyWith(
          _$ProfileReviewsResponseImpl value,
          $Res Function(_$ProfileReviewsResponseImpl) then) =
      __$$ProfileReviewsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ProfileReview> reviews});
}

/// @nodoc
class __$$ProfileReviewsResponseImplCopyWithImpl<$Res>
    extends _$ProfileReviewsResponseCopyWithImpl<$Res,
        _$ProfileReviewsResponseImpl>
    implements _$$ProfileReviewsResponseImplCopyWith<$Res> {
  __$$ProfileReviewsResponseImplCopyWithImpl(
      _$ProfileReviewsResponseImpl _value,
      $Res Function(_$ProfileReviewsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileReviewsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviews = null,
  }) {
    return _then(_$ProfileReviewsResponseImpl(
      reviews: null == reviews
          ? _value._reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ProfileReview>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileReviewsResponseImpl
    with DiagnosticableTreeMixin
    implements _ProfileReviewsResponse {
  const _$ProfileReviewsResponseImpl(
      {required final List<ProfileReview> reviews})
      : _reviews = reviews;

  factory _$ProfileReviewsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileReviewsResponseImplFromJson(json);

  final List<ProfileReview> _reviews;
  @override
  List<ProfileReview> get reviews {
    if (_reviews is EqualUnmodifiableListView) return _reviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviews);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfileReviewsResponse(reviews: $reviews)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileReviewsResponse'))
      ..add(DiagnosticsProperty('reviews', reviews));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileReviewsResponseImpl &&
            const DeepCollectionEquality().equals(other._reviews, _reviews));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_reviews));

  /// Create a copy of ProfileReviewsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileReviewsResponseImplCopyWith<_$ProfileReviewsResponseImpl>
      get copyWith => __$$ProfileReviewsResponseImplCopyWithImpl<
          _$ProfileReviewsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileReviewsResponseImplToJson(
      this,
    );
  }
}

abstract class _ProfileReviewsResponse implements ProfileReviewsResponse {
  const factory _ProfileReviewsResponse(
          {required final List<ProfileReview> reviews}) =
      _$ProfileReviewsResponseImpl;

  factory _ProfileReviewsResponse.fromJson(Map<String, dynamic> json) =
      _$ProfileReviewsResponseImpl.fromJson;

  @override
  List<ProfileReview> get reviews;

  /// Create a copy of ProfileReviewsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileReviewsResponseImplCopyWith<_$ProfileReviewsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ReviewFilter _$ReviewFilterFromJson(Map<String, dynamic> json) {
  return _ReviewFilter.fromJson(json);
}

/// @nodoc
mixin _$ReviewFilter {
  String? get reviewType => throw _privateConstructorUsedError;
  int? get minRating => throw _privateConstructorUsedError;
  int? get maxRating => throw _privateConstructorUsedError;
  String get sortBy => throw _privateConstructorUsedError;
  bool get showFlagged => throw _privateConstructorUsedError;

  /// Serializes this ReviewFilter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewFilterCopyWith<ReviewFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewFilterCopyWith<$Res> {
  factory $ReviewFilterCopyWith(
          ReviewFilter value, $Res Function(ReviewFilter) then) =
      _$ReviewFilterCopyWithImpl<$Res, ReviewFilter>;
  @useResult
  $Res call(
      {String? reviewType,
      int? minRating,
      int? maxRating,
      String sortBy,
      bool showFlagged});
}

/// @nodoc
class _$ReviewFilterCopyWithImpl<$Res, $Val extends ReviewFilter>
    implements $ReviewFilterCopyWith<$Res> {
  _$ReviewFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviewType = freezed,
    Object? minRating = freezed,
    Object? maxRating = freezed,
    Object? sortBy = null,
    Object? showFlagged = null,
  }) {
    return _then(_value.copyWith(
      reviewType: freezed == reviewType
          ? _value.reviewType
          : reviewType // ignore: cast_nullable_to_non_nullable
              as String?,
      minRating: freezed == minRating
          ? _value.minRating
          : minRating // ignore: cast_nullable_to_non_nullable
              as int?,
      maxRating: freezed == maxRating
          ? _value.maxRating
          : maxRating // ignore: cast_nullable_to_non_nullable
              as int?,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
      showFlagged: null == showFlagged
          ? _value.showFlagged
          : showFlagged // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewFilterImplCopyWith<$Res>
    implements $ReviewFilterCopyWith<$Res> {
  factory _$$ReviewFilterImplCopyWith(
          _$ReviewFilterImpl value, $Res Function(_$ReviewFilterImpl) then) =
      __$$ReviewFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? reviewType,
      int? minRating,
      int? maxRating,
      String sortBy,
      bool showFlagged});
}

/// @nodoc
class __$$ReviewFilterImplCopyWithImpl<$Res>
    extends _$ReviewFilterCopyWithImpl<$Res, _$ReviewFilterImpl>
    implements _$$ReviewFilterImplCopyWith<$Res> {
  __$$ReviewFilterImplCopyWithImpl(
      _$ReviewFilterImpl _value, $Res Function(_$ReviewFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviewType = freezed,
    Object? minRating = freezed,
    Object? maxRating = freezed,
    Object? sortBy = null,
    Object? showFlagged = null,
  }) {
    return _then(_$ReviewFilterImpl(
      reviewType: freezed == reviewType
          ? _value.reviewType
          : reviewType // ignore: cast_nullable_to_non_nullable
              as String?,
      minRating: freezed == minRating
          ? _value.minRating
          : minRating // ignore: cast_nullable_to_non_nullable
              as int?,
      maxRating: freezed == maxRating
          ? _value.maxRating
          : maxRating // ignore: cast_nullable_to_non_nullable
              as int?,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
      showFlagged: null == showFlagged
          ? _value.showFlagged
          : showFlagged // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewFilterImpl with DiagnosticableTreeMixin implements _ReviewFilter {
  const _$ReviewFilterImpl(
      {this.reviewType,
      this.minRating,
      this.maxRating,
      this.sortBy = 'created_at',
      this.showFlagged = false});

  factory _$ReviewFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewFilterImplFromJson(json);

  @override
  final String? reviewType;
  @override
  final int? minRating;
  @override
  final int? maxRating;
  @override
  @JsonKey()
  final String sortBy;
  @override
  @JsonKey()
  final bool showFlagged;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReviewFilter(reviewType: $reviewType, minRating: $minRating, maxRating: $maxRating, sortBy: $sortBy, showFlagged: $showFlagged)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReviewFilter'))
      ..add(DiagnosticsProperty('reviewType', reviewType))
      ..add(DiagnosticsProperty('minRating', minRating))
      ..add(DiagnosticsProperty('maxRating', maxRating))
      ..add(DiagnosticsProperty('sortBy', sortBy))
      ..add(DiagnosticsProperty('showFlagged', showFlagged));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewFilterImpl &&
            (identical(other.reviewType, reviewType) ||
                other.reviewType == reviewType) &&
            (identical(other.minRating, minRating) ||
                other.minRating == minRating) &&
            (identical(other.maxRating, maxRating) ||
                other.maxRating == maxRating) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.showFlagged, showFlagged) ||
                other.showFlagged == showFlagged));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, reviewType, minRating, maxRating, sortBy, showFlagged);

  /// Create a copy of ReviewFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewFilterImplCopyWith<_$ReviewFilterImpl> get copyWith =>
      __$$ReviewFilterImplCopyWithImpl<_$ReviewFilterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewFilterImplToJson(
      this,
    );
  }
}

abstract class _ReviewFilter implements ReviewFilter {
  const factory _ReviewFilter(
      {final String? reviewType,
      final int? minRating,
      final int? maxRating,
      final String sortBy,
      final bool showFlagged}) = _$ReviewFilterImpl;

  factory _ReviewFilter.fromJson(Map<String, dynamic> json) =
      _$ReviewFilterImpl.fromJson;

  @override
  String? get reviewType;
  @override
  int? get minRating;
  @override
  int? get maxRating;
  @override
  String get sortBy;
  @override
  bool get showFlagged;

  /// Create a copy of ReviewFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewFilterImplCopyWith<_$ReviewFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

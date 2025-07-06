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

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return _Review.fromJson(json);
}

/// @nodoc
mixin _$Review {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'review_type')
  String get reviewType => throw _privateConstructorUsedError;
  @JsonKey(name: 'overall_rating')
  int get overallRating => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_ratings')
  Map<String, int>? get categoryRatings => throw _privateConstructorUsedError;
  @JsonKey(name: 'work_complexity')
  String? get workComplexity => throw _privateConstructorUsedError;
  @JsonKey(name: 'would_work_again')
  bool? get wouldWorkAgain => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_flagged', defaultValue: false)
  bool get isFlagged => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Reviewer info (anonymous)
  @JsonKey(name: 'reviewer_info')
  ReviewerInfo? get reviewerInfo =>
      throw _privateConstructorUsedError; // Related job/service info
  @JsonKey(name: 'job_title')
  String? get jobTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_description')
  String? get serviceDescription =>
      throw _privateConstructorUsedError; // Reply if any
  ReviewReply? get reply => throw _privateConstructorUsedError;

  /// Serializes this Review to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewCopyWith<Review> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewCopyWith<$Res> {
  factory $ReviewCopyWith(Review value, $Res Function(Review) then) =
      _$ReviewCopyWithImpl<$Res, Review>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'review_type') String reviewType,
      @JsonKey(name: 'overall_rating') int overallRating,
      String comment,
      @JsonKey(name: 'category_ratings') Map<String, int>? categoryRatings,
      @JsonKey(name: 'work_complexity') String? workComplexity,
      @JsonKey(name: 'would_work_again') bool? wouldWorkAgain,
      @JsonKey(name: 'is_flagged', defaultValue: false) bool isFlagged,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'reviewer_info') ReviewerInfo? reviewerInfo,
      @JsonKey(name: 'job_title') String? jobTitle,
      @JsonKey(name: 'service_description') String? serviceDescription,
      ReviewReply? reply});

  $ReviewerInfoCopyWith<$Res>? get reviewerInfo;
  $ReviewReplyCopyWith<$Res>? get reply;
}

/// @nodoc
class _$ReviewCopyWithImpl<$Res, $Val extends Review>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Review
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
    Object? wouldWorkAgain = freezed,
    Object? isFlagged = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? reviewerInfo = freezed,
    Object? jobTitle = freezed,
    Object? serviceDescription = freezed,
    Object? reply = freezed,
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
              as Map<String, int>?,
      workComplexity: freezed == workComplexity
          ? _value.workComplexity
          : workComplexity // ignore: cast_nullable_to_non_nullable
              as String?,
      wouldWorkAgain: freezed == wouldWorkAgain
          ? _value.wouldWorkAgain
          : wouldWorkAgain // ignore: cast_nullable_to_non_nullable
              as bool?,
      isFlagged: null == isFlagged
          ? _value.isFlagged
          : isFlagged // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reviewerInfo: freezed == reviewerInfo
          ? _value.reviewerInfo
          : reviewerInfo // ignore: cast_nullable_to_non_nullable
              as ReviewerInfo?,
      jobTitle: freezed == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceDescription: freezed == serviceDescription
          ? _value.serviceDescription
          : serviceDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      reply: freezed == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as ReviewReply?,
    ) as $Val);
  }

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReviewerInfoCopyWith<$Res>? get reviewerInfo {
    if (_value.reviewerInfo == null) {
      return null;
    }

    return $ReviewerInfoCopyWith<$Res>(_value.reviewerInfo!, (value) {
      return _then(_value.copyWith(reviewerInfo: value) as $Val);
    });
  }

  /// Create a copy of Review
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
abstract class _$$ReviewImplCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$$ReviewImplCopyWith(
          _$ReviewImpl value, $Res Function(_$ReviewImpl) then) =
      __$$ReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'review_type') String reviewType,
      @JsonKey(name: 'overall_rating') int overallRating,
      String comment,
      @JsonKey(name: 'category_ratings') Map<String, int>? categoryRatings,
      @JsonKey(name: 'work_complexity') String? workComplexity,
      @JsonKey(name: 'would_work_again') bool? wouldWorkAgain,
      @JsonKey(name: 'is_flagged', defaultValue: false) bool isFlagged,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'reviewer_info') ReviewerInfo? reviewerInfo,
      @JsonKey(name: 'job_title') String? jobTitle,
      @JsonKey(name: 'service_description') String? serviceDescription,
      ReviewReply? reply});

  @override
  $ReviewerInfoCopyWith<$Res>? get reviewerInfo;
  @override
  $ReviewReplyCopyWith<$Res>? get reply;
}

/// @nodoc
class __$$ReviewImplCopyWithImpl<$Res>
    extends _$ReviewCopyWithImpl<$Res, _$ReviewImpl>
    implements _$$ReviewImplCopyWith<$Res> {
  __$$ReviewImplCopyWithImpl(
      _$ReviewImpl _value, $Res Function(_$ReviewImpl) _then)
      : super(_value, _then);

  /// Create a copy of Review
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
    Object? wouldWorkAgain = freezed,
    Object? isFlagged = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? reviewerInfo = freezed,
    Object? jobTitle = freezed,
    Object? serviceDescription = freezed,
    Object? reply = freezed,
  }) {
    return _then(_$ReviewImpl(
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
              as Map<String, int>?,
      workComplexity: freezed == workComplexity
          ? _value.workComplexity
          : workComplexity // ignore: cast_nullable_to_non_nullable
              as String?,
      wouldWorkAgain: freezed == wouldWorkAgain
          ? _value.wouldWorkAgain
          : wouldWorkAgain // ignore: cast_nullable_to_non_nullable
              as bool?,
      isFlagged: null == isFlagged
          ? _value.isFlagged
          : isFlagged // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reviewerInfo: freezed == reviewerInfo
          ? _value.reviewerInfo
          : reviewerInfo // ignore: cast_nullable_to_non_nullable
              as ReviewerInfo?,
      jobTitle: freezed == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceDescription: freezed == serviceDescription
          ? _value.serviceDescription
          : serviceDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      reply: freezed == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as ReviewReply?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ReviewImpl extends _Review with DiagnosticableTreeMixin {
  const _$ReviewImpl(
      {required this.id,
      @JsonKey(name: 'review_type') required this.reviewType,
      @JsonKey(name: 'overall_rating') required this.overallRating,
      required this.comment,
      @JsonKey(name: 'category_ratings')
      final Map<String, int>? categoryRatings,
      @JsonKey(name: 'work_complexity') this.workComplexity,
      @JsonKey(name: 'would_work_again') this.wouldWorkAgain,
      @JsonKey(name: 'is_flagged', defaultValue: false) required this.isFlagged,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'reviewer_info') this.reviewerInfo,
      @JsonKey(name: 'job_title') this.jobTitle,
      @JsonKey(name: 'service_description') this.serviceDescription,
      this.reply})
      : _categoryRatings = categoryRatings,
        super._();

  factory _$ReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewImplFromJson(json);

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
  final Map<String, int>? _categoryRatings;
  @override
  @JsonKey(name: 'category_ratings')
  Map<String, int>? get categoryRatings {
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
  @JsonKey(name: 'would_work_again')
  final bool? wouldWorkAgain;
  @override
  @JsonKey(name: 'is_flagged', defaultValue: false)
  final bool isFlagged;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
// Reviewer info (anonymous)
  @override
  @JsonKey(name: 'reviewer_info')
  final ReviewerInfo? reviewerInfo;
// Related job/service info
  @override
  @JsonKey(name: 'job_title')
  final String? jobTitle;
  @override
  @JsonKey(name: 'service_description')
  final String? serviceDescription;
// Reply if any
  @override
  final ReviewReply? reply;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Review(id: $id, reviewType: $reviewType, overallRating: $overallRating, comment: $comment, categoryRatings: $categoryRatings, workComplexity: $workComplexity, wouldWorkAgain: $wouldWorkAgain, isFlagged: $isFlagged, createdAt: $createdAt, updatedAt: $updatedAt, reviewerInfo: $reviewerInfo, jobTitle: $jobTitle, serviceDescription: $serviceDescription, reply: $reply)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Review'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('reviewType', reviewType))
      ..add(DiagnosticsProperty('overallRating', overallRating))
      ..add(DiagnosticsProperty('comment', comment))
      ..add(DiagnosticsProperty('categoryRatings', categoryRatings))
      ..add(DiagnosticsProperty('workComplexity', workComplexity))
      ..add(DiagnosticsProperty('wouldWorkAgain', wouldWorkAgain))
      ..add(DiagnosticsProperty('isFlagged', isFlagged))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('reviewerInfo', reviewerInfo))
      ..add(DiagnosticsProperty('jobTitle', jobTitle))
      ..add(DiagnosticsProperty('serviceDescription', serviceDescription))
      ..add(DiagnosticsProperty('reply', reply));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewImpl &&
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
            (identical(other.wouldWorkAgain, wouldWorkAgain) ||
                other.wouldWorkAgain == wouldWorkAgain) &&
            (identical(other.isFlagged, isFlagged) ||
                other.isFlagged == isFlagged) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.reviewerInfo, reviewerInfo) ||
                other.reviewerInfo == reviewerInfo) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.serviceDescription, serviceDescription) ||
                other.serviceDescription == serviceDescription) &&
            (identical(other.reply, reply) || other.reply == reply));
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
      wouldWorkAgain,
      isFlagged,
      createdAt,
      updatedAt,
      reviewerInfo,
      jobTitle,
      serviceDescription,
      reply);

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      __$$ReviewImplCopyWithImpl<_$ReviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewImplToJson(
      this,
    );
  }
}

abstract class _Review extends Review {
  const factory _Review(
      {required final int id,
      @JsonKey(name: 'review_type') required final String reviewType,
      @JsonKey(name: 'overall_rating') required final int overallRating,
      required final String comment,
      @JsonKey(name: 'category_ratings')
      final Map<String, int>? categoryRatings,
      @JsonKey(name: 'work_complexity') final String? workComplexity,
      @JsonKey(name: 'would_work_again') final bool? wouldWorkAgain,
      @JsonKey(name: 'is_flagged', defaultValue: false)
      required final bool isFlagged,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      @JsonKey(name: 'reviewer_info') final ReviewerInfo? reviewerInfo,
      @JsonKey(name: 'job_title') final String? jobTitle,
      @JsonKey(name: 'service_description') final String? serviceDescription,
      final ReviewReply? reply}) = _$ReviewImpl;
  const _Review._() : super._();

  factory _Review.fromJson(Map<String, dynamic> json) = _$ReviewImpl.fromJson;

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
  Map<String, int>? get categoryRatings;
  @override
  @JsonKey(name: 'work_complexity')
  String? get workComplexity;
  @override
  @JsonKey(name: 'would_work_again')
  bool? get wouldWorkAgain;
  @override
  @JsonKey(name: 'is_flagged', defaultValue: false)
  bool get isFlagged;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt; // Reviewer info (anonymous)
  @override
  @JsonKey(name: 'reviewer_info')
  ReviewerInfo? get reviewerInfo; // Related job/service info
  @override
  @JsonKey(name: 'job_title')
  String? get jobTitle;
  @override
  @JsonKey(name: 'service_description')
  String? get serviceDescription; // Reply if any
  @override
  ReviewReply? get reply;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
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
  int get id => throw _privateConstructorUsedError;
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
      {int id,
      @JsonKey(name: 'reply_text') String replyText,
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
    Object? id = null,
    Object? replyText = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
      {int id,
      @JsonKey(name: 'reply_text') String replyText,
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
    Object? id = null,
    Object? replyText = null,
    Object? createdAt = null,
  }) {
    return _then(_$ReviewReplyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
      {required this.id,
      @JsonKey(name: 'reply_text') required this.replyText,
      @JsonKey(name: 'created_at') required this.createdAt})
      : super._();

  factory _$ReviewReplyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewReplyImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'reply_text')
  final String replyText;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReviewReply(id: $id, replyText: $replyText, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReviewReply'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('replyText', replyText))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewReplyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.replyText, replyText) ||
                other.replyText == replyText) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, replyText, createdAt);

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
          {required final int id,
          @JsonKey(name: 'reply_text') required final String replyText,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$ReviewReplyImpl;
  const _ReviewReply._() : super._();

  factory _ReviewReply.fromJson(Map<String, dynamic> json) =
      _$ReviewReplyImpl.fromJson;

  @override
  int get id;
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

ReviewSummary _$ReviewSummaryFromJson(Map<String, dynamic> json) {
  return _ReviewSummary.fromJson(json);
}

/// @nodoc
mixin _$ReviewSummary {
  @JsonKey(name: 'total_reviews', defaultValue: 0)
  int get totalReviews => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_rating', defaultValue: 0.0)
  double get averageRating => throw _privateConstructorUsedError;
  @JsonKey(name: 'rating_breakdown')
  Map<String, int>? get ratingBreakdown => throw _privateConstructorUsedError;
  @JsonKey(name: 'would_work_again_percentage', defaultValue: 0.0)
  double get wouldWorkAgainPercentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'recent_reviews')
  List<Review>? get recentReviews => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'rating_breakdown') Map<String, int>? ratingBreakdown,
      @JsonKey(name: 'would_work_again_percentage', defaultValue: 0.0)
      double wouldWorkAgainPercentage,
      @JsonKey(name: 'recent_reviews') List<Review>? recentReviews});
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
    Object? ratingBreakdown = freezed,
    Object? wouldWorkAgainPercentage = null,
    Object? recentReviews = freezed,
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
      ratingBreakdown: freezed == ratingBreakdown
          ? _value.ratingBreakdown
          : ratingBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      wouldWorkAgainPercentage: null == wouldWorkAgainPercentage
          ? _value.wouldWorkAgainPercentage
          : wouldWorkAgainPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      recentReviews: freezed == recentReviews
          ? _value.recentReviews
          : recentReviews // ignore: cast_nullable_to_non_nullable
              as List<Review>?,
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
      @JsonKey(name: 'rating_breakdown') Map<String, int>? ratingBreakdown,
      @JsonKey(name: 'would_work_again_percentage', defaultValue: 0.0)
      double wouldWorkAgainPercentage,
      @JsonKey(name: 'recent_reviews') List<Review>? recentReviews});
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
    Object? ratingBreakdown = freezed,
    Object? wouldWorkAgainPercentage = null,
    Object? recentReviews = freezed,
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
      ratingBreakdown: freezed == ratingBreakdown
          ? _value._ratingBreakdown
          : ratingBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      wouldWorkAgainPercentage: null == wouldWorkAgainPercentage
          ? _value.wouldWorkAgainPercentage
          : wouldWorkAgainPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      recentReviews: freezed == recentReviews
          ? _value._recentReviews
          : recentReviews // ignore: cast_nullable_to_non_nullable
              as List<Review>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewSummaryImpl
    with DiagnosticableTreeMixin
    implements _ReviewSummary {
  const _$ReviewSummaryImpl(
      {@JsonKey(name: 'total_reviews', defaultValue: 0)
      required this.totalReviews,
      @JsonKey(name: 'average_rating', defaultValue: 0.0)
      required this.averageRating,
      @JsonKey(name: 'rating_breakdown')
      final Map<String, int>? ratingBreakdown,
      @JsonKey(name: 'would_work_again_percentage', defaultValue: 0.0)
      required this.wouldWorkAgainPercentage,
      @JsonKey(name: 'recent_reviews') final List<Review>? recentReviews})
      : _ratingBreakdown = ratingBreakdown,
        _recentReviews = recentReviews;

  factory _$ReviewSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewSummaryImplFromJson(json);

  @override
  @JsonKey(name: 'total_reviews', defaultValue: 0)
  final int totalReviews;
  @override
  @JsonKey(name: 'average_rating', defaultValue: 0.0)
  final double averageRating;
  final Map<String, int>? _ratingBreakdown;
  @override
  @JsonKey(name: 'rating_breakdown')
  Map<String, int>? get ratingBreakdown {
    final value = _ratingBreakdown;
    if (value == null) return null;
    if (_ratingBreakdown is EqualUnmodifiableMapView) return _ratingBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'would_work_again_percentage', defaultValue: 0.0)
  final double wouldWorkAgainPercentage;
  final List<Review>? _recentReviews;
  @override
  @JsonKey(name: 'recent_reviews')
  List<Review>? get recentReviews {
    final value = _recentReviews;
    if (value == null) return null;
    if (_recentReviews is EqualUnmodifiableListView) return _recentReviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReviewSummary(totalReviews: $totalReviews, averageRating: $averageRating, ratingBreakdown: $ratingBreakdown, wouldWorkAgainPercentage: $wouldWorkAgainPercentage, recentReviews: $recentReviews)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReviewSummary'))
      ..add(DiagnosticsProperty('totalReviews', totalReviews))
      ..add(DiagnosticsProperty('averageRating', averageRating))
      ..add(DiagnosticsProperty('ratingBreakdown', ratingBreakdown))
      ..add(DiagnosticsProperty(
          'wouldWorkAgainPercentage', wouldWorkAgainPercentage))
      ..add(DiagnosticsProperty('recentReviews', recentReviews));
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
            const DeepCollectionEquality()
                .equals(other._ratingBreakdown, _ratingBreakdown) &&
            (identical(
                    other.wouldWorkAgainPercentage, wouldWorkAgainPercentage) ||
                other.wouldWorkAgainPercentage == wouldWorkAgainPercentage) &&
            const DeepCollectionEquality()
                .equals(other._recentReviews, _recentReviews));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalReviews,
      averageRating,
      const DeepCollectionEquality().hash(_ratingBreakdown),
      wouldWorkAgainPercentage,
      const DeepCollectionEquality().hash(_recentReviews));

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

abstract class _ReviewSummary implements ReviewSummary {
  const factory _ReviewSummary(
          {@JsonKey(name: 'total_reviews', defaultValue: 0)
          required final int totalReviews,
          @JsonKey(name: 'average_rating', defaultValue: 0.0)
          required final double averageRating,
          @JsonKey(name: 'rating_breakdown')
          final Map<String, int>? ratingBreakdown,
          @JsonKey(name: 'would_work_again_percentage', defaultValue: 0.0)
          required final double wouldWorkAgainPercentage,
          @JsonKey(name: 'recent_reviews') final List<Review>? recentReviews}) =
      _$ReviewSummaryImpl;

  factory _ReviewSummary.fromJson(Map<String, dynamic> json) =
      _$ReviewSummaryImpl.fromJson;

  @override
  @JsonKey(name: 'total_reviews', defaultValue: 0)
  int get totalReviews;
  @override
  @JsonKey(name: 'average_rating', defaultValue: 0.0)
  double get averageRating;
  @override
  @JsonKey(name: 'rating_breakdown')
  Map<String, int>? get ratingBreakdown;
  @override
  @JsonKey(name: 'would_work_again_percentage', defaultValue: 0.0)
  double get wouldWorkAgainPercentage;
  @override
  @JsonKey(name: 'recent_reviews')
  List<Review>? get recentReviews;

  /// Create a copy of ReviewSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewSummaryImplCopyWith<_$ReviewSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

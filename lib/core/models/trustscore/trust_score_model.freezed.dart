// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trust_score_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrustScore _$TrustScoreFromJson(Map<String, dynamic> json) {
  return _TrustScore.fromJson(json);
}

/// @nodoc
mixin _$TrustScore {
  @JsonKey(name: 'overall_score', defaultValue: 0.0)
  double get overallScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_reviews', defaultValue: 0)
  int get totalReviews => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_jobs', defaultValue: 0)
  int get completedJobs => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_services', defaultValue: 0)
  int get completedServices => throw _privateConstructorUsedError;
  @JsonKey(name: 'job_performance_score', defaultValue: 0.0)
  double get jobPerformanceScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_quality_score', defaultValue: 0.0)
  double get serviceQualityScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'reliability_score', defaultValue: 0.0)
  double get reliabilityScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'employer_satisfaction_score', defaultValue: 0.0)
  double get employerSatisfactionScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'trust_level', defaultValue: 'NEWCOMER')
  String get trustLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'trust_level_display', defaultValue: 'Newcomer')
  String get trustLevelDisplay => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_calculated')
  DateTime? get lastCalculated => throw _privateConstructorUsedError;

  /// Serializes this TrustScore to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrustScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrustScoreCopyWith<TrustScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrustScoreCopyWith<$Res> {
  factory $TrustScoreCopyWith(
          TrustScore value, $Res Function(TrustScore) then) =
      _$TrustScoreCopyWithImpl<$Res, TrustScore>;
  @useResult
  $Res call(
      {@JsonKey(name: 'overall_score', defaultValue: 0.0) double overallScore,
      @JsonKey(name: 'total_reviews', defaultValue: 0) int totalReviews,
      @JsonKey(name: 'completed_jobs', defaultValue: 0) int completedJobs,
      @JsonKey(name: 'completed_services', defaultValue: 0)
      int completedServices,
      @JsonKey(name: 'job_performance_score', defaultValue: 0.0)
      double jobPerformanceScore,
      @JsonKey(name: 'service_quality_score', defaultValue: 0.0)
      double serviceQualityScore,
      @JsonKey(name: 'reliability_score', defaultValue: 0.0)
      double reliabilityScore,
      @JsonKey(name: 'employer_satisfaction_score', defaultValue: 0.0)
      double employerSatisfactionScore,
      @JsonKey(name: 'trust_level', defaultValue: 'NEWCOMER') String trustLevel,
      @JsonKey(name: 'trust_level_display', defaultValue: 'Newcomer')
      String trustLevelDisplay,
      @JsonKey(name: 'last_calculated') DateTime? lastCalculated});
}

/// @nodoc
class _$TrustScoreCopyWithImpl<$Res, $Val extends TrustScore>
    implements $TrustScoreCopyWith<$Res> {
  _$TrustScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrustScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallScore = null,
    Object? totalReviews = null,
    Object? completedJobs = null,
    Object? completedServices = null,
    Object? jobPerformanceScore = null,
    Object? serviceQualityScore = null,
    Object? reliabilityScore = null,
    Object? employerSatisfactionScore = null,
    Object? trustLevel = null,
    Object? trustLevelDisplay = null,
    Object? lastCalculated = freezed,
  }) {
    return _then(_value.copyWith(
      overallScore: null == overallScore
          ? _value.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as double,
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      completedJobs: null == completedJobs
          ? _value.completedJobs
          : completedJobs // ignore: cast_nullable_to_non_nullable
              as int,
      completedServices: null == completedServices
          ? _value.completedServices
          : completedServices // ignore: cast_nullable_to_non_nullable
              as int,
      jobPerformanceScore: null == jobPerformanceScore
          ? _value.jobPerformanceScore
          : jobPerformanceScore // ignore: cast_nullable_to_non_nullable
              as double,
      serviceQualityScore: null == serviceQualityScore
          ? _value.serviceQualityScore
          : serviceQualityScore // ignore: cast_nullable_to_non_nullable
              as double,
      reliabilityScore: null == reliabilityScore
          ? _value.reliabilityScore
          : reliabilityScore // ignore: cast_nullable_to_non_nullable
              as double,
      employerSatisfactionScore: null == employerSatisfactionScore
          ? _value.employerSatisfactionScore
          : employerSatisfactionScore // ignore: cast_nullable_to_non_nullable
              as double,
      trustLevel: null == trustLevel
          ? _value.trustLevel
          : trustLevel // ignore: cast_nullable_to_non_nullable
              as String,
      trustLevelDisplay: null == trustLevelDisplay
          ? _value.trustLevelDisplay
          : trustLevelDisplay // ignore: cast_nullable_to_non_nullable
              as String,
      lastCalculated: freezed == lastCalculated
          ? _value.lastCalculated
          : lastCalculated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrustScoreImplCopyWith<$Res>
    implements $TrustScoreCopyWith<$Res> {
  factory _$$TrustScoreImplCopyWith(
          _$TrustScoreImpl value, $Res Function(_$TrustScoreImpl) then) =
      __$$TrustScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'overall_score', defaultValue: 0.0) double overallScore,
      @JsonKey(name: 'total_reviews', defaultValue: 0) int totalReviews,
      @JsonKey(name: 'completed_jobs', defaultValue: 0) int completedJobs,
      @JsonKey(name: 'completed_services', defaultValue: 0)
      int completedServices,
      @JsonKey(name: 'job_performance_score', defaultValue: 0.0)
      double jobPerformanceScore,
      @JsonKey(name: 'service_quality_score', defaultValue: 0.0)
      double serviceQualityScore,
      @JsonKey(name: 'reliability_score', defaultValue: 0.0)
      double reliabilityScore,
      @JsonKey(name: 'employer_satisfaction_score', defaultValue: 0.0)
      double employerSatisfactionScore,
      @JsonKey(name: 'trust_level', defaultValue: 'NEWCOMER') String trustLevel,
      @JsonKey(name: 'trust_level_display', defaultValue: 'Newcomer')
      String trustLevelDisplay,
      @JsonKey(name: 'last_calculated') DateTime? lastCalculated});
}

/// @nodoc
class __$$TrustScoreImplCopyWithImpl<$Res>
    extends _$TrustScoreCopyWithImpl<$Res, _$TrustScoreImpl>
    implements _$$TrustScoreImplCopyWith<$Res> {
  __$$TrustScoreImplCopyWithImpl(
      _$TrustScoreImpl _value, $Res Function(_$TrustScoreImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrustScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallScore = null,
    Object? totalReviews = null,
    Object? completedJobs = null,
    Object? completedServices = null,
    Object? jobPerformanceScore = null,
    Object? serviceQualityScore = null,
    Object? reliabilityScore = null,
    Object? employerSatisfactionScore = null,
    Object? trustLevel = null,
    Object? trustLevelDisplay = null,
    Object? lastCalculated = freezed,
  }) {
    return _then(_$TrustScoreImpl(
      overallScore: null == overallScore
          ? _value.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as double,
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      completedJobs: null == completedJobs
          ? _value.completedJobs
          : completedJobs // ignore: cast_nullable_to_non_nullable
              as int,
      completedServices: null == completedServices
          ? _value.completedServices
          : completedServices // ignore: cast_nullable_to_non_nullable
              as int,
      jobPerformanceScore: null == jobPerformanceScore
          ? _value.jobPerformanceScore
          : jobPerformanceScore // ignore: cast_nullable_to_non_nullable
              as double,
      serviceQualityScore: null == serviceQualityScore
          ? _value.serviceQualityScore
          : serviceQualityScore // ignore: cast_nullable_to_non_nullable
              as double,
      reliabilityScore: null == reliabilityScore
          ? _value.reliabilityScore
          : reliabilityScore // ignore: cast_nullable_to_non_nullable
              as double,
      employerSatisfactionScore: null == employerSatisfactionScore
          ? _value.employerSatisfactionScore
          : employerSatisfactionScore // ignore: cast_nullable_to_non_nullable
              as double,
      trustLevel: null == trustLevel
          ? _value.trustLevel
          : trustLevel // ignore: cast_nullable_to_non_nullable
              as String,
      trustLevelDisplay: null == trustLevelDisplay
          ? _value.trustLevelDisplay
          : trustLevelDisplay // ignore: cast_nullable_to_non_nullable
              as String,
      lastCalculated: freezed == lastCalculated
          ? _value.lastCalculated
          : lastCalculated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TrustScoreImpl extends _TrustScore with DiagnosticableTreeMixin {
  const _$TrustScoreImpl(
      {@JsonKey(name: 'overall_score', defaultValue: 0.0)
      required this.overallScore,
      @JsonKey(name: 'total_reviews', defaultValue: 0)
      required this.totalReviews,
      @JsonKey(name: 'completed_jobs', defaultValue: 0)
      required this.completedJobs,
      @JsonKey(name: 'completed_services', defaultValue: 0)
      required this.completedServices,
      @JsonKey(name: 'job_performance_score', defaultValue: 0.0)
      required this.jobPerformanceScore,
      @JsonKey(name: 'service_quality_score', defaultValue: 0.0)
      required this.serviceQualityScore,
      @JsonKey(name: 'reliability_score', defaultValue: 0.0)
      required this.reliabilityScore,
      @JsonKey(name: 'employer_satisfaction_score', defaultValue: 0.0)
      required this.employerSatisfactionScore,
      @JsonKey(name: 'trust_level', defaultValue: 'NEWCOMER')
      required this.trustLevel,
      @JsonKey(name: 'trust_level_display', defaultValue: 'Newcomer')
      required this.trustLevelDisplay,
      @JsonKey(name: 'last_calculated') this.lastCalculated})
      : super._();

  factory _$TrustScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrustScoreImplFromJson(json);

  @override
  @JsonKey(name: 'overall_score', defaultValue: 0.0)
  final double overallScore;
  @override
  @JsonKey(name: 'total_reviews', defaultValue: 0)
  final int totalReviews;
  @override
  @JsonKey(name: 'completed_jobs', defaultValue: 0)
  final int completedJobs;
  @override
  @JsonKey(name: 'completed_services', defaultValue: 0)
  final int completedServices;
  @override
  @JsonKey(name: 'job_performance_score', defaultValue: 0.0)
  final double jobPerformanceScore;
  @override
  @JsonKey(name: 'service_quality_score', defaultValue: 0.0)
  final double serviceQualityScore;
  @override
  @JsonKey(name: 'reliability_score', defaultValue: 0.0)
  final double reliabilityScore;
  @override
  @JsonKey(name: 'employer_satisfaction_score', defaultValue: 0.0)
  final double employerSatisfactionScore;
  @override
  @JsonKey(name: 'trust_level', defaultValue: 'NEWCOMER')
  final String trustLevel;
  @override
  @JsonKey(name: 'trust_level_display', defaultValue: 'Newcomer')
  final String trustLevelDisplay;
  @override
  @JsonKey(name: 'last_calculated')
  final DateTime? lastCalculated;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TrustScore(overallScore: $overallScore, totalReviews: $totalReviews, completedJobs: $completedJobs, completedServices: $completedServices, jobPerformanceScore: $jobPerformanceScore, serviceQualityScore: $serviceQualityScore, reliabilityScore: $reliabilityScore, employerSatisfactionScore: $employerSatisfactionScore, trustLevel: $trustLevel, trustLevelDisplay: $trustLevelDisplay, lastCalculated: $lastCalculated)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TrustScore'))
      ..add(DiagnosticsProperty('overallScore', overallScore))
      ..add(DiagnosticsProperty('totalReviews', totalReviews))
      ..add(DiagnosticsProperty('completedJobs', completedJobs))
      ..add(DiagnosticsProperty('completedServices', completedServices))
      ..add(DiagnosticsProperty('jobPerformanceScore', jobPerformanceScore))
      ..add(DiagnosticsProperty('serviceQualityScore', serviceQualityScore))
      ..add(DiagnosticsProperty('reliabilityScore', reliabilityScore))
      ..add(DiagnosticsProperty(
          'employerSatisfactionScore', employerSatisfactionScore))
      ..add(DiagnosticsProperty('trustLevel', trustLevel))
      ..add(DiagnosticsProperty('trustLevelDisplay', trustLevelDisplay))
      ..add(DiagnosticsProperty('lastCalculated', lastCalculated));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrustScoreImpl &&
            (identical(other.overallScore, overallScore) ||
                other.overallScore == overallScore) &&
            (identical(other.totalReviews, totalReviews) ||
                other.totalReviews == totalReviews) &&
            (identical(other.completedJobs, completedJobs) ||
                other.completedJobs == completedJobs) &&
            (identical(other.completedServices, completedServices) ||
                other.completedServices == completedServices) &&
            (identical(other.jobPerformanceScore, jobPerformanceScore) ||
                other.jobPerformanceScore == jobPerformanceScore) &&
            (identical(other.serviceQualityScore, serviceQualityScore) ||
                other.serviceQualityScore == serviceQualityScore) &&
            (identical(other.reliabilityScore, reliabilityScore) ||
                other.reliabilityScore == reliabilityScore) &&
            (identical(other.employerSatisfactionScore,
                    employerSatisfactionScore) ||
                other.employerSatisfactionScore == employerSatisfactionScore) &&
            (identical(other.trustLevel, trustLevel) ||
                other.trustLevel == trustLevel) &&
            (identical(other.trustLevelDisplay, trustLevelDisplay) ||
                other.trustLevelDisplay == trustLevelDisplay) &&
            (identical(other.lastCalculated, lastCalculated) ||
                other.lastCalculated == lastCalculated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      overallScore,
      totalReviews,
      completedJobs,
      completedServices,
      jobPerformanceScore,
      serviceQualityScore,
      reliabilityScore,
      employerSatisfactionScore,
      trustLevel,
      trustLevelDisplay,
      lastCalculated);

  /// Create a copy of TrustScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrustScoreImplCopyWith<_$TrustScoreImpl> get copyWith =>
      __$$TrustScoreImplCopyWithImpl<_$TrustScoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrustScoreImplToJson(
      this,
    );
  }
}

abstract class _TrustScore extends TrustScore {
  const factory _TrustScore(
          {@JsonKey(name: 'overall_score', defaultValue: 0.0)
          required final double overallScore,
          @JsonKey(name: 'total_reviews', defaultValue: 0)
          required final int totalReviews,
          @JsonKey(name: 'completed_jobs', defaultValue: 0)
          required final int completedJobs,
          @JsonKey(name: 'completed_services', defaultValue: 0)
          required final int completedServices,
          @JsonKey(name: 'job_performance_score', defaultValue: 0.0)
          required final double jobPerformanceScore,
          @JsonKey(name: 'service_quality_score', defaultValue: 0.0)
          required final double serviceQualityScore,
          @JsonKey(name: 'reliability_score', defaultValue: 0.0)
          required final double reliabilityScore,
          @JsonKey(name: 'employer_satisfaction_score', defaultValue: 0.0)
          required final double employerSatisfactionScore,
          @JsonKey(name: 'trust_level', defaultValue: 'NEWCOMER')
          required final String trustLevel,
          @JsonKey(name: 'trust_level_display', defaultValue: 'Newcomer')
          required final String trustLevelDisplay,
          @JsonKey(name: 'last_calculated') final DateTime? lastCalculated}) =
      _$TrustScoreImpl;
  const _TrustScore._() : super._();

  factory _TrustScore.fromJson(Map<String, dynamic> json) =
      _$TrustScoreImpl.fromJson;

  @override
  @JsonKey(name: 'overall_score', defaultValue: 0.0)
  double get overallScore;
  @override
  @JsonKey(name: 'total_reviews', defaultValue: 0)
  int get totalReviews;
  @override
  @JsonKey(name: 'completed_jobs', defaultValue: 0)
  int get completedJobs;
  @override
  @JsonKey(name: 'completed_services', defaultValue: 0)
  int get completedServices;
  @override
  @JsonKey(name: 'job_performance_score', defaultValue: 0.0)
  double get jobPerformanceScore;
  @override
  @JsonKey(name: 'service_quality_score', defaultValue: 0.0)
  double get serviceQualityScore;
  @override
  @JsonKey(name: 'reliability_score', defaultValue: 0.0)
  double get reliabilityScore;
  @override
  @JsonKey(name: 'employer_satisfaction_score', defaultValue: 0.0)
  double get employerSatisfactionScore;
  @override
  @JsonKey(name: 'trust_level', defaultValue: 'NEWCOMER')
  String get trustLevel;
  @override
  @JsonKey(name: 'trust_level_display', defaultValue: 'Newcomer')
  String get trustLevelDisplay;
  @override
  @JsonKey(name: 'last_calculated')
  DateTime? get lastCalculated;

  /// Create a copy of TrustScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrustScoreImplCopyWith<_$TrustScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

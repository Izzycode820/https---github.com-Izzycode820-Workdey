// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trust_score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrustScoreImpl _$$TrustScoreImplFromJson(Map<String, dynamic> json) =>
    _$TrustScoreImpl(
      overallScore: (json['overall_score'] as num?)?.toDouble() ?? 0.0,
      totalReviews: (json['total_reviews'] as num?)?.toInt() ?? 0,
      completedJobs: (json['completed_jobs'] as num?)?.toInt() ?? 0,
      completedServices: (json['completed_services'] as num?)?.toInt() ?? 0,
      jobPerformanceScore:
          (json['job_performance_score'] as num?)?.toDouble() ?? 0.0,
      serviceQualityScore:
          (json['service_quality_score'] as num?)?.toDouble() ?? 0.0,
      reliabilityScore: (json['reliability_score'] as num?)?.toDouble() ?? 0.0,
      employerSatisfactionScore:
          (json['employer_satisfaction_score'] as num?)?.toDouble() ?? 0.0,
      trustLevel: json['trust_level'] as String? ?? 'NEWCOMER',
      trustLevelDisplay: json['trust_level_display'] as String? ?? 'Newcomer',
      lastCalculated: json['last_calculated'] == null
          ? null
          : DateTime.parse(json['last_calculated'] as String),
    );

Map<String, dynamic> _$$TrustScoreImplToJson(_$TrustScoreImpl instance) =>
    <String, dynamic>{
      'overall_score': instance.overallScore,
      'total_reviews': instance.totalReviews,
      'completed_jobs': instance.completedJobs,
      'completed_services': instance.completedServices,
      'job_performance_score': instance.jobPerformanceScore,
      'service_quality_score': instance.serviceQualityScore,
      'reliability_score': instance.reliabilityScore,
      'employer_satisfaction_score': instance.employerSatisfactionScore,
      'trust_level': instance.trustLevel,
      'trust_level_display': instance.trustLevelDisplay,
      'last_calculated': instance.lastCalculated?.toIso8601String(),
    };

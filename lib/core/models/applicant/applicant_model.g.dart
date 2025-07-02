// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applicant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplicationImpl _$$ApplicationImplFromJson(Map<String, dynamic> json) =>
    _$ApplicationImpl(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
      appliedAt: DateTime.parse(json['applied_at'] as String),
      details: ApplicantDetails.fromJson(
          json['applicant_details'] as Map<String, dynamic>),
      response: json['response'] == null
          ? null
          : ApplicationResponse.fromJson(
              json['response'] as Map<String, dynamic>),
      matchStats: json['match_stats'] == null
          ? null
          : MatchStats.fromJson(json['match_stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ApplicationImplToJson(_$ApplicationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'applied_at': instance.appliedAt.toIso8601String(),
      'applicant_details': instance.details,
      'response': instance.response,
      'match_stats': instance.matchStats,
    };

_$ApplicantDetailsImpl _$$ApplicantDetailsImplFromJson(
        Map<String, dynamic> json) =>
    _$ApplicantDetailsImpl(
      name: json['name'] as String,
      verification_level: (json['verification_level'] as num?)?.toInt() ?? 0,
      completedJobs: (json['completed_jobs'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ApplicantDetailsImplToJson(
        _$ApplicantDetailsImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'verification_level': instance.verification_level,
      'completed_jobs': instance.completedJobs,
    };

_$ApplicationResponseImpl _$$ApplicationResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ApplicationResponseImpl(
      skillsMet: (json['skills_met'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      optionalSkillsMet: (json['optional_skills_met'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      notes: json['notes'] as String,
    );

Map<String, dynamic> _$$ApplicationResponseImplToJson(
        _$ApplicationResponseImpl instance) =>
    <String, dynamic>{
      'skills_met': instance.skillsMet,
      'optional_skills_met': instance.optionalSkillsMet,
      'notes': instance.notes,
    };

_$MatchStatsImpl _$$MatchStatsImplFromJson(Map<String, dynamic> json) =>
    _$MatchStatsImpl(
      requiredMatch: json['required_match'] as String,
      optionalMatch: (json['optional_match'] as num).toInt(),
      percentage: (json['percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$$MatchStatsImplToJson(_$MatchStatsImpl instance) =>
    <String, dynamic>{
      'required_match': instance.requiredMatch,
      'optional_match': instance.optionalMatch,
      'percentage': instance.percentage,
    };

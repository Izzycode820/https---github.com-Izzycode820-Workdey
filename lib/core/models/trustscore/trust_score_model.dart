// lib/core/models/trust/trust_score_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'trust_score_model.freezed.dart';
part 'trust_score_model.g.dart';

@freezed
class TrustScore with _$TrustScore {
  const TrustScore._();

  @JsonSerializable(explicitToJson: true)
  const factory TrustScore({
    @JsonKey(name: 'overall_score', defaultValue: 0.0) required double overallScore,
    @JsonKey(name: 'total_reviews', defaultValue: 0) required int totalReviews,
    @JsonKey(name: 'completed_jobs', defaultValue: 0) required int completedJobs,
    @JsonKey(name: 'completed_services', defaultValue: 0) required int completedServices,
    @JsonKey(name: 'job_performance_score', defaultValue: 0.0) required double jobPerformanceScore,
    @JsonKey(name: 'service_quality_score', defaultValue: 0.0) required double serviceQualityScore,
    @JsonKey(name: 'reliability_score', defaultValue: 0.0) required double reliabilityScore,
    @JsonKey(name: 'employer_satisfaction_score', defaultValue: 0.0) required double employerSatisfactionScore,
    @JsonKey(name: 'trust_level', defaultValue: 'NEWCOMER') required String trustLevel,
    @JsonKey(name: 'trust_level_display', defaultValue: 'Newcomer') required String trustLevelDisplay,
    @JsonKey(name: 'last_calculated') DateTime? lastCalculated,
  }) = _TrustScore;

  factory TrustScore.fromJson(Map<String, dynamic> json) => 
      _$TrustScoreFromJson(json);

  // Helper methods
  String get trustLevelEmoji {
    switch (trustLevel) {
      case 'NEWCOMER':
        return '🌱';
      case 'BUILDING':
        return '🌟';
      case 'TRUSTED':
        return '🏆';
      case 'EXPERT':
        return '👑';
      default:
        return '🌱';
    }
  }

  int get trustLevelProgress {
    switch (trustLevel) {
      case 'NEWCOMER':
        return 25;
      case 'BUILDING':
        return 50;
      case 'TRUSTED':
        return 75;
      case 'EXPERT':
        return 100;
      default:
        return 25;
    }
  }

  bool get isHighlyTrusted => ['TRUSTED', 'EXPERT'].contains(trustLevel);
  
  String get performanceLevel {
    if (overallScore >= 4.5) return 'Excellent';
    if (overallScore >= 4.0) return 'Very Good';
    if (overallScore >= 3.5) return 'Good';
    if (overallScore >= 3.0) return 'Average';
    return 'Building';
  }
}
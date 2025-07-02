// applicant_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'applicant_model.freezed.dart';
part 'applicant_model.g.dart';

@freezed
class Application with _$Application {
  const factory Application({
    required int id,
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'applied_at') required DateTime appliedAt,
    @JsonKey(name: 'applicant_details') required ApplicantDetails details,
    @JsonKey(name: 'response') required ApplicationResponse? response,
    @JsonKey(name: 'match_stats') MatchStats? matchStats,
  }) = _Application;

  factory Application.fromJson(Map<String, dynamic> json) => 
      _$ApplicationFromJson(json);
}

@freezed
class ApplicantDetails with _$ApplicantDetails {
  const factory ApplicantDetails({
    required String name,
  //  required String email,
   // required String phone,
    @JsonKey(defaultValue: 0) required int verification_level,
    @JsonKey(name: 'completed_jobs', defaultValue: 0) required int completedJobs,
  }) = _ApplicantDetails;

  factory ApplicantDetails.fromJson(Map<String, dynamic> json) => 
      _$ApplicantDetailsFromJson(json);
}

@freezed
class ApplicationResponse with _$ApplicationResponse {
  const factory ApplicationResponse({
    @JsonKey(name: 'skills_met') required List<String> skillsMet,
    @JsonKey(name: 'optional_skills_met') required List<String> optionalSkillsMet,
    required String notes,
  }) = _ApplicationResponse;

  factory ApplicationResponse.fromJson(Map<String, dynamic> json) => 
      _$ApplicationResponseFromJson(json);
}

@freezed
class MatchStats with _$MatchStats {
  const factory MatchStats({
    @JsonKey(name: 'required_match') required String requiredMatch,
    @JsonKey(name: 'optional_match') required int optionalMatch,
    required double percentage,
  }) = _MatchStats;

  factory MatchStats.fromJson(Map<String, dynamic> json) => 
      _$MatchStatsFromJson(json);
}
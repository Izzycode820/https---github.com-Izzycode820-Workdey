import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:workdey_frontend/core/models/profile/education/education_model.dart';
import 'package:workdey_frontend/core/models/profile/experience/experience_model.dart';
import 'package:workdey_frontend/core/models/profile/review/review_model.dart';
import 'package:workdey_frontend/core/models/profile/skills/skill_model.dart';
import 'package:workdey_frontend/core/models/user/user_model.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const UserProfile._();

  @JsonSerializable(explicitToJson: true)
  const factory UserProfile({
    int? id,
    required String bio,
    String? location,
    String? transport,
    required List<String> availability,
    @JsonKey(name: 'willing_to_learn') required bool willingToLearn,
    @JsonKey(name: 'rating', defaultValue: 0.0) required double rating,
    @JsonKey(name: 'jobs_completed', defaultValue: 0) required int jobsCompleted,
    @JsonKey(name: 'verification_badges') required Map<String, dynamic> verificationBadges,
    required User user,
    required List<Skill> skills,
    required List<Experience> experiences,
    required List<Education> educations,
    required List<Review> reviews,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _UserProfile;

   factory UserProfile.fromJson(Map<String, dynamic> json) => 
      _$UserProfileFromJson(json);
    
}
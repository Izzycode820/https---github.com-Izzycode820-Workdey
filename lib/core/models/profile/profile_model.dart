// lib/core/models/profile/profile_model.dart
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:workdey_frontend/core/models/profile/education/education_model.dart';
import 'package:workdey_frontend/core/models/profile/experience/experience_model.dart';
import 'package:workdey_frontend/core/models/profile/review/review_model.dart';
import 'package:workdey_frontend/core/models/profile/skills/skill_model.dart';
import 'package:workdey_frontend/core/models/trustscore/trust_score_model.dart';
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
    String? city,
    String? district,
    String? transport,
    required List<String> availability,
    @JsonKey(name: 'willing_to_learn') required bool willingToLearn,
    @JsonKey(name: 'rating', defaultValue: 0.0) required double rating,
    @JsonKey(name: 'jobs_completed', defaultValue: 0) required int jobsCompleted,
    @JsonKey(name: 'verification_badges') required Map<String, dynamic> verificationBadges,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    
    // User information
    required User user,
    
    // Trust system data
    @JsonKey(name: 'trust_score') TrustScore? trustScore,
    @JsonKey(name: 'recent_reviews') List<Review>? recentReviews,
    @JsonKey(name: 'review_summary') ReviewSummary? reviewSummary,
    
    // Profile components
    required List<Skill> skills,
    required List<Experience> experiences,
    required List<Education> educations,
    required List<Review> reviews,
    
    // Additional profile data
    @JsonKey(name: 'profile_completeness') int? profileCompleteness,
    @JsonKey(name: 'languages_spoken') List<String>? languagesSpoken,
    @JsonKey(name: 'preferred_job_types') List<String>? preferredJobTypes,
    @JsonKey(name: 'hourly_rate_min') double? hourlyRateMin,
    @JsonKey(name: 'hourly_rate_max') double? hourlyRateMax,
    @JsonKey(name: 'portfolio_links') List<String>? portfolioLinks,
    
    // Privacy settings
    @JsonKey(name: 'profile_visibility') String? profileVisibility,
    @JsonKey(name: 'show_contact_info') bool? showContactInfo,
    @JsonKey(name: 'show_location') bool? showLocation,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => 
      _$UserProfileFromJson(json);

  // Computed properties
  String get fullName => '${user.firstName ?? 'User'} ${user.lastName ?? ''}'.trim();
  
  String get displayLocation {
    if (city != null && district != null) {
      return '$district, $city';
    }
    return location ?? 'Location not set';
  }

  // Fixed verification level getter - use user.verificationLevelDisplay
  String get verificationLevelDisplay => user.verificationLevelDisplay;

  // Fixed verification badges getter - use user.verificationBadges
  List<String> get verificationBadgesList {
    final badges = <String>[];
    final badgeData = user.verificationBadges;
    if (badgeData?['email'] == true) badges.add('Email');
    if (badgeData?['phone'] == true) badges.add('Phone');
    if (badgeData?['id'] == true) badges.add('ID');
    return badges;
  }

  int get totalYearsExperience {
    if (experiences.isEmpty) return 0;
    
    int totalMonths = 0;
    for (final exp in experiences) {
      final start = exp.startDate;
      final end = exp.endDate ?? DateTime.now();
      final months = (end.year - start.year) * 12 + end.month - start.month;
      totalMonths += months.abs();
    }
    
    return (totalMonths / 12).round();
  }

  String get experienceLevel {
    final years = totalYearsExperience;
    if (years == 0) return 'Fresher';
    if (years <= 2) return 'Entry Level';
    if (years <= 5) return 'Experienced';
    if (years <= 10) return 'Senior';
    return 'Expert';
  }

  List<String> get topSkills {
    final advanced = skills.where((s) => s.proficiency == 'advanced').map((s) => s.name).toList();
    final intermediate = skills.where((s) => s.proficiency == 'intermediate').map((s) => s.name).toList();
    
    return [...advanced, ...intermediate].take(5).toList();
  }

  String get availabilityDisplay {
    if (availability.isEmpty) return 'Not specified';
    return availability.join(', ');
  }

  double get profileCompletenessScore {
    if (profileCompleteness != null) return profileCompleteness! / 100.0;
    
    int score = 0;
    const totalSections = 8;
    
    // Basic info (20%)
    if (bio.isNotEmpty && bio.length > 50) score += 1;
    
    // Location (10%)
    if (location != null && location!.isNotEmpty) score += 1;
    
    // Skills (15%)
    if (skills.isNotEmpty) score += 1;
    
    // Experience (15%)
    if (experiences.isNotEmpty) score += 1;
    
    // Education (10%)
    if (educations.isNotEmpty) score += 1;
    
    // Verification (15%)
    if (verificationBadgesList.length >= 2) score += 1;
    
    // Reviews (10%)
    if (reviews.isNotEmpty) score += 1;
    
    // Availability (5%)
    if (availability.isNotEmpty) score += 1;
    
    return score / totalSections;
  }

  List<String> get missingProfileSections {
    final missing = <String>[];
    
    if (bio.isEmpty || bio.length < 50) missing.add('Professional Bio');
    if (location == null || location!.isEmpty) missing.add('Location');
    if (skills.isEmpty) missing.add('Skills');
    if (experiences.isEmpty) missing.add('Work Experience');
    if (educations.isEmpty) missing.add('Education');
    if (verificationBadgesList.length < 2) missing.add('Verification');
    if (availability.isEmpty) missing.add('Availability');
    
    return missing;
  }

  bool get isProfileComplete => profileCompletenessScore >= 0.8;
  
  // Fixed canReceiveJobs - use user.verificationLevel (int)
  bool get canReceiveJobs => isProfileComplete && user.verificationLevel >= 2;
  
  String get trustBadge {
    if (trustScore == null) return '';
    return trustScore!.trustLevelEmoji;
  }

  String get professionalSummary {
    final parts = <String>[];
    
    // Experience
    if (totalYearsExperience > 0) {
      parts.add('$totalYearsExperience years experience');
    }
    
    // Trust level
    if (trustScore != null) {
      parts.add(trustScore!.trustLevelDisplay.toLowerCase());
    }
    
    // Job completion
    if (jobsCompleted > 0) {
      parts.add('$jobsCompleted jobs completed');
    }
    
    // Rating
    if (rating > 0) {
      parts.add('${rating.toStringAsFixed(1)} ⭐ rating');
    }
    
    return parts.join(' • ');
  }
}
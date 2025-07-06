// lib/core/providers/profile_provider.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/profile/education/education_model.dart';
import 'package:workdey_frontend/core/models/profile/experience/experience_model.dart';
import 'package:workdey_frontend/core/models/profile/profile_model.dart';
import 'package:workdey_frontend/core/models/profile/review/review_model.dart';
import 'package:workdey_frontend/core/models/profile/skills/skill_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/models/trustscore/trust_score_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/profile_service.dart';

// ========== SERVICE PROVIDER ==========
final profileServiceProvider = Provider<ProfileService>((ref) {
  return ProfileService(ref.read(dioProvider));
});

// ========== MAIN PROFILE PROVIDER ==========
final profileProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<UserProfile>>((ref) {
  return ProfileNotifier(ref.read(profileServiceProvider));
});

class ProfileNotifier extends StateNotifier<AsyncValue<UserProfile>> {
  final ProfileService _profileService;

  ProfileNotifier(this._profileService) : super(const AsyncValue.loading()) {
    loadProfile();
  }

  /// Load user's complete profile
  Future<void> loadProfile({bool forceRefresh = false}) async {
    try {
      if (!forceRefresh && state.hasValue) return;
      
      state = const AsyncValue.loading();
      final profile = await _profileService.getMyProfile();
      state = AsyncValue.data(profile);
      debugPrint('✅ Profile loaded successfully');
    } catch (e, st) {
      debugPrint('❌ Profile loading error: $e');
      state = AsyncValue.error(_profileService.getErrorMessage(e as DioException), st);
    }
  }

  /// Update basic profile information
  Future<void> updateProfile(Map<String, dynamic> data) async {
    try {
      state = const AsyncValue.loading();
      final updatedProfile = await _profileService.updateMyProfile(data);
      state = AsyncValue.data(updatedProfile);
      debugPrint('✅ Profile updated successfully');
    } catch (e, st) {
      debugPrint('❌ Profile update error: $e');
      state = AsyncValue.error(_profileService.getErrorMessage(e as DioException), st);
      rethrow;
    }
  }

  /// Upload profile picture
  Future<void> uploadProfilePicture(String imagePath) async {
    try {
      final currentProfile = state.value;
      if (currentProfile == null) throw Exception('No profile data available');

      state = const AsyncValue.loading();
      
      final imageUrl = await _profileService.uploadProfilePicture(imagePath);
      
      // Update the profile with new image URL
      final updatedUser = currentProfile.user.copyWith(profilePicture: imageUrl);
      final updatedProfile = currentProfile.copyWith(user: updatedUser);
      
      state = AsyncValue.data(updatedProfile);
      debugPrint('✅ Profile picture uploaded successfully');
    } catch (e, st) {
      debugPrint('❌ Profile picture upload error: $e');
      // Restore previous state on error
      state = AsyncValue.error(_profileService.getErrorMessage(e as DioException), st);
      rethrow;
    }
  }

  /// Get profile completeness analysis
  Future<Map<String, dynamic>> getCompleteness() async {
    try {
      return await _profileService.getProfileCompleteness();
    } catch (e) {
      debugPrint('❌ Profile completeness error: $e');
      return {
        'completeness_score': 0,
        'missing_sections': ['Unable to load'],
        'suggestions': ['Check your internet connection']
      };
    }
  }

  /// Refresh profile data
  Future<void> refresh() => loadProfile(forceRefresh: true);

  /// Clear profile cache
  void clearCache() {
    _profileService.clearCache();
    state = const AsyncValue.loading();
  }
}

// ========== SKILLS PROVIDER ==========
final skillsProvider = StateNotifierProvider<SkillsNotifier, AsyncValue<List<Skill>>>((ref) {
  return SkillsNotifier(ref.read(profileServiceProvider));
});

class SkillsNotifier extends StateNotifier<AsyncValue<List<Skill>>> {
  final ProfileService _profileService;

  SkillsNotifier(this._profileService) : super(const AsyncValue.loading()) {
    loadSkills();
  }

  Future<void> loadSkills() async {
    try {
      state = const AsyncValue.loading();
      final skills = await _profileService.getMySkills();
      state = AsyncValue.data(skills);
    } catch (e, st) {
      debugPrint('❌ Skills loading error: $e');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addSkill(Map<String, dynamic> skillData) async {
    try {
      final newSkill = await _profileService.addSkill(skillData);
      final currentSkills = state.value ?? [];
      state = AsyncValue.data([...currentSkills, newSkill]);
    } catch (e, st) {
      debugPrint('❌ Add skill error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updateSkill(int skillId, Map<String, dynamic> skillData) async {
    try {
      final updatedSkill = await _profileService.updateSkill(skillId, skillData);
      final currentSkills = state.value ?? [];
      final updatedSkills = currentSkills.map((skill) {
        return skill.id == skillId ? updatedSkill : skill;
      }).toList();
      state = AsyncValue.data(updatedSkills);
    } catch (e, st) {
      debugPrint('❌ Update skill error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> deleteSkill(int skillId) async {
    try {
      await _profileService.deleteSkill(skillId);
      final currentSkills = state.value ?? [];
      final updatedSkills = currentSkills.where((skill) => skill.id != skillId).toList();
      state = AsyncValue.data(updatedSkills);
    } catch (e, st) {
      debugPrint('❌ Delete skill error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> refresh() => loadSkills();
}

// ========== EXPERIENCE PROVIDER ==========
final experienceProvider = StateNotifierProvider<ExperienceNotifier, AsyncValue<List<Experience>>>((ref) {
  return ExperienceNotifier(ref.read(profileServiceProvider));
});

class ExperienceNotifier extends StateNotifier<AsyncValue<List<Experience>>> {
  final ProfileService _profileService;

  ExperienceNotifier(this._profileService) : super(const AsyncValue.loading()) {
    loadExperiences();
  }

  Future<void> loadExperiences() async {
    try {
      state = const AsyncValue.loading();
      final experiences = await _profileService.getMyExperiences();
      state = AsyncValue.data(experiences);
    } catch (e, st) {
      debugPrint('❌ Experience loading error: $e');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addExperience(Map<String, dynamic> experienceData) async {
    try {
      final newExperience = await _profileService.addExperience(experienceData);
      final currentExperiences = state.value ?? [];
      state = AsyncValue.data([...currentExperiences, newExperience]);
    } catch (e, st) {
      debugPrint('❌ Add experience error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updateExperience(int experienceId, Map<String, dynamic> experienceData) async {
    try {
      final updatedExperience = await _profileService.updateExperience(experienceId, experienceData);
      final currentExperiences = state.value ?? [];
      final updatedExperiences = currentExperiences.map((experience) {
        return experience.id == experienceId ? updatedExperience : experience;
      }).toList();
      state = AsyncValue.data(updatedExperiences);
    } catch (e, st) {
      debugPrint('❌ Update experience error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> deleteExperience(int experienceId) async {
    try {
      await _profileService.deleteExperience(experienceId);
      final currentExperiences = state.value ?? [];
      final updatedExperiences = currentExperiences.where((exp) => exp.id != experienceId).toList();
      state = AsyncValue.data(updatedExperiences);
    } catch (e, st) {
      debugPrint('❌ Delete experience error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> refresh() => loadExperiences();
}

// ========== EDUCATION PROVIDER ==========
final educationProvider = StateNotifierProvider<EducationNotifier, AsyncValue<List<Education>>>((ref) {
  return EducationNotifier(ref.read(profileServiceProvider));
});

class EducationNotifier extends StateNotifier<AsyncValue<List<Education>>> {
  final ProfileService _profileService;

  EducationNotifier(this._profileService) : super(const AsyncValue.loading()) {
    loadEducations();
  }

  Future<void> loadEducations() async {
    try {
      state = const AsyncValue.loading();
      final educations = await _profileService.getMyEducations();
      state = AsyncValue.data(educations);
    } catch (e, st) {
      debugPrint('❌ Education loading error: $e');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addEducation(Map<String, dynamic> educationData) async {
    try {
      final newEducation = await _profileService.addEducation(educationData);
      final currentEducations = state.value ?? [];
      state = AsyncValue.data([...currentEducations, newEducation]);
    } catch (e, st) {
      debugPrint('❌ Add education error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updateEducation(int educationId, Map<String, dynamic> educationData) async {
    try {
      final updatedEducation = await _profileService.updateEducation(educationId, educationData);
      final currentEducations = state.value ?? [];
      final updatedEducations = currentEducations.map((education) {
        return education.id == educationId ? updatedEducation : education;
      }).toList();
      state = AsyncValue.data(updatedEducations);
    } catch (e, st) {
      debugPrint('❌ Update education error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> deleteEducation(int educationId) async {
    try {
      await _profileService.deleteEducation(educationId);
      final currentEducations = state.value ?? [];
      final updatedEducations = currentEducations.where((edu) => edu.id != educationId).toList();
      state = AsyncValue.data(updatedEducations);
    } catch (e, st) {
      debugPrint('❌ Delete education error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> refresh() => loadEducations();
}

// ========== TRUST SCORE PROVIDER ==========
final trustScoreProvider = StateNotifierProvider<TrustScoreNotifier, AsyncValue<TrustScore>>((ref) {
  return TrustScoreNotifier(ref.read(profileServiceProvider));
});

class TrustScoreNotifier extends StateNotifier<AsyncValue<TrustScore>> {
  final ProfileService _profileService;

  TrustScoreNotifier(this._profileService) : super(const AsyncValue.loading()) {
    loadTrustScore();
  }

  Future<void> loadTrustScore() async {
    try {
      state = const AsyncValue.loading();
      final trustScore = await _profileService.getMyTrustScore();
      state = AsyncValue.data(trustScore);
    } catch (e, st) {
      debugPrint('❌ Trust score loading error: $e');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => loadTrustScore();
}

// ========== REVIEWS PROVIDER ==========
final reviewsReceivedProvider = StateNotifierProvider<ReviewsReceivedNotifier, AsyncValue<PaginatedResponse<Review>>>((ref) {
  return ReviewsReceivedNotifier(ref.read(profileServiceProvider));
});

class ReviewsReceivedNotifier extends StateNotifier<AsyncValue<PaginatedResponse<Review>>> {
  final ProfileService _profileService;
  int _currentPage = 1;

  ReviewsReceivedNotifier(this._profileService) : super(const AsyncValue.loading()) {
    loadReviews();
  }

  Future<void> loadReviews({bool forceRefresh = false}) async {
    try {
      if (forceRefresh) _currentPage = 1;
      
      state = const AsyncValue.loading();
      final reviews = await _profileService.getReviewsReceived(page: _currentPage);
      state = AsyncValue.data(reviews);
    } catch (e, st) {
      debugPrint('❌ Reviews loading error: $e');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadMore() async {
    final currentData = state.value;
    if (currentData == null || currentData.next == null) return;

    try {
      _currentPage++;
      final newReviews = await _profileService.getReviewsReceived(page: _currentPage);
      
      state = AsyncValue.data(
        PaginatedResponse<Review>(
          count: newReviews.count,
          results: [...currentData.results, ...newReviews.results],
          next: newReviews.next,
          previous: newReviews.previous,
        ),
      );
    } catch (e, st) {
      debugPrint('❌ Load more reviews error: $e');
      _currentPage--; // Revert page increment on error
    }
  }

  Future<void> refresh() => loadReviews(forceRefresh: true);
}

// ========== PUBLIC PROFILE PROVIDER ==========
final publicProfileProvider = StateNotifierProvider.family<PublicProfileNotifier, AsyncValue<UserProfile>, int>((ref, userId) {
  return PublicProfileNotifier(ref.read(profileServiceProvider), userId);
});

class PublicProfileNotifier extends StateNotifier<AsyncValue<UserProfile>> {
  final ProfileService _profileService;
  final int userId;

  PublicProfileNotifier(this._profileService, this.userId) : super(const AsyncValue.loading()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      state = const AsyncValue.loading();
      final profile = await _profileService.getProfileById(userId);
      state = AsyncValue.data(profile);
    } catch (e, st) {
      debugPrint('❌ Public profile loading error: $e');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => loadProfile();
}

// ========== CONVENIENCE PROVIDERS ==========

/// Get current user's profile completeness score
final profileCompletenessProvider = FutureProvider<double>((ref) async {
  final profile = ref.watch(profileProvider).value;
  return profile?.profileCompletenessScore ?? 0.0;
});

/// Check if profile can receive jobs
final canReceiveJobsProvider = Provider<bool>((ref) {
  final profile = ref.watch(profileProvider).value;
  return profile?.canReceiveJobs ?? false;
});

/// Get trust level emoji
final trustLevelEmojiProvider = Provider<String>((ref) {
  final profile = ref.watch(profileProvider).value;
  return profile?.trustScore?.trustLevelEmoji ?? '🌱';
});

/// Get professional summary
final professionalSummaryProvider = Provider<String>((ref) {
  final profile = ref.watch(profileProvider).value;
  return profile?.professionalSummary ?? 'Complete your profile to see summary';
});
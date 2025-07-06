// lib/core/services/profile_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:workdey_frontend/core/models/profile/education/education_model.dart';
import 'package:workdey_frontend/core/models/profile/experience/experience_model.dart';
import 'package:workdey_frontend/core/models/profile/profile_model.dart';
import 'package:workdey_frontend/core/models/profile/review/review_model.dart';
import 'package:workdey_frontend/core/models/profile/skills/skill_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/models/trustscore/trust_score_model.dart';

class ProfileService {
  final Dio _dio;

  ProfileService(this._dio);

  // ========== PROFILE MANAGEMENT ==========
  
  /// Get current user's complete profile with trust data
  Future<UserProfile> getMyProfile() async {
    try {
      // Try the enhanced trust profile endpoint first
      final response = await _dio.get('/api/user/trust-profile/me/');
      debugPrint('✅ Trust Profile Response: ${response.data}');
      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        // Fallback to basic profile endpoint
        try {
          final response = await _dio.get('/api/profiles/profiles/me/');
          debugPrint('✅ Basic Profile Response: ${response.data}');
          return UserProfile.fromJson(response.data);
        } catch (fallbackError) {
          debugPrint('❌ Profile Fallback Error: $fallbackError');
          rethrow;
        }
      }
      debugPrint('❌ Profile Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Update current user's profile
  Future<UserProfile> updateMyProfile(Map<String, dynamic> data) async {
    try {
      final response = await _dio.patch('/api/profiles/profiles/me/', data: data);
      debugPrint('✅ Update Profile Response: ${response.data}');
      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Update Profile Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Get public profile by user ID
  Future<UserProfile> getProfileById(int userId) async {
    try {
      final response = await _dio.get('/api/user/trust-profile/$userId/');
      debugPrint('✅ Public Profile Response: ${response.data}');
      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Public Profile Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Get profile completeness analysis
  Future<Map<String, dynamic>> getProfileCompleteness() async {
    try {
      final response = await _dio.get('/api/profiles/profiles/completeness/');
      return response.data;
    } on DioException catch (e) {
      debugPrint('❌ Profile Completeness Error: ${e.response?.data}');
      return {
        'completeness_score': 0,
        'missing_sections': ['Unable to load'],
        'suggestions': ['Check your internet connection']
      };
    }
  }

  // ========== SKILLS MANAGEMENT ==========
  
  /// Get user's skills
  Future<List<Skill>> getMySkills() async {
    try {
      final response = await _dio.get('/api/profiles/skills/');
      return (response.data as List)
          .map((json) => Skill.fromJson(json))
          .toList();
    } on DioException catch (e) {
      debugPrint('❌ Skills Error: ${e.response?.data}');
      return [];
    }
  }

  /// Add a new skill
  Future<Skill> addSkill(Map<String, dynamic> skillData) async {
    try {
      final response = await _dio.post('/api/profiles/skills/', data: skillData);
      return Skill.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Add Skill Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Update a skill
  Future<Skill> updateSkill(int skillId, Map<String, dynamic> skillData) async {
    try {
      final response = await _dio.patch('/api/profiles/skills/$skillId/', data: skillData);
      return Skill.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Update Skill Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Delete a skill
  Future<void> deleteSkill(int skillId) async {
    try {
      await _dio.delete('/api/profiles/skills/$skillId/');
    } on DioException catch (e) {
      debugPrint('❌ Delete Skill Error: ${e.response?.data}');
      rethrow;
    }
  }

  // ========== EXPERIENCE MANAGEMENT ==========
  
  /// Get user's work experiences
  Future<List<Experience>> getMyExperiences() async {
    try {
      final response = await _dio.get('/api/profiles/experiences/');
      return (response.data as List)
          .map((json) => Experience.fromJson(json))
          .toList();
    } on DioException catch (e) {
      debugPrint('❌ Experiences Error: ${e.response?.data}');
      return [];
    }
  }

  /// Add new work experience
  Future<Experience> addExperience(Map<String, dynamic> experienceData) async {
    try {
      final response = await _dio.post('/api/profiles/experiences/', data: experienceData);
      return Experience.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Add Experience Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Update work experience
  Future<Experience> updateExperience(int experienceId, Map<String, dynamic> experienceData) async {
    try {
      final response = await _dio.patch('/api/profiles/experiences/$experienceId/', data: experienceData);
      return Experience.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Update Experience Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Delete work experience
  Future<void> deleteExperience(int experienceId) async {
    try {
      await _dio.delete('/api/profiles/experiences/$experienceId/');
    } on DioException catch (e) {
      debugPrint('❌ Delete Experience Error: ${e.response?.data}');
      rethrow;
    }
  }

  // ========== EDUCATION MANAGEMENT ==========
  
  /// Get user's education records
  Future<List<Education>> getMyEducations() async {
    try {
      final response = await _dio.get('/api/profiles/educations/');
      return (response.data as List)
          .map((json) => Education.fromJson(json))
          .toList();
    } on DioException catch (e) {
      debugPrint('❌ Educations Error: ${e.response?.data}');
      return [];
    }
  }

  /// Add new education record
  Future<Education> addEducation(Map<String, dynamic> educationData) async {
    try {
      final response = await _dio.post('/api/profiles/educations/', data: educationData);
      return Education.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Add Education Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Update education record
  Future<Education> updateEducation(int educationId, Map<String, dynamic> educationData) async {
    try {
      final response = await _dio.patch('/api/profiles/educations/$educationId/', data: educationData);
      return Education.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Update Education Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Delete education record
  Future<void> deleteEducation(int educationId) async {
    try {
      await _dio.delete('/api/profiles/educations/$educationId/');
    } on DioException catch (e) {
      debugPrint('❌ Delete Education Error: ${e.response?.data}');
      rethrow;
    }
  }

  // ========== REVIEWS MANAGEMENT ==========
  
  /// Get reviews received by user
  Future<PaginatedResponse<Review>> getReviewsReceived({int page = 1}) async {
    try {
      final response = await _dio.get('/api/profiles/reviews/my-received/', 
        queryParameters: {'page': page});
      return PaginatedResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => Review.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      debugPrint('❌ Reviews Received Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Get reviews given by user
  Future<PaginatedResponse<Review>> getReviewsGiven({int page = 1}) async {
    try {
      final response = await _dio.get('/api/profiles/reviews/my-given/', 
        queryParameters: {'page': page});
      return PaginatedResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => Review.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      debugPrint('❌ Reviews Given Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Get reviews for a specific user
  Future<PaginatedResponse<Review>> getReviewsForUser(int userId, {int page = 1}) async {
    try {
      final response = await _dio.get('/api/profiles/reviews/for-user/', 
        queryParameters: {'user_id': userId, 'page': page});
      return PaginatedResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => Review.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      debugPrint('❌ Reviews For User Error: ${e.response?.data}');
      rethrow;
    }
  }

  // ========== TRUST SCORE MANAGEMENT ==========
  
  /// Get current user's trust score
  Future<TrustScore> getMyTrustScore() async {
    try {
      final response = await _dio.get('/api/profiles/trust-scores/my-score/');
      return TrustScore.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Trust Score Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Get trust score for specific user
  Future<TrustScore> getTrustScoreForUser(int userId) async {
    try {
      final response = await _dio.get('/api/profiles/trust-scores/for-user/', 
        queryParameters: {'user_id': userId});
      return TrustScore.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ User Trust Score Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Get trust leaderboard
  Future<List<Map<String, dynamic>>> getTrustLeaderboard({
    String? category,
    int limit = 10,
  }) async {
    try {
      final queryParams = <String, dynamic>{'limit': limit};
      if (category != null) queryParams['category'] = category;
      
      final response = await _dio.get('/api/profiles/trust-scores/leaderboard/', 
        queryParameters: queryParams);
      return List<Map<String, dynamic>>.from(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Trust Leaderboard Error: ${e.response?.data}');
      return [];
    }
  }

  // ========== ANALYTICS ==========
  
  /// Get trust analytics for the community
  Future<Map<String, dynamic>> getTrustAnalytics() async {
    try {
      final response = await _dio.get('/api/profiles/trust-analytics/');
      return response.data;
    } on DioException catch (e) {
      debugPrint('❌ Trust Analytics Error: ${e.response?.data}');
      return {};
    }
  }

  // ========== PROFILE PICTURE UPLOAD ==========
  
  /// Upload profile picture
  Future<String> uploadProfilePicture(String imagePath) async {
    try {
      final formData = FormData.fromMap({
        'profile_picture': await MultipartFile.fromFile(imagePath),
      });
      
      final response = await _dio.patch('/api/user/profile/picture/', data: formData);
      return response.data['profile_picture_url'] ?? '';
    } on DioException catch (e) {
      debugPrint('❌ Profile Picture Upload Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Upload profile picture from bytes
  Future<String> uploadProfilePictureFromBytes(List<int> bytes, String fileName) async {
    try {
      final formData = FormData.fromMap({
        'profile_picture': MultipartFile.fromBytes(bytes, filename: fileName),
      });
      
      final response = await _dio.patch('/api/user/profile/picture/', data: formData);
      return response.data['profile_picture_url'] ?? '';
    } on DioException catch (e) {
      debugPrint('❌ Profile Picture Upload Error: ${e.response?.data}');
      rethrow;
    }
  }

  // ========== VERIFICATION ==========
  
  /// Get verification status
  Future<Map<String, dynamic>> getVerificationStatus() async {
    try {
      final response = await _dio.get('/api/user/verification/status/');
      return response.data;
    } on DioException catch (e) {
      debugPrint('❌ Verification Status Error: ${e.response?.data}');
      return {};
    }
  }

  /// Request email verification
  Future<bool> requestEmailVerification() async {
    try {
      await _dio.post('/api/user/verification/email/request/');
      return true;
    } on DioException catch (e) {
      debugPrint('❌ Email Verification Request Error: ${e.response?.data}');
      return false;
    }
  }

  /// Request phone verification
  Future<bool> requestPhoneVerification(String phoneNumber) async {
    try {
      await _dio.post('/api/user/verification/phone/request/', 
        data: {'phone': phoneNumber});
      return true;
    } on DioException catch (e) {
      debugPrint('❌ Phone Verification Request Error: ${e.response?.data}');
      return false;
    }
  }

  /// Verify phone with OTP
  Future<bool> verifyPhoneOTP(String otp) async {
    try {
      await _dio.post('/api/user/verification/phone/verify/', 
        data: {'otp': otp});
      return true;
    } on DioException catch (e) {
      debugPrint('❌ Phone OTP Verification Error: ${e.response?.data}');
      return false;
    }
  }

  // ========== PRIVACY SETTINGS ==========
  
  /// Update privacy settings
  Future<void> updatePrivacySettings(Map<String, dynamic> settings) async {
    try {
      await _dio.patch('/api/profiles/profiles/privacy/', data: settings);
    } on DioException catch (e) {
      debugPrint('❌ Privacy Settings Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Get privacy settings
  Future<Map<String, dynamic>> getPrivacySettings() async {
    try {
      final response = await _dio.get('/api/profiles/profiles/privacy/');
      return response.data;
    } on DioException catch (e) {
      debugPrint('❌ Get Privacy Settings Error: ${e.response?.data}');
      return {
        'profile_visibility': 'public',
        'show_contact_info': true,
        'show_location': true,
      };
    }
  }

  // ========== SEARCH & DISCOVERY ==========
  
  /// Search profiles
  Future<PaginatedResponse<UserProfile>> searchProfiles({
    String? query,
    String? location,
    List<String>? skills,
    int? minRating,
    String? trustLevel,
    int page = 1,
  }) async {
    try {
      final queryParams = <String, dynamic>{'page': page};
      
      if (query != null && query.isNotEmpty) queryParams['search'] = query;
      if (location != null) queryParams['location'] = location;
      if (skills != null && skills.isNotEmpty) queryParams['skills'] = skills.join(',');
      if (minRating != null) queryParams['min_rating'] = minRating;
      if (trustLevel != null) queryParams['trust_level'] = trustLevel;
      
      final response = await _dio.get('/api/profiles/profiles/search/', 
        queryParameters: queryParams);
      return PaginatedResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => UserProfile.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      debugPrint('❌ Profile Search Error: ${e.response?.data}');
      rethrow;
    }
  }

  // ========== CACHE MANAGEMENT ==========
  
  /// Clear profile cache (force refresh on next load)
  void clearCache() {
    // Implementation would depend on your caching strategy
    debugPrint('🗑️ Profile cache cleared');
  }

  // ========== ERROR HANDLING ==========
  
  /// Handle common profile errors
  String getErrorMessage(DioException error) {
    if (error.response == null) {
      return 'Network error. Please check your connection.';
    }
    
    switch (error.response!.statusCode) {
      case 400:
        return 'Invalid data provided. Please check your inputs.';
      case 401:
        return 'Please log in to access your profile.';
      case 403:
        return 'You don\'t have permission to perform this action.';
      case 404:
        return 'Profile not found.';
      case 409:
        return 'This information conflicts with existing data.';
      case 422:
        final data = error.response!.data;
        if (data is Map && data.containsKey('detail')) {
          return data['detail'].toString();
        }
        return 'Validation error. Please check your inputs.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
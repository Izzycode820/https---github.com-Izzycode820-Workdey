import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:workdey_frontend/core/models/profile/education/education_model.dart';
import 'package:workdey_frontend/core/models/profile/experience/experience_model.dart';
import 'package:workdey_frontend/core/models/profile/profile_model.dart';
import 'package:workdey_frontend/core/models/profile/review/review_model.dart';
import 'package:workdey_frontend/core/models/profile/skills/skill_model.dart';

class ProfileService {
  final Dio _dio;

  ProfileService(this._dio);

  // Get current user's profile
  Future<UserProfile> getMyProfile() async {
    try {
      final response = await _dio.get('/api/profiles/profiles/me/');
      debugPrint('Profile Response: ${response.data}');
      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Profile Error: ${e.response?.data}');
      rethrow;
    }
  }

  // Update current user's profile
  Future<UserProfile> updateMyProfile(Map<String, dynamic> data) async {
    try {
      final response = await _dio.patch('/api/profiles/profiles/me/', data: data);
      debugPrint('Update Profile Response: ${response.data}');
      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Update Profile Error: ${e.response?.data}');
      rethrow;
    }
  }

  // Get specific profile by ID
  Future<UserProfile> getProfileById(int id) async {
    try {
      final response = await _dio.get('/api/profiles/profiles/$id/');
      debugPrint('Profile by ID Response: ${response.data}');
      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Profile by ID Error: ${e.response?.data}');
      rethrow;
    }
  }

  // Add this new method for public profiles
  Future<UserProfile> getPublicProfile(int id) async {
    try {
      final response = await _dio.get('/api/profiles/profiles/$id/');
      debugPrint('Public Profile Response: ${response.data}');
      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Public Profile Error: ${e.response?.data}');
      rethrow;
    }
  }

  Future<List<Skill>> getSkills() async {
    try {
      final response = await _dio.get('/api/profiles/skills/');
      debugPrint('Skills Response: ${response.data}');
      return (response.data as List).map((skill) => Skill.fromJson(skill)).toList();
    } on DioException catch (e) {
      debugPrint('Skills Error: ${e.response?.data}');
      rethrow;
    }
  }

  Future<Skill> addSkill(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/profile/skills/', data: data);
      debugPrint('Add Skill Response: ${response.data}');
      return Skill.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Add Skill Error: ${e.response?.data}');
      throw Exception('Failed to add skill: ${e.message}');
    }
  }

  Future<void> deleteSkill(int id) async {
    try {
      await _dio.delete('/api/profile/skills/$id/');
      debugPrint('Delete Skill Success: Skill ID $id deleted');
    } on DioException catch (e) {
      debugPrint('Delete Skill Error: ${e.response?.data}');
      rethrow;
    }
  }

  // Experience methods
  Future<List<Experience>> getExperiences() async {
    try {
      final response = await _dio.get('/api/profiles/experiences/');
      debugPrint('Experiences Response: ${response.data}');
      return (response.data as List).map((e) => Experience.fromJson(e)).toList();
    } on DioException catch (e) {
      debugPrint('Experiences Error: ${e.response?.data}');
      rethrow;
    }
  }

  Future<Experience> addExperience(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/profiles/experiences/', data: data);
      debugPrint('Add Experience Response: ${response.data}');
      return Experience.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Add Experience Error: ${e.response?.data}');
      rethrow;
    }
  }

  Future<void> deleteExperience(int id) async {
    try {
      await _dio.delete('/api/profiles/experiences/$id/');
      debugPrint('Delete Experience Success: Experience ID $id deleted');
    } on DioException catch (e) {
      debugPrint('Delete Experience Error: ${e.response?.data}');
      rethrow;
    }
  }

  // Education methods
  Future<List<Education>> getEducations() async {
    try {
      final response = await _dio.get('/api/profiles/educations/');
      debugPrint('Educations Response: ${response.data}');
      return (response.data as List).map((e) => Education.fromJson(e)).toList();
    } on DioException catch (e) {
      debugPrint('Educations Error: ${e.response?.data}');
      rethrow;
    }
  }

  Future<Education> addEducation(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/profiles/educations/', data: data);
      debugPrint('Add Education Response: ${response.data}');
      return Education.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Add Education Error: ${e.response?.data}');
      rethrow;
    }
  }

  Future<void> deleteEducation(int id) async {
    try {
      await _dio.delete('/api/profiles/educations/$id/');
      debugPrint('Delete Education Success: Education ID $id deleted');
    } on DioException catch (e) {
      debugPrint('Delete Education Error: ${e.response?.data}');
      rethrow;
    }
  }

  // Add review-related methods
  Future<List<Review>> getReviews(int userId) async {
    try {
      final response = await _dio.get('/api/profiles/reviews/?user=$userId');
      debugPrint('Reviews Response: ${response.data}');
      return (response.data as List).map((e) => Review.fromJson(e)).toList();
    } on DioException catch (e) {
      debugPrint('Reviews Error: ${e.response?.data}');
      rethrow;
    }
  }

  Future<Review> addReview(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/profiles/reviews/', data: data);
      debugPrint('Add Review Response: ${response.data}');
      return Review.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Add Review Error: ${e.response?.data}');
      rethrow;
    }
  }

  Future<void> verifyEmail() async {
    try {
      await _dio.post('/profiles/verify-email/');
      debugPrint('Verify Email Success');
    } on DioException catch (e) {
      debugPrint('Verify Email Error: ${e.response?.data}');
      rethrow;
    }
  }

  Future<void> verifyPhone() async {
    try {
      await _dio.post('/api/verification/verify-phone/');
      debugPrint('Verify Phone Success');
    } on DioException catch (e) {
      debugPrint('Verify Phone Error: ${e.response?.data}');
      rethrow;
    }
  }

  Future<void> updatePrivacySettings(Map<String, dynamic> settings) async {
    try {
      await _dio.patch('/api/profiles/profiles/me/', data: {
        'privacy_settings': settings
      });
      debugPrint('Update Privacy Settings Success');
    } on DioException catch (e) {
      debugPrint('Update Privacy Settings Error: ${e.response?.data}');
      rethrow;
    }
  }
}
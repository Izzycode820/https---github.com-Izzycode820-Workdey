// enhanced_login_service.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workdey_frontend/core/models/login/login_model.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/api/auth/login/',
        data: jsonEncode({'email': email, 'password': password}),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      
      final authResponse = AuthResponse.fromJson(response.data);
      debugPrint("💾 Storing tokens...");
      
      // Get storage instance
      const storage = FlutterSecureStorage();
      
      // Store tokens with explicit awaits
      await storage.write(key: 'access_token', value: authResponse.access);
      await storage.write(key: 'refresh_token', value: authResponse.refresh);
      
      // Store additional metadata for better session management
      await storage.write(key: 'login_timestamp', value: DateTime.now().toIso8601String());
      
      // Immediate verification
      final storedAccess = await storage.read(key: 'access_token');
      debugPrint("🔐 Storage verification: ${storedAccess != null ? "SUCCESS" : "FAILED"}");
      
      return authResponse;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['detail'] ?? 
        e.message ?? 
        'Login failed. Please try again.'
      );
    }
  }

  /// NEW: Validate if a token is still valid
  Future<bool> validateToken(String token) async {
    try {
      debugPrint("🔍 Validating token...");
      
      // Make a lightweight API call to check token validity
      // You should create this endpoint in your Django backend: /api/auth/verify/
      final response = await _dio.get(
        '/api/auth/verify/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      
      debugPrint("✅ Token validation successful");
      return response.statusCode == 200;
      
    } on DioException catch (e) {
      debugPrint("❌ Token validation failed: ${e.response?.statusCode}");
      
      // Token is invalid if we get 401 or 403
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        return false;
      }
      
      // For other errors (network issues, etc.), assume token might still be valid
      // This prevents unnecessary logouts due to temporary network issues
      return true;
    } catch (e) {
      debugPrint("❌ Token validation error: $e");
      return false;
    }
  }

  Future<void> logout() async {
    try {
      // The interceptor will add the refresh token to the body
      await _dio.post(
        '/api/auth/logout/',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      
      // Clear tokens after successful logout
      const storage = FlutterSecureStorage();
      await storage.delete(key: 'access_token');
      await storage.delete(key: 'refresh_token');
      await storage.delete(key: 'login_timestamp');
      debugPrint('✅ Logout successful - tokens cleared');
    } on DioException catch (e) {
      debugPrint('❌ Logout failed: ${e.message}');
      rethrow;
    }
  }

  Future<AuthResponse> refreshToken(String refreshToken) async {
    try {
      debugPrint("🔄 Refreshing token...");
      
      final response = await _dio.post(
        '/api/auth/refresh/',
        data: jsonEncode({'refresh': refreshToken}),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      
      final authResponse = AuthResponse.fromJson(response.data as Map<String, dynamic>);
      
      // Update stored tokens
      const storage = FlutterSecureStorage();
      await storage.write(key: 'access_token', value: authResponse.access);
      
      // Update refresh token if provided (some APIs return new refresh tokens)
      if (authResponse.refresh.isNotEmpty) {
        await storage.write(key: 'refresh_token', value: authResponse.refresh);
      }
      
      // Update timestamp
      await storage.write(key: 'login_timestamp', value: DateTime.now().toIso8601String());
      
      debugPrint("✅ Token refresh successful");
      return authResponse;
      
    } on DioException catch (e) {
      debugPrint("❌ Token refresh failed: ${e.message}");
      throw Exception('Session expired. Please login again.');
    }
  }

  /// Get the stored login timestamp
  Future<DateTime?> getLoginTimestamp() async {
    const storage = FlutterSecureStorage();
    final timestamp = await storage.read(key: 'login_timestamp');
    return timestamp != null ? DateTime.parse(timestamp) : null;
  }

  /// Check if the current session is likely expired (client-side check)
  Future<bool> isSessionLikelyExpired() async {
    final loginTime = await getLoginTimestamp();
    if (loginTime == null) return true;
    
    // Assume tokens expire after 24 hours (adjust based on your backend)
    const tokenLifetime = Duration(hours: 24);
    return DateTime.now().difference(loginTime) > tokenLifetime;
  }
}
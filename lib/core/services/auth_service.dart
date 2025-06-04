import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workdey_frontend/core/models/auth_model.dart';

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

  Future<void> logout() async {
    await _dio.post('/api/auth/logout/');
  }

  Future<AuthResponse> refreshToken(String refreshToken) async {
    final response = await _dio.post(
      '/api/auth/refresh/',
      data: jsonEncode({'refresh': refreshToken}),
    );
    return AuthResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
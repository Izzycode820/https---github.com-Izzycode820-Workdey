import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/signup/signup_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/signup_service.dart';
import 'package:workdey_frontend/features/auth/signup/signup_state.dart';

final signupServiceProvider = Provider<SignupService>((ref) {
  return SignupService(ref.read(dioProvider));
});

final signupProvider = StateNotifierProvider<SignupNotifier, SignupState>((ref) {
  return SignupNotifier(ref.read(signupServiceProvider));
});

class SignupNotifier extends StateNotifier<SignupState> {
  final SignupService _signupService;
  SignupNotifier(this._signupService) : super(const SignupState.initial());

 Future<void> register(Signup signup) async {
  state = const SignupState.loading();
  try {
    await _signupService.signup(signup);
    state = const SignupState.success();
  } on DioException catch (e) {
    if (e.response?.statusCode == 400) {
      final responseData = e.response?.data;
      debugPrint('Raw error response: $responseData');

      String errorMessage = 'Registration failed';
      
      if (responseData is Map && responseData['error'] is String) {
        final errorString = responseData['error'] as String;
        
        if (errorString.contains("email")) {
          errorMessage = 'Email already exists';
        } else if (errorString.contains("phone")) {
          errorMessage = 'Phone already exists';
        }
      }

      state = SignupState.error(errorMessage: errorMessage);
    } else {
      state = SignupState.error(errorMessage: 'Registration failed. Please try again.');
    }
  } catch (e) {
    state = SignupState.error(errorMessage: 'An unexpected error occurred');
  }
}}
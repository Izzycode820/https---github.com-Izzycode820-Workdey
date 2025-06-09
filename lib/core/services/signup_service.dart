import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/signup/signup_model.dart';
import 'package:workdey_frontend/core/services/dio_exceptions.dart';

class SignupService {
  final Dio _dio;

  SignupService(this._dio);

  Future<void> signup(Signup signup) async {
  try {debugPrint('Attempting signup with: ${signup.toJson()}');
    
    final response = await _dio.post(
      '/api/auth/register/',
      data: signup.toJson(),
      options: Options(
        validateStatus: (status) => status! < 500,
      ),
    );
    
    if (response.statusCode != 201) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    }
  } on DioException catch (e) {
    debugPrint('DioError during signup: ${e.response?.data}');
    if (e.response?.data is! Map) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: Response<Map<String, dynamic>>(
          data: {'error': e.response?.data.toString()},
          headers: e.response?.headers,
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
        ),
      );
    }
    rethrow;
  } catch (e) {
    debugPrint('Unexpected error in signup service: $e');
    rethrow;
  }
}
}
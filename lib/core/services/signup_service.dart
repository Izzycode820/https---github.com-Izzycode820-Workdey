import 'package:dio/dio.dart';
import 'package:workdey_frontend/core/models/signup/signup_model.dart';
import 'package:workdey_frontend/core/services/dio_exceptions.dart';

class SignupService {
  final Dio _dio;

  SignupService(this._dio);

  Future<void> signup(Signup signup) async {
    try {
      await _dio.post(
        '/api/auth/register/',
        data: signup.toJson(),
      );
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }
}
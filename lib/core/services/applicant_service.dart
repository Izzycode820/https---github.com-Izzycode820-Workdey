import 'package:dio/dio.dart';
import 'package:workdey_frontend/core/models/applicant/applicant_model.dart';
import 'package:workdey_frontend/core/services/dio_exceptions.dart';

class ApplicantService {
  final Dio _dio;

  ApplicantService(this._dio);

  Future<List<Applicant>> getJobApplicants(int jobId) async {
    try {
      final response = await _dio.get(
        '/api/v1/jobs/$jobId/applicants/',
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      return (response.data as List)
          .map((json) => Applicant.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }
}
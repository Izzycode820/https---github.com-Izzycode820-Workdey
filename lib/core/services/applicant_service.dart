import 'package:dio/dio.dart';
import 'package:workdey_frontend/core/models/applicant/applicant_model.dart';
import 'package:workdey_frontend/core/services/dio_exceptions.dart';

class ApplicantService {
  final Dio _dio;

  ApplicantService(this._dio);

  Future<List<Application>> getJobApplicants(int jobId) async {
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
          .map((json) => Application.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }

  Future<List<Application>> getMyApplications() async {
    try {
      final response = await _dio.get('/api/v1/applications/my_applications/');
      return (response.data as List)
          .map((json) => Application.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }

  Future<void> updateApplicationStatus(int applicationId, String status) async {
    try {
      await _dio.patch(
        '/api/v1/applications/$applicationId/status/',
        data: {'status': status},
      );
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }

  Future<void> applyToJob(int jobId, Map<String, dynamic> applicationData) async {
    try {
      await _dio.post(
        '/api/v1/jobs/$jobId/apply/',
        data: applicationData,
      );
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }
}
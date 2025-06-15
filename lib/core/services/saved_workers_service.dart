// features/saved_jobs/application/saved_jobs_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/dio_exceptions.dart';

class SavedWorkersService {
  final Dio _dio;

  SavedWorkersService(this._dio);

  Future<PaginatedResponse<Worker>> getSavedWorkers({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/api/v1/workers/saved-workers/',
        queryParameters: {'page': page},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

       // Handle empty or invalid response structure
    final responseData = response.data as Map<String, dynamic>;
    if (responseData['results'] == null || !(responseData['results'] is List)) {
      debugPrint('⚠️ Invalid response structure - returning empty results');
      return PaginatedResponse<Worker>(
        count: 0,
        results: [],
        next: null,
        previous: null,
      );
    }
      
      final paginatedResponse = PaginatedResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => Worker.fromJson(json as Map<String, dynamic>),
      );
    return paginatedResponse;
    } on DioException catch (e) {
      debugPrint('❌ Error fetching saved jobs: ${e.message}');

       // Handle 404 specifically
    if (e.response?.statusCode == 404) {
      debugPrint('🔍 Page $page not found - returning empty results');
      return PaginatedResponse<Worker>(
        count: 0,
        results: [],
        next: null,
        previous: null,
      );
    }
    throw DioExceptions.fromDioError(e);
    }
  }

  Future<void> saveworker(int workerId) async {
    try {
      await _dio.post(
        '/api/v1/workers/$workerId/save/',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }

  Future<void> unsaveworker(int workerId) async {
    try {
      await _dio.delete(
        '/api/v1/workers/$workerId/save/',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }
}

final savedWorkersServiceProvider = Provider<SavedWorkersService>((ref) {
  return SavedWorkersService(ref.read(dioProvider));
});
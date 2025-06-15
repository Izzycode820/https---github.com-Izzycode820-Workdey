// lib/core/services/get_worker_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/dio_exceptions.dart';
import 'package:workdey_frontend/features/auth/login/login_utils.dart';

final workerServiceProvider = Provider<WorkerService>((ref) {
  return WorkerService(ref.read(dioProvider));
});

class WorkerService {
  final Dio _dio;

  WorkerService(this._dio);

  Future<PaginatedResponse<Worker>> fetchWorkers({
    int page = 1,
    String? category,
    bool forceRefresh = false,
  }) async {
    debugPrint('🌐 Fetching jobs page $page (forceRefresh: $forceRefresh)');
    await AuthUtils.printCurrentToken();
    
    try {

    final response = await _dio.get(
      '/api/v1/workers/',
      queryParameters: {
        if (category != null) 'category': category,
        'page': page,
        },
      options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
    );

    if (kDebugMode) {
            debugPrint('✅ workers fetched successfully');
            debugPrint('Response data: ${response.data}');
          }

//handle empty or invalid response structure
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
      debugPrint('❌ Error fetching jobs: ${e.message}');

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
}


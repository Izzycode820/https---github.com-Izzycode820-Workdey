// services/post_worker_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/models/postworker/post_worker_model.dart';
import 'package:workdey_frontend/core/services/dio_exceptions.dart';

class PostWorkerService {
  final Dio _dio;

  PostWorkerService(this._dio);

  Future<Map<String, dynamic>> postWorker(PostWorker worker) async {
    try{
    final response = await _dio.post(
      '/api/v1/workers/',
      data: worker.toJson(),
      options: Options(
        validateStatus: (status) => status! < 500,
      ),
    );
    //return Worker.fromJson(response.data);
    if (response.statusCode == 201) {
      return response.data;
    } else if (response.statusCode == 403) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: response.data['error'] ?? 'Verification level too low',
      );
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: response.data['error'] ?? 'Failed to post job',
      );
    }
  } on DioException catch (e) {
    rethrow;
  }

}
  

  Future<PaginatedResponse<Worker>> getMyWorkerscard({int page = 1}) async {
    try {
    final response = await _dio.get(
    '/api/v1/me/workers/',
    options: Options(
        validateStatus: (status) => status! < 500, // Accept 404 as valid
      ),
    );
    //return (response.data as List).map((json) => Worker.fromJson(json)).toList();
    // Handle empty or invalid response structure
    if (response.statusCode == 404) {
      return PaginatedResponse<Worker>(
        count: 0,
        results: [],
        next: null,
        previous: null,
      );
    } 
      return PaginatedResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => Worker.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      debugPrint('Error fetching posted jobs: ${e.message}');
      rethrow;
    }
  }

  Future<void> updateWorker(int workerId, PostWorker worker) async {
    try{
       await _dio.put(
      '/api/v1/workers/$workerId/',
      data: worker.toJson(),
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
       );
    } on DioException catch (e) {
    throw DioExceptions.fromDioError(e);
  }
}

  Future<void> deleteWorker(int workerId) async {
    await _dio.delete('/api/v1/workers/$workerId/');
  }
}

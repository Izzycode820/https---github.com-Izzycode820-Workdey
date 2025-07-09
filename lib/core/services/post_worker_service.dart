import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/models/postworker/post_worker_model.dart';
import 'package:workdey_frontend/core/services/dio_exceptions.dart';

// ============================================================================
// PROFESSIONAL WORKER SERVICE - Clean, robust, and maintainable
// ============================================================================

class PostWorkerService {
  final Dio _dio;

  PostWorkerService(this._dio);

  // ============================================================================
  // CREATE WORKER - Professional error handling and validation
  // ============================================================================

  Future<Worker> postWorker(PostWorker worker) async {
    try {
      debugPrint('🔄 Posting new worker profile...');
      
      final response = await _dio.post(
        '/api/v1/workers/',
        data: worker.toJson(),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      // Handle different response scenarios professionally
      switch (response.statusCode) {
        case 201:
          debugPrint('✅ Worker profile created successfully');
          return Worker.fromJson(response.data);
          
        case 400:
          final errors = response.data['errors'] ?? response.data;
          throw ValidationException(_formatValidationErrors(errors));
          
        case 403:
          final message = response.data['error'] ?? 
                         response.data['message'] ?? 
                         'Insufficient permissions to create worker profile';
          throw PermissionException(message);
          
        case 409:
          throw ConflictException('Worker profile already exists or conflicts with existing data');
          
        default:
          final message = response.data['error'] ?? 
                         response.data['message'] ?? 
                         'Failed to create worker profile';
          throw ApiException(message);
      }
    } on DioException catch (e) {
      debugPrint('❌ Network error posting worker: ${e.message}');
      throw _handleDioException(e, 'create worker profile');
    } catch (e) {
      debugPrint('❌ Unexpected error posting worker: $e');
      rethrow;
    }
  }

  // ============================================================================
  // READ WORKERS - Professional pagination and error handling
  // ============================================================================

  Future<PaginatedResponse<Worker>> getMyWorkers({int page = 1}) async {
    try {
      debugPrint('🔄 Fetching posted workers (page $page)...');
      
      final response = await _dio.get(
        '/api/v1/me/workers/',
        queryParameters: {
          'page': page,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      // Handle different response scenarios
      switch (response.statusCode) {
        case 200:
          debugPrint('✅ Workers fetched successfully');
          return PaginatedResponse.fromJson(
            response.data as Map<String, dynamic>,
            (json) => Worker.fromJson(json as Map<String, dynamic>),
          );
          
        case 404:
          debugPrint('📋 No workers found - returning empty list');
          return const PaginatedResponse<Worker>(
            count: 0,
            results: [],
            next: null,
            previous: null,
          );
          
        default:
          final message = response.data['error'] ?? 
                         response.data['message'] ?? 
                         'Failed to fetch workers';
          throw ApiException(message);
      }
    } on DioException catch (e) {
      debugPrint('❌ Network error fetching workers: ${e.message}');
      throw _handleDioException(e, 'fetch workers');
    } catch (e) {
      debugPrint('❌ Unexpected error fetching workers: $e');
      rethrow;
    }
  }

  // ============================================================================
  // UPDATE WORKER - Professional update handling
  // ============================================================================

  Future<Worker> updateWorker(int workerId, PostWorker worker) async {
    try {
      debugPrint('🔄 Updating worker $workerId...');
      
      final response = await _dio.put(
        '/api/v1/workers/$workerId/',
        data: worker.toJson(),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      // Handle different response scenarios
      switch (response.statusCode) {
        case 200:
          debugPrint('✅ Worker updated successfully');
          return Worker.fromJson(response.data);
          
        case 400:
          final errors = response.data['errors'] ?? response.data;
          throw ValidationException(_formatValidationErrors(errors));
          
        case 403:
          throw PermissionException('You do not have permission to update this worker profile');
          
        case 404:
          throw NotFoundException('Worker profile not found');
          
        default:
          final message = response.data['error'] ?? 
                         response.data['message'] ?? 
                         'Failed to update worker profile';
          throw ApiException(message);
      }
    } on DioException catch (e) {
      debugPrint('❌ Network error updating worker: ${e.message}');
      throw _handleDioException(e, 'update worker profile');
    } catch (e) {
      debugPrint('❌ Unexpected error updating worker: $e');
      rethrow;
    }
  }

  // ============================================================================
  // DELETE WORKER - Professional deletion handling
  // ============================================================================

  Future<void> deleteWorker(int workerId) async {
    try {
      debugPrint('🔄 Deleting worker $workerId...');
      
      final response = await _dio.delete(
        '/api/v1/workers/$workerId/',
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      // Handle different response scenarios
      switch (response.statusCode) {
        case 204:
        case 200:
          debugPrint('✅ Worker deleted successfully');
          return;
          
        case 403:
          throw PermissionException('You do not have permission to delete this worker profile');
          
        case 404:
          throw NotFoundException('Worker profile not found');
          
        case 409:
          throw ConflictException('Cannot delete worker profile with active applications');
          
        default:
          final message = response.data?['error'] ?? 
                         response.data?['message'] ?? 
                         'Failed to delete worker profile';
          throw ApiException(message);
      }
    } on DioException catch (e) {
      debugPrint('❌ Network error deleting worker: ${e.message}');
      throw _handleDioException(e, 'delete worker profile');
    } catch (e) {
      debugPrint('❌ Unexpected error deleting worker: $e');
      rethrow;
    }
  }

  // ============================================================================
  // GET SINGLE WORKER - Professional single item retrieval
  // ============================================================================

  Future<Worker> getWorker(int workerId) async {
    try {
      debugPrint('🔄 Fetching worker $workerId...');
      
      final response = await _dio.get(
        '/api/v1/workers/$workerId/',
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      switch (response.statusCode) {
        case 200:
          debugPrint('✅ Worker fetched successfully');
          return Worker.fromJson(response.data);
          
        case 404:
          throw NotFoundException('Worker profile not found');
          
        default:
          final message = response.data['error'] ?? 
                         response.data['message'] ?? 
                         'Failed to fetch worker profile';
          throw ApiException(message);
      }
    } on DioException catch (e) {
      debugPrint('❌ Network error fetching worker: ${e.message}');
      throw _handleDioException(e, 'fetch worker profile');
    } catch (e) {
      debugPrint('❌ Unexpected error fetching worker: $e');
      rethrow;
    }
  }

  // ============================================================================
  // PRIVATE HELPER METHODS - Professional error handling
  // ============================================================================

  Exception _handleDioException(DioException e, String operation) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException('Request timed out while trying to $operation. Please check your connection.');
        
      case DioExceptionType.connectionError:
        return NetworkException('Unable to connect to server. Please check your internet connection.');
        
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['error'] ?? 
                       e.response?.data?['message'] ?? 
                       'Server error occurred';
        return ApiException('Server responded with error $statusCode: $message');
        
      case DioExceptionType.cancel:
        return OperationCancelledException('Operation was cancelled');
        
      case DioExceptionType.unknown:
      default:
        return NetworkException('An unexpected network error occurred while trying to $operation');
    }
  }

  String _formatValidationErrors(dynamic errors) {
    if (errors is Map) {
      final errorMessages = <String>[];
      errors.forEach((field, messages) {
        if (messages is List) {
          errorMessages.addAll(messages.map((msg) => '$field: $msg'));
        } else {
          errorMessages.add('$field: $messages');
        }
      });
      return errorMessages.join(', ');
    } else if (errors is List) {
      return errors.join(', ');
    } else {
      return errors.toString();
    }
  }
}

// ============================================================================
// PROFESSIONAL EXCEPTION CLASSES - Clean error handling
// ============================================================================

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  
  @override
  String toString() => message;
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
  
  @override
  String toString() => message;
}

class PermissionException implements Exception {
  final String message;
  PermissionException(this.message);
  
  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
  
  @override
  String toString() => message;
}

class ConflictException implements Exception {
  final String message;
  ConflictException(this.message);
  
  @override
  String toString() => message;
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
  
  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
  
  @override
  String toString() => message;
}

class OperationCancelledException implements Exception {
  final String message;
  OperationCancelledException(this.message);
  
  @override
  String toString() => message;
}
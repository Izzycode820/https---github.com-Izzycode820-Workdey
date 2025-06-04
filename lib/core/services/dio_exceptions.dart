import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  final String message;

  DioExceptions(this.message);

  factory DioExceptions.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return DioExceptions('Request cancelled');
      case DioExceptionType.connectionTimeout:
        return DioExceptions('Connection timeout');
      case DioExceptionType.receiveTimeout:
        return DioExceptions('Receive timeout');
      case DioExceptionType.sendTimeout:
        return DioExceptions('Send timeout');
      case DioExceptionType.badResponse:
        return DioExceptions(_handleErrorResponse(error.response));
      case DioExceptionType.unknown:
        return DioExceptions('Network error: ${error.message}');
      default:
        return DioExceptions('Unknown error occurred');
    }
  }

  static String _handleErrorResponse(Response? response) {
    final statusCode = response?.statusCode ?? 500;
    final data = response?.data ?? {};
    
    if (data is Map && data.containsKey('detail')) {
      return data['detail'];
    }
    
    switch (statusCode) {
      case 400: return 'Bad request';
      case 401: return 'Unauthorized';
      case 403: return 'Forbidden: ${data['detail'] ?? ''}';
      case 404: return 'Not found';
      case 409: return 'Conflict: ${data['detail'] ?? ''}';
      case 500: return 'Internal server error';
      default: return 'Request failed with status $statusCode';
    }
  }

  @override
  String toString() => message;
}
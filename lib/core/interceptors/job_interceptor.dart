import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JobInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;

  JobInterceptor({required FlutterSecureStorage storage}) : _storage = storage;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Cache-control for job endpoints
    if (options.uri.path.contains('/api/v1/jobs')) {
      options.headers['Cache-Control'] = 'max-age=3600';
      options.headers['X-Cache-Enabled'] = 'true';
    }
    handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    // Cache successful job responses
    if (response.requestOptions.uri.path.contains('/api/v1/jobs')) {
      await _storage.write(
        key: 'jobs_cache',
        value: jsonEncode(response.data),
      );
    }
    handler.next(response);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // Fallback to cache for job requests
    if (err.type == DioExceptionType.connectionError && 
        err.requestOptions.uri.path.contains('/api/v1/jobs')) {
      final cachedData = await _storage.read(key: 'jobs_cache');
      if (cachedData != null) {
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: jsonDecode(cachedData),
          statusCode: 200,
        ));
      }
    }
    handler.next(err);
  }
}
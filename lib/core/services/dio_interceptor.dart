/*import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;
  final Dio _refreshDio;

  AppInterceptor({required FlutterSecureStorage storage}) 
      : _storage = storage,
        _refreshDio = Dio(BaseOptions(baseUrl: 'http://localhost:8000')); // Separate Dio instance for token refresh

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. Auth Handling - Add token to all requests
    final access = await _storage.read(key: 'access');
    if (access != null) {
      options.headers['Authorization'] = 'Bearer $access';
    }

    // 2. Job-specific Caching
    if (options.uri.path.contains('/api/v1/jobs')) {
      options.headers['Cache-Control'] = 'max-age=3600';
      options.headers['X-Cache-Enabled'] = 'true';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // 1. Handle 401 Unauthorized (Token Refresh)
    if (err.response?.statusCode == 401) {
      try {
        final newToken = await _refreshToken();
        if (newToken != null) {
          // Retry original request with new token
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
          final response = await Dio().fetch(err.requestOptions);
          return handler.resolve(response);
        }
      } catch (e) {
        print('Refresh failed: $e');
        await _clearTokens();
      }
    }

    // 2. Job Cache Fallback
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

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    // Cache successful job responses
    if (response.requestOptions.uri.path.contains('/api/v1/jobs')) {
      await _storage.write(
        key: 'jobs_cache',
        value: jsonEncode(response.data),
      );
    }
    handler.next(response);
  }

  Future<String?> _refreshToken() async {
    final refresh = await _storage.read(key: 'refresh');
    if (refresh == null) return null;

    final response = await _refreshDio.post(
      '/api/auth/refresh/',
      data: {'refresh': refresh},
    );

    if (response.statusCode == 200) {
      final newToken = response.data['access'];
      await _storage.write(key: 'access', value: newToken);
      return newToken;
    }
    return null;
  }

  Future<void> _clearTokens() async {
    await _storage.delete(key: 'access');
    await _storage.delete(key: 'refresh');
  }
}*/
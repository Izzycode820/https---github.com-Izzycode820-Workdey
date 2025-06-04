import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;
  final Dio _refreshDio; // Separate Dio instance for refresh to avoid circular calls
  
  AuthInterceptor(this._storage) : _refreshDio = Dio() {
    // Initialize with base options
    _refreshDio.options = BaseOptions(
      baseUrl: 'http://localhost:8000',
      headers: {'Content-Type': 'application/json'},
    );
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) 
  async {

  //debugPrint('Requesting: ${options.baseUrl}${options.path}');
  //debugPrint('Query params: ${options.queryParameters}');
  //handler.next(options);

      // Add debug logs for token retrieval
    debugPrint('\n🔍 [AuthInterceptor] Checking auth for ${options.method} ${options.path}');

    // Skip auth for certain endpoints
    if (_shouldSkipAuth(options.path)) {
      debugPrint('🔄 Skipping auth for ${options.path}');
      return handler.next(options);
    }

  // Read token directly from storage with verification
  try {
    //
    final token = await _storage.read(key: 'access_token').timeout(
       const Duration(seconds: 2),
        onTimeout: () {
          debugPrint('⌛ Token read timeout');
          return null;
        },
      );
    debugPrint('🔑 Token retrieved: ${token != null ? "exists" : "null"}');
    
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      debugPrint('✅ Token attached successfully');
    } else {
        debugPrint('⚠️ No token available - clearing potentially invalid session');
        await _storage.delete(key: 'access_token');  
    }
  } catch (e) {
    debugPrint('❌ Error reading token: $e');
  }

  // Log final headers being sent
  debugPrint('📤 Final headers: ${options.headers}');
  handler.next(options);
}
  
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Only handle 401 errors
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    // Skip refresh attempt for auth-related endpoints
    if (_shouldSkipRefresh(err.requestOptions.path)) {
      return handler.next(err);
    }

     final options = err.requestOptions;
    final cachedRequest = _CacheRequest(
      options: options,
      data: options.data,
    );

    try {
      final newToken = await _attemptTokenRefresh();
      if (newToken != null) {
        // Retry original request with new token
        final response = await _retryRequest(err.requestOptions, newToken);
        return handler.resolve(response);
      }
    } catch (e) {
      // Fall through to logout cleanup
    }

    // If we get here, refresh failed - clear tokens
    await _clearTokens();
    return handler.next(err);
  }

  // Helper Methods
  bool _shouldSkipAuth(String path) {
    return path.contains('/auth/') || path.contains('/public/');
  }

  bool _shouldSkipRefresh(String path) {
    return path.contains('/auth/refresh') || path.contains('/auth/login');
  }

  Future<String?> _attemptTokenRefresh() async {
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken == null) return null;

    final response = await _refreshDio.post(
      '/auth/refresh/',
      data: {'refresh': refreshToken},
    );

    if (response.statusCode == 200) {
      final newAccessToken = response.data['access'];
      await _storage.write(key: 'access_token', value: newAccessToken);
      return newAccessToken;
    }
    return null;
  }

  Future<Response<dynamic>> _retryRequest(
    RequestOptions options,
    String newToken,
  ) async {
    options.headers['Authorization'] = 'Bearer $newToken';
    return _refreshDio.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: Options(
        method: options.method,
        headers: options.headers,
      ),
    );
  }

  Future<void> _clearTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
    // You might want to add navigation to login here
  } 
}
class _CacheRequest {
  final RequestOptions options;
  final dynamic data;

  _CacheRequest({required this.options, required this.data});
}
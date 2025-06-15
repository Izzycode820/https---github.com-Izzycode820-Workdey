import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;
  final Dio _refreshDio;
  
  AuthInterceptor(this._storage) : _refreshDio = Dio() {
    _refreshDio.options = BaseOptions(
      baseUrl: 'http://localhost:8000',
      headers: {'Content-Type': 'application/json'},
    );
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    debugPrint('\n🔍 [AuthInterceptor] Checking auth for ${options.method} ${options.path}');

    // Always add content-type if not present
    options.headers['Content-Type'] ??= 'application/json';

    // Special handling for logout endpoint
  if (options.path == '/api/auth/logout/') {
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken != null) {
      // Add refresh token to request body
      options.data = options.data ?? {};
      if (options.data is Map) {
        (options.data as Map)['refresh'] = refreshToken;
      }
      debugPrint('🔑 Added refresh token to logout request');
    }
    
    // Still include access token in header
    final accessToken = await _getToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }

    // For all other requests, add token if available
    final token = await _getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      debugPrint('✅ Token attached successfully');
    }

    debugPrint('📤 Final headers: ${options.headers}');
    handler.next(options);
  }

  Future<String?> _getToken() async {
    try {
      final token = await _storage.read(key: 'access_token').timeout(
        const Duration(seconds: 2),
        onTimeout: () {
          debugPrint('⌛ Token read timeout');
          return null;
        },
      );
      
      if (token == null) {
        debugPrint('⚠️ No token available - clearing potentially invalid session');
        await _storage.delete(key: 'access_token');
      }
      return token;
    } catch (e) {
      debugPrint('❌ Error reading token: $e');
      return null;
    }
  }

  bool _shouldSkipAuth(String path) {
    // Skip auth for these specific endpoints
    const skipPaths = [
      '/api/auth/login/',
      '/api/auth/refresh/',
      '/api/auth/register/',
      // Add other public auth endpoints here
    ];
    return skipPaths.contains(path);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    if (_shouldSkipRefresh(err.requestOptions.path)) {
      return handler.next(err);
    }

    try {
      final newToken = await _attemptTokenRefresh();
      if (newToken != null) {
        final response = await _retryRequest(err.requestOptions, newToken);
        return handler.resolve(response);
      }
    } catch (e) {
      debugPrint('❌ Token refresh failed: $e');
    }

    await _clearTokens();
    return handler.next(err);
  }

  bool _shouldSkipRefresh(String path) {
    return path.contains('/auth/refresh') || path.contains('/auth/login');
  }

  Future<String?> _attemptTokenRefresh() async {
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken == null) return null;

    final response = await _refreshDio.post(
      '/api/auth/refresh/',
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
  }
}
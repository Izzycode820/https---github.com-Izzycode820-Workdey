// Improved login_provider.dart with better logout
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/login_service.dart';
import 'package:workdey_frontend/core/models/login/login_model.dart';
import '../../features/auth/login/login_state.dart';

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authServiceProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  AuthNotifier(this._authService) : super(const AuthState.loading()) {
    // 🔑 KEY CHANGE: Check for existing session on initialization
    _initializeAuth();
  }

  /// Initialize authentication state by checking for existing tokens
  Future<void> _initializeAuth() async {
    try {
      debugPrint("🔄 Initializing authentication state...");
      
      // Check if we have stored tokens
      final accessToken = await _storage.read(key: 'access_token');
      final refreshToken = await _storage.read(key: 'refresh_token');
      
      if (accessToken == null || refreshToken == null) {
        debugPrint("❌ No stored tokens found - requiring login");
        state = const AuthState.initial();
        return;
      }
      
      debugPrint("✅ Found stored tokens - verifying validity");
      
      // Validate the token by making a test API call
      final isValid = await _validateToken(accessToken);
      
      if (isValid) {
        debugPrint("✅ Token is valid - user authenticated");
        // Create a mock AuthResponse since we don't store full response
        final authResponse = AuthResponse(
          access: accessToken,
          refresh: refreshToken,
        );
        state = AuthState.authenticated(authResponse);
      } else {
        debugPrint("❌ Token is invalid - attempting refresh");
        await _attemptTokenRefresh(refreshToken);
      }
      
    } catch (e) {
      debugPrint("❌ Auth initialization failed: $e");
      // Clear potentially corrupted tokens and require login
      await _clearTokens();
      state = const AuthState.initial();
    }
  }

  /// Validate token by making a lightweight API call
  Future<bool> _validateToken(String token) async {
    try {
      // Make a simple API call to verify token validity
      final response = await _authService.validateToken(token);
      return response;
    } catch (e) {
      debugPrint("🔍 Token validation failed: $e");
      return false;
    }
  }

  /// Attempt to refresh the access token
  Future<void> _attemptTokenRefresh(String refreshToken) async {
    try {
      debugPrint("🔄 Attempting token refresh...");
      final newAuthResponse = await _authService.refreshToken(refreshToken);
      
      // Store new tokens
      await _storage.write(key: 'access_token', value: newAuthResponse.access);
      await _storage.write(key: 'refresh_token', value: newAuthResponse.refresh);
      
      debugPrint("✅ Token refresh successful");
      state = AuthState.authenticated(newAuthResponse);
      
    } catch (e) {
      debugPrint("❌ Token refresh failed: $e");
      await _clearTokens();
      state = const AuthState.initial();
    }
  }

  /// Clear all stored tokens
  Future<void> _clearTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
    await _storage.delete(key: 'login_timestamp');
    debugPrint("🗑️ All tokens and session data cleared");
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      debugPrint("🔐 Attempting login with: $email");
      final response = await _authService.login(email, password);
      debugPrint("✅ Login successful, token: ${response.access}");
      
      // Immediately verify token storage
      const storage = FlutterSecureStorage();
      final storedToken = await storage.read(key: 'access_token');
      
      if (storedToken == null) {
        throw Exception('Token storage failed');
      }
      
      debugPrint("✅ Login & storage verified");
      state = AuthState.authenticated(response);
      
    } catch (e, stack) {
      debugPrint("❌ Login failed: $e");
      debugPrint("Stack trace: $stack");
      state = AuthState.error(e.toString());
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      debugPrint("🚪 Starting logout process...");
      state = const AuthState.loading();
      
      // Call backend logout endpoint
      await _authService.logout();
      debugPrint("✅ Backend logout successful");
      
      // Clear all local data
      await _clearTokens();
      
      // 🎯 CRITICAL: Set state to initial (not loading)
      // This will trigger App widget to show LoginScreen
      state = const AuthState.initial();
      debugPrint("✅ Logout completed - state set to initial");
      
    } catch (e) {
      debugPrint("❌ Logout failed: $e");
      
      // Even if backend logout fails, clear local tokens
      await _clearTokens();
      
      // Set to initial state anyway - user should be able to re-login
      state = const AuthState.initial();
      debugPrint("⚠️ Logout completed with errors - local state cleared");
      
      // Note: We don't rethrow here because we want the user to be logged out
      // even if the backend call fails (e.g., network issues)
    }
  }

  /// Manually refresh the current session
  Future<void> refreshSession() async {
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken != null) {
      await _attemptTokenRefresh(refreshToken);
    } else {
      state = const AuthState.initial();
    }
  }

  /// Check if user is currently authenticated
  bool get isAuthenticated => state.maybeWhen(
    authenticated: (_) => true,
    orElse: () => false,
  );

  /// Force logout without backend call (for emergencies)
  Future<void> forceLogout() async {
    debugPrint("🚨 Force logout initiated");
    await _clearTokens();
    state = const AuthState.initial();
    debugPrint("✅ Force logout completed");
  }
}
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/login_service.dart';
import '../../features/auth/login/login_state.dart';

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authServiceProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  
  AuthNotifier(this._authService) : super(const AuthState.initial());

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
      await _authService.logout();
      state = const AuthState.initial();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}
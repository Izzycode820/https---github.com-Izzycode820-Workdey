import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthUtils {
  static const _storage = FlutterSecureStorage();

  // Changed return type to Future<String?> to match the actual return
  static Future<String?> verifyToken() async {
    final token = await _storage.read(key: 'access_token');
    debugPrint('🛂 Token verification: ${token != null ? "EXISTS" : "MISSING"}');
    return token; // Now matches the return type
  }

  static Future<void> printCurrentToken() async {
    final token = await _storage.read(key: 'access_token');
    debugPrint('🔍 Current token: ${token != null ? '${token.substring(0, 20)}...' : 'null'}');
  }

  // Added this new method for complete token dump (for debugging)
  static Future<void> debugPrintToken() async {
    final token = await _storage.read(key: 'access_token');
    debugPrint('🔐 FULL TOKEN: $token');
  }
}
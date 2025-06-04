import 'package:connectivity_plus/connectivity_plus.dart';
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  // Fixed stream implementation
  Stream<ConnectivityResult> get connectivityStream => 
        _connectivity.onConnectivityChanged
              .map((results) => results.first); // Take the first result

  Future<bool> get isOnline async {
    final results = await _connectivity.checkConnectivity();
    return results.first != ConnectivityResult.none;
  }

  // Enhanced connectivity check with timeout
  Future<bool> get isOnlineWithTimeout async {
    try {
      final result = await _connectivity.checkConnectivity()
        .timeout(const Duration(seconds: 5));
      return result.first != ConnectivityResult.none;
    } catch (_) {
      return false;
    }
  }
}
// notification_service.dart
import 'package:dio/dio.dart';

class NotificationService {
  final Dio _dio;

  NotificationService(this._dio);

  Future<int> getUnreadCount() async {
    try {
      final response = await _dio.get('/notifications/unread_count/');
      return response.data['count'] ?? 0;
    } on DioException {
      return 0; // Fallback for offline
    }
  }
}


// lib/core/providers/notification_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/services/notification_service.dart';
import '../../core/providers/providers.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(ref.read(dioProvider));
});

final unreadNotificationsProvider = FutureProvider<int>((ref) {
  return ref.read(notificationServiceProvider).getUnreadCount();
});
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:badges/badges.dart' as badges;
import 'package:workdey_frontend/features/notifications/notification_provider.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadNotificationsProvider).value ?? 0;

    return AppBar(
      title: const Text(
        'Work Dey',
        style: TextStyle(
          color: Color(0xFF3E8728),
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        badges.Badge(
          position: badges.BadgePosition.topEnd(top: -10, end: -10),
          badgeContent: Text(
            '$unreadCount',
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
          showBadge: unreadCount > 0,
          child: IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
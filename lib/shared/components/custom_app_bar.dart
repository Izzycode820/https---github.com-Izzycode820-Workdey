import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationPressed;
  final Widget? actionButton;

  const CustomAppBar({
    super.key,
    this.onNotificationPressed,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Work dey',
        style: TextStyle(
          color: Color(0xFF3E8728),
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        if (actionButton != null) actionButton!,
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: onNotificationPressed,
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
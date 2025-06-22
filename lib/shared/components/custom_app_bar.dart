import 'package:flutter/material.dart';
import 'package:workdey_frontend/features/search_filter/search_bar_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationPressed;
  final Widget? actionButton;
  final bool? isJobSearch; // Make optional
  final bool showSearchBar; // New parameter to control visibility

  const CustomAppBar({
    super.key,
    this.onNotificationPressed,
    this.actionButton,
    this.isJobSearch, // Now optional
    this.showSearchBar = false, // Default to false
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
      bottom: showSearchBar 
          ? PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SearchBarWidget(isJobSearch: isJobSearch ?? false),
              ),
            )
          : null,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    showSearchBar 
      ? kToolbarHeight + 60 
      : kToolbarHeight
  );
}
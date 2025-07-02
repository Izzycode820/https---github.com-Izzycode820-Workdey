import 'package:flutter/material.dart';
import 'package:workdey_frontend/features/search_filter/search_bar_widget.dart';
import 'package:workdey_frontend/shared/enum/search_type.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationPressed;
  final Widget? actionButton;
  final SearchType? searchType;
  final bool showSearchBar; // New parameter to control visibility

  const CustomAppBar({
    super.key,
    this.onNotificationPressed,
    this.actionButton,
    required this.searchType,
    this.showSearchBar = false, // Default to false
  });

  const CustomAppBar.withoutSearch({
    super.key,
    this.onNotificationPressed,
    this.actionButton,
  }) : showSearchBar = false,
       searchType = null;

       
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
        if (actionButton != null)
          Builder(
            builder: (innerContext) => actionButton!,
          ),
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
                child: SearchBarWidget(
                  searchType: searchType!,
            isStatic: true,
          ),
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
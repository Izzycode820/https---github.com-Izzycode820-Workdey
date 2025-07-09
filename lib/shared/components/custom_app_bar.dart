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
        preferredSize: const Size.fromHeight(48), // Reduced from 60
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8), // Thinner padding
          color: Colors.white,
          child: Container(
            height: 36, // Much thinner like LinkedIn
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(18), // More rounded
              border: Border.all(color: Colors.grey[300]!, width: 0.5),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                Icon(Icons.search, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Expanded(
                 child: Text(
                    searchType == SearchType.job ? 'Search jobs...' : 'Search workers...',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Icon(Icons.tune, size: 16, color: Colors.grey[500]),
                const SizedBox(width: 12),
              ],
            ),
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
      ? kToolbarHeight + 40
      : kToolbarHeight
  );
}
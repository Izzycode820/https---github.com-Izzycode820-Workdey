import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBarWidget extends ConsumerWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5E7D5E).withOpacity(0.31),
            blurRadius: 25,
            offset: const Offset(0, 4),
      )],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(
              Icons.search,
              color: Color(0xFF1E1E1E),
            ),
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Graphic Designer',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E1E1E),
                ),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                // TODO: Implement search functionality
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filter functionality
            },
          ),
        ],
      ),
    );
  }
}
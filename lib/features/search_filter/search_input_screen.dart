import 'package:flutter/material.dart';
import 'package:workdey_frontend/features/search_filter/search_bar_widget.dart';
import 'package:workdey_frontend/shared/components/recent_searches_list.dart';

class SearchInputScreen extends StatelessWidget {
  final bool isJobSearch;
  
  const SearchInputScreen({
    super.key,
    required this.isJobSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          SearchBarWidget(
            isJobSearch: isJobSearch,
            isStatic: false,
            isInputScreen: true,
          ),
          const Expanded(child: RecentSearchesList()),
        ],
      ),
    );
  }
}
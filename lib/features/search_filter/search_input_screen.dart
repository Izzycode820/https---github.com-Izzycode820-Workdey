import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/features/search_filter/search_bar_widget.dart';
import 'package:workdey_frontend/shared/components/recent_searches_list.dart';
import 'package:workdey_frontend/shared/enum/search_type.dart';

class SearchInputScreen extends ConsumerWidget {
  final SearchType searchType;
  
  
  const SearchInputScreen({
    super.key,
    required this.searchType
  });

 @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(searchType == SearchType.job 
            ? 'Search Jobs' 
            : 'Search Workers'),
      ),
      body: Column(
        children: [
          SearchBarWidget(
            searchType: searchType,
            isStatic: false,
            isInputScreen: true,
          ),
          const Expanded(child: RecentSearchesList()),
        ],
      ),
    );
  }
}

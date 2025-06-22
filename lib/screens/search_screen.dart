import 'package:flutter/material.dart';
import 'package:workdey_frontend/features/search_filter/search_context.dart';

class SearchInputPage extends StatelessWidget {
  final SearchContext searchContext;
  final Function(String) onSearch;

  const SearchInputPage({
    super.key,
    required this.searchContext,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Search ${searchContext.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              onSearch(controller.text);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search ${searchContext.name}...',
            border: OutlineInputBorder(),
          ),
          onSubmitted: onSearch,
        ),
      ),
    );
  }
}
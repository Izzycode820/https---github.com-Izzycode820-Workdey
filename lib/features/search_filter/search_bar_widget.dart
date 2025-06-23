import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/providers/recent_search_provider.dart';
import 'package:workdey_frontend/features/search_filter/search_input_screen.dart';
import 'package:workdey_frontend/screens/search_screen.dart';
import 'package:workdey_frontend/shared/enum/search_type.dart';

class SearchBarWidget extends ConsumerWidget {
  final bool isStatic;
  final bool isInputScreen;
  final SearchType searchType;
  
  const SearchBarWidget({
    super.key,
    required this.searchType,
    this.isStatic = true,
    this.isInputScreen = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return isStatic
        ? _buildStaticSearchBar(context)
        : _buildActiveSearchBar(context, ref);
  }

  Widget _buildStaticSearchBar(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SearchInputScreen(searchType: searchType)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.search),
            const SizedBox(width: 8),
            Text(
              searchType == SearchType.job ? 'Search jobs...' : 'Search workers...',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveSearchBar(BuildContext context, WidgetRef ref) {
  final controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void performSearch() async {
    final query = controller.text.trim();
    if (query.isNotEmpty) {
      ref.read(recentSearchesProvider.notifier).addSearch(query);

showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

      // Navigate to results screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SearchResultsScreen(
          searchType: searchType,
          searchQuery: query,
        ),
      ),
    ).then((_) {
    Navigator.of(context).pop(); // Dismiss loading when navigation completes
  });
  
  // Trigger search
  if (searchType == SearchType.job) {
    ref.read(jobSearchNotifierProvider.notifier).searchJobs(query: query);
  } else {
    ref.read(workerSearchNotifierProvider.notifier).searchWorkers(query: query);
  }
  
  focusNode.unfocus();
}}

  return TextField(
    controller: controller,
    focusNode: focusNode,
    autofocus: isInputScreen,
    textInputAction: TextInputAction.search,
    onSubmitted: (_) => performSearch(),
    decoration: InputDecoration(
      hintText: searchType == SearchType.job ? 'Search jobs...' : 'Search workers...',
      prefixIcon: const Icon(Icons.search),
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller.clear();
                performSearch();
              },
            ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: performSearch,
          ),
          if (!isInputScreen)
            IconButton(
              icon: const Icon(Icons.tune),
              onPressed: () => _showMainFilterSheet(context, ref),
            ),
        ],
      ),
    ),
  );
}

void _showMainFilterSheet(BuildContext context, WidgetRef ref) {
  if (searchType == SearchType.job) {
    ref.read(jobFilterSheetsProvider).showMainFilterSheet(context, ref);
  } else {
    ref.read(workerFilterSheetsProvider).showMainFilterSheet(context, ref);
  }
}
}
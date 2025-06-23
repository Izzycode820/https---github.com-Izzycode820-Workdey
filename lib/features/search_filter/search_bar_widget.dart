import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  // void _showFilters(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) => Container(
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         children: [
  //           Text('Filters', style: Theme.of(context).textTheme.headlineSmall),
  //           // Add filter widgets here
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
    void _showFilters() { // Moved inside _buildActiveSearchBar
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Filters', style: Theme.of(context).textTheme.headlineSmall),
              // Add filter widgets here
            ],
          ),
        ),
      );
    }

    return TextField(
      controller: controller,
      autofocus: isInputScreen,
      decoration: InputDecoration(
       hintText: searchType == SearchType.job ? 'Search jobs...' : 'Search workers...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: isInputScreen
            ? IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                    final query = controller.text.trim();
                    if (query.isNotEmpty) {
                      ref.read(recentSearchesProvider.notifier).addSearch(query);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SearchResultsScreen(
                            searchType: searchType, 
                            searchQuery: query,
                          ),
                        ),
                      );
                    }
                  },
              )
            : IconButton(
                icon: const Icon(Icons.tune),
                onPressed: _showFilters, // Use the local function
              ),
      ),
    );
  }
}
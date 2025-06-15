// features/search_filter/search_bar_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/get_workers_provider.dart';
import 'package:workdey_frontend/features/search_filter/search_filter_provider.dart';
import 'package:workdey_frontend/features/workers/category_param.dart';

class SearchBarWidget extends ConsumerWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(searchFilterProvider);
    final notifier = ref.read(searchFilterProvider.notifier);

    return Column(
      children: [
        // Search Bar
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF5E7D5E).withOpacity(0.31),
                blurRadius: 25,
                offset: const Offset(0, 4),
              ),
            ],
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
                    hintText: 'Search workers...',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E1E1E),
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: notifier.setQuery,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.filter_list,
                  color: filterState.hasActiveFilters
                      ? Colors.green
                      : const Color(0xFF1E1E1E),
                ),
                onPressed: notifier.toggleFilters,
              ),
            ],
          ),
        ),
        // Animated Filter Panel
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: filterState.showFilters
              ? _FilterPanel(
                  currentCategory: filterState.category,
                  onCategoryChanged: notifier.setCategory,
                  onFindPressed: () => notifier.toggleFilters(),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _FilterPanel extends StatelessWidget {
  final String? currentCategory;
  final ValueChanged<String?> onCategoryChanged;
  final VoidCallback onFindPressed;

  const _FilterPanel({
    required this.currentCategory,
    required this.onCategoryChanged,
    required this.onFindPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final notifier = ref.read(searchFilterProvider.notifier);
        final filterState = ref.watch(searchFilterProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: filterState.category,
            decoration: InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text('All Categories'),
              ),
              ...workerCategories.map((category) {
                return DropdownMenuItem(
                  value: category.value,
                  child: Text(category.displayName),
                );
              }),
            ],
            onChanged: (category) {
                  notifier.setCategory(category);
                },
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                    notifier.toggleFilters(); // Close the filter panel
                    ref.read(workersNotifierProvider.notifier)
                        .loadInitialWorkers(category: filterState.category);
                  },
              style: ElevatedButton.styleFrom(
                    backgroundColor: filterState.category != null
                        ? Colors.green
                        : Colors.grey[400],
                    // ... rest of button style
                  ),
                  child: const Text('Find Workers'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

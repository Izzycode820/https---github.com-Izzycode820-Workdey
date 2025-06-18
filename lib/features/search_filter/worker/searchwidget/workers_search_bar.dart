import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/features/search_filter/generic_filter_bottom_sheet.dart';
import 'package:workdey_frontend/features/search_filter/worker/searchwidget/worker_search_provider.dart';

class WorkerSearchBar extends ConsumerWidget {
  const WorkerSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workerSearchProvider);
    final notifier = ref.read(workerSearchProvider.notifier);

    return Column(
      children: [
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
                child: Icon(Icons.search, color: Color(0xFF1E1E1E)),
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
                  color: state.hasActiveFilters
                      ? Colors.green
                      : const Color(0xFF1E1E1E),
                ),
                onPressed: notifier.toggleFilters,
              ),
            ],
          ),
        ),
        if (state.showFilters) _buildworkerFilterPanel(context, ref),
      ],
    );
  }

  Widget _buildworkerFilterPanel(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildFilterChip(
            context,
            label: 'Category',
            value: ref.watch(workerSearchProvider).category?.displayName,
            onTap: () => showWorkerCategoryBottomSheet(context, ref),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    required String? value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(label),
            const Spacer(),
            Text(value ?? 'All', 
              style: TextStyle(color: value != null ? Colors.green : Colors.grey)),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/providers/worker_search_provider.dart';
import 'package:workdey_frontend/shared/components/filter_chip.dart';

class WorkerFilterChips extends ConsumerWidget {
  const WorkerFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(workerSearchNotifierProvider);
    final notifier = ref.read(workerSearchNotifierProvider.notifier);
    final sheets = ref.read(workerFilterSheetsProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Always show ALL filter chips
          FilterChipWidget(
            label: 'Category',
            isSelected: filters.category != null,
            count: filters.category != null ? 1 : null,
            onSelected: () => sheets.showCategorySheet(context, ref),
            onDeleted: filters.category != null 
                ? () => notifier.setCategory(null) 
                : null,
          ),

          FilterChipWidget(
            label: 'Availability',
            isSelected: filters.availability?.isNotEmpty ?? false,
            count: filters.availability?.length,
            onSelected: () => sheets.showAvailabilitySheet(context, ref),
            onDeleted: (filters.availability?.isNotEmpty ?? false)
                ? () => notifier.setAvailability([]) 
                : null,
          ),

          FilterChipWidget(
            label: 'Skills',
            isSelected: filters.skills?.isNotEmpty ?? false,
            count: filters.skills?.length,
            onSelected: () => sheets.showWorkerSkillsSheet(context, ref),
            onDeleted: (filters.skills?.isNotEmpty ?? false)
                ? () => notifier.setSkills([]) 
                : null,
          ),

          FilterChipWidget(
            label: 'Location',
            isSelected: filters.location != null,
            count: filters.location != null ? 1 : null,
            onSelected: () => sheets.showLocationSheet(context, ref),
            onDeleted: filters.location != null 
                ? () => notifier.setLocation(null) 
                : null,
          ),

          // Reset All Button (only when filters are active)
          if (_hasActiveFilters(filters))
            FilterChipWidget(
              label: 'Reset Filters',
              isSelected: false,
              onSelected: () => notifier.resetAllFilters(),
            ),
        ],
      ),
    );
  }

  bool _hasActiveFilters(WorkerSearchState state) {
    return state.category != null ||
        (state.availability?.isNotEmpty ?? false) ||
        (state.skills?.isNotEmpty ?? false) ||
        state.location != null;
  }
}
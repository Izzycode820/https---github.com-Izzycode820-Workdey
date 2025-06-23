import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/job_search_provider.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/shared/components/filter_chip.dart';

class JobFilterChips extends ConsumerWidget {
  const JobFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(jobSearchNotifierProvider);
    final notifier = ref.read(jobSearchNotifierProvider.notifier);
    final sheets = ref.read(jobFilterSheetsProvider);

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
            label: 'Type',
            isSelected: filters.jobType != null,
            count: filters.jobType != null ? 1 : null,
            onSelected: () => sheets.showJobTypeSheet(context, ref),
            onDeleted: filters.jobType != null 
                ? () => notifier.setJobType(null) 
                : null,
          ),

          FilterChipWidget(
            label: 'Nature',
            isSelected: filters.jobNature != null,
            count: filters.jobNature != null ? 1 : null,
            onSelected: () => sheets.showNatureSheet(context, ref),
            onDeleted: filters.jobNature != null 
                ? () => notifier.setJobNature(null) 
                : null,
          ),

          FilterChipWidget(
            label: 'Days',
            isSelected: filters.workingDays?.isNotEmpty ?? false,
            count: filters.workingDays?.length,
            onSelected: () => sheets.showWorkingDaysSheet(context, ref),
            onDeleted: (filters.workingDays?.isNotEmpty ?? false)
                ? () => notifier.setWorkingDays([]) 
                : null,
          ),

          FilterChipWidget(
            label: 'Skills',
            isSelected: filters.skills?.isNotEmpty ?? false,
            count: filters.skills?.length,
            onSelected: () => sheets.showSkillsSheet(context, ref),
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
              label: 'Reset All',
              isSelected: false,
              onSelected: () => notifier.resetAllFilters(),
            ),
        ],
      ),
    );
  }

  bool _hasActiveFilters(JobSearchState state) {
    return state.category != null ||
        state.jobType != null ||
        state.jobNature != null ||
        (state.workingDays?.isNotEmpty ?? false) ||
        (state.skills?.isNotEmpty ?? false) ||
        state.location != null;
  }
}
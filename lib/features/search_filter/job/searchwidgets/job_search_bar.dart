import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/features/search_filter/bottomsheet/job_bottomsheet.dart';
import 'package:workdey_frontend/features/search_filter/search_context.dart';
import 'package:workdey_frontend/screens/search_screen.dart';

class JobSearchBar extends ConsumerWidget{
  const JobSearchBar({super.key});

@override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jobSearchProvider);
    final notifier = ref.read(jobSearchProvider.notifier);

    return Column(
      children: [
        GestureDetector(
          onTap: () => _navigateToSearchInput(context, ref),
          child: Container(
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
                const Expanded(
                  child: Text(
                    'Search Jobs...',
                    style: TextStyle(
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.filter_list,
                    color: state.hasActiveFilters
                        ? Colors.green
                        : const Color(0xFF1E1E1E),
                  ),
                  onPressed: () => notifier.toggleFilters(),
                ),
              ],
            ),
          ),
        ),
        if (state.showFilters) _buildJobFilterPanel(context, ref),
      ],
    );
  }

  void _navigateToSearchInput(BuildContext context, WidgetRef ref) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SearchInputPage(
        searchContext: SearchContext.jobs,
        onSearch: (query) {
          ref.read(jobSearchProvider.notifier).setQuery(query);
          Navigator.pop(context); // Return to jobs page
        },
      ),
    ),
  );
}

  

 Widget _buildJobFilterPanel(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jobSearchProvider);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Filter by:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  label: state.category?.displayName ?? 'Category',
                  isActive: state.category != null,
                  onTap: () => showJobCategoryBottomSheet(context, ref),

                ),
                const SizedBox(width: 8),
                  _buildFilterChip(
                  label: state.jobType?.displayName ?? 'Job Type',
                  isActive: state.jobType != null,
                  onTap: () => showJobTypeBottomSheet(context, ref),

                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: state.jobNature?.displayName ?? 'Job Nature',
                  isActive: state.jobNature != null,
                  onTap: () => showJobNatureBottomSheet(context, ref),

                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: 'Working Days',
                  isActive: state.workingDays?.isNotEmpty ?? false,
                  onTap: () => showJobWorkingDaysBottomSheet(context, ref),
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: 'Skills',
                  isActive: state.skills?.isNotEmpty ?? false,
                  onTap: () => showJobSkillsBottomSheet(context, ref),
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: 'Location',
                  isActive: state.location != null,
                  onTap: () => showJobLocationBottomSheet(context, ref),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildFilterChip({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? Colors.green : Colors.grey,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.green : Colors.black87,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              isActive ? Icons.close : Icons.arrow_drop_down,
              size: 16,
              color: isActive ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
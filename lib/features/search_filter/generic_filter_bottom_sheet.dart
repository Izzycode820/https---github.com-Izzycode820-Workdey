// worker_category_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/features/search_filter/job/filterwidgets/job_filter_enum.dart';
import 'package:workdey_frontend/features/search_filter/job/searchwidgets/job_search_provider.dart';
import 'package:workdey_frontend/features/search_filter/worker/filterwidget/worker_filters_enums.dart';
import 'package:workdey_frontend/features/search_filter/worker/searchwidget/worker_search_provider.dart';

// worker category bottom sheet
void showWorkerCategoryBottomSheet(BuildContext context, WidgetRef ref) {
  final currentCategory = ref.watch(workerSearchProvider).category;
  
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return ListView(
        children: WorkerCategory.values.map((category) {
          final isSelected = currentCategory == category;
          return ListTile(
            leading: Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Colors.green : Colors.grey,
            ),
            title: Text(category.displayName),
            onTap: () {
              ref.read(workerSearchProvider.notifier)
                .setCategory(isSelected ? null : category);
              Navigator.pop(ctx);
            },
          );
        }).toList(),
      );
    },
  );
}

// job category
// Job Category Bottom Sheet
void showJobCategoryBottomSheet(BuildContext context, WidgetRef ref) {
  final currentCategory = ref.watch(jobSearchProvider).category;
  
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return ListView(
        children: JobCategory.values.map((category) {
          final isSelected = currentCategory == category;
          return ListTile(
            leading: Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Colors.green : Colors.grey,
            ),
            title: Text(category.displayName),
            onTap: () {
              ref.read(jobSearchProvider.notifier)
                .setcategory(isSelected ? null : category);
              Navigator.pop(ctx);
            },
          );
        }).toList(),
      );
    },
  );
}

// Job Type Bottom Sheet
void showJobTypeBottomSheet(BuildContext context, WidgetRef ref) {
  final currentJobType = ref.watch(jobSearchProvider).jobType;
  
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return ListView(
        children: JobType.values.map((jobType) {
          final isSelected = currentJobType == jobType;
          return ListTile(
            leading: Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Colors.green : Colors.grey,
            ),
            title: Text(jobType.displayName),
            onTap: () {
              ref.read(jobSearchProvider.notifier)
                .setJobType(isSelected ? null : jobType);
              Navigator.pop(ctx);
            },
          );
        }).toList(),
      );
    },
  );
}
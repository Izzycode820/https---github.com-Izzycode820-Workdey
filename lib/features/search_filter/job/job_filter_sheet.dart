import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/features/search_filter/bottomsheet/custom_bottomsheet_components.dart';
import 'package:workdey_frontend/features/search_filter/job_filter_enum.dart';

class JobFilterSheets {
  void showMainFilterSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: bottomSheetDecoration,
        child: ListView(
          children: [
            buildBottomSheetHeader(ctx, 'Filter Jobs'),
            _buildCategorySection(ref),
          //  _buildJobTypeSection(ref),
           // _buildSkillsSection(ref, context),
            buildBottomSheetApplyButton(ctx),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(WidgetRef ref) {
    final current = ref.watch(jobSearchNotifierProvider).category;
    return ExpansionTile(
      title: const Text('Categories'),
      children: [
        buildChoiceChips(
          options: JobCategory.values,
          isSelected: (c) => current == c,
          onSelected: (c, selected) => ref.read(jobSearchNotifierProvider.notifier)
              .setCategory(selected ? c : null),
          displayName: (c) => c.displayName,
        ),
      ],
    );
  }

  // Similar methods for other filter sections...
}

final jobFilterSheetsProvider = Provider((ref) => JobFilterSheets());
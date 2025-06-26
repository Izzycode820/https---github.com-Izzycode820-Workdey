import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/features/search_filter/bottomsheet/custom_bottomsheet_components.dart';
import 'package:workdey_frontend/features/search_filter/worker_filters_enums.dart';
import 'package:workdey_frontend/shared/enum/search_type.dart';

class WorkerFilterSheets {
  void showMainFilterSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: bottomSheetDecoration,
        child: ListView(
          children: [
            buildBottomSheetHeader(ctx, 'Filter Workers'),
            _buildCategorySection(ref),
         //   _buildAvailabilitySection(ref, context),
            buildBottomSheetApplyButton(ctx
            ,
                  ref: ref,
                  searchType: SearchType.worker,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(WidgetRef ref) {
    final current = ref.watch(workerSearchNotifierProvider).category;
    return ExpansionTile(
      title: const Text('Categories'),
      children: [
        buildChoiceChips(
          options: WorkerCategory.values,
          isSelected: (c) => current == c,
          onSelected: (c, selected) => ref.read(workerSearchNotifierProvider.notifier)
              .setCategory(selected ? c : null),
          displayName: (c) => c.displayName,
        ),
      ],
    );
  }
}

final workerFilterSheetsProvider = Provider((ref) => WorkerFilterSheets());
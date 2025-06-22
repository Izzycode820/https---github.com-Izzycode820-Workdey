import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/features/search_filter/bottomsheet/custom_bottomsheet_components.dart';
import 'package:workdey_frontend/features/search_filter/worker/filterwidget/worker_filters_enums.dart';
import 'package:workdey_frontend/core/providers/providers.dart';

// Shared constants
const _bottomSheetDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4, offset: Offset(0, -4))],
);

const _headerTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

const _categoryTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

const _buttonTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

// Worker Category Bottom Sheet
void showWorkerCategoryBottomSheet(BuildContext context, WidgetRef ref) {
  final currentCategory = ref.watch(workerSearchProvider.select((s) => s.category));

  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return Container(
        decoration: _bottomSheetDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildBottomSheetHeader(ctx, 'Worker Categories'),
            buildChoiceChips(
              options: WorkerCategory.values,
              isSelected: (category) => currentCategory == category,
              onSelected: (category, selected) {
                ref.read(workerSearchProvider.notifier)
                    .setCategory(selected ? category : null);
              },
              displayName: (category) => category.displayName,
            ),
            buildBottomSheetApplyButton(ctx),
          ],
        ),
      );
    },
  );
}

// Worker Availability Bottom Sheet (Fixed version)
void showWorkerAvailabilityBottomSheet(BuildContext context, WidgetRef ref) {
  final currentAvailability = ref.watch(workerSearchProvider.select((s) => s.availability));

  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            decoration: _bottomSheetDecoration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildBottomSheetHeader(ctx, 'Availability'),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: WorkerAvailability.values.map((availability) {
                      final isSelected = currentAvailability?.contains(availability) ?? false;
                      return ChoiceChip(
                        label: Text(availability.displayName, style: _categoryTextStyle),
                        selected: isSelected,
                        onSelected: (selected) {
                          final newAvailability = [...?currentAvailability];
                          if (selected) {
                            newAvailability.add(availability);
                          } else {
                            newAvailability.remove(availability);
                          }
                          ref.read(workerSearchProvider.notifier)
                              .setAvailability(newAvailability);
                          setState(() {});
                        },
                        // ... rest of the ChoiceChip styling
                      );
                    }).toList(),
                  ),
                ),
                buildBottomSheetApplyButton(ctx),
              ],
            ),
          );
        },
      );
    },
  );
}

// In workers_bottomsheet.dart
void showWorkerSkillsBottomSheet(BuildContext context, WidgetRef ref) {
  final currentSkills = ref.watch(workerSearchProvider.select((s) => s.skills));
  final textController = TextEditingController();

  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            decoration: _bottomSheetDecoration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildBottomSheetHeader(ctx, 'Skills'),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Add skill...',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (textController.text.isNotEmpty) {
                            final newSkills = [...?currentSkills, textController.text];
                            ref.read(workerSearchProvider.notifier)
                                .setSkills(newSkills);
                            textController.clear();
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ),
                ),
                if (currentSkills?.isNotEmpty ?? false)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 8,
                      children: currentSkills!.map((skill) {
                        return Chip(
                          label: Text(skill),
                          onDeleted: () {
                            final newSkills = [...currentSkills]..remove(skill);
                            ref.read(workerSearchProvider.notifier)
                                .setSkills(newSkills);
                            setState(() {});
                          },
                        );
                      }).toList(),
                    ),
                  ),
                buildBottomSheetApplyButton(ctx),
              ],
            ),
          );
        },
      );
    },
  );
}

void showWorkerLocationBottomSheet(BuildContext context, WidgetRef ref) {
  final currentLocation = ref.watch(workerSearchProvider).location;
  final textController = TextEditingController(text: currentLocation);

  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return Container(
        decoration: _bottomSheetDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildBottomSheetHeader(ctx, 'Location'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: 'Enter location...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      ref.read(workerSearchProvider.notifier)
                          .setLocation(textController.text.trim());
                      Navigator.pop(ctx);
                    },
                  ),
                ),
              ),
            ),
            buildBottomSheetApplyButton(
              ctx,
              onPressed: () {
                ref.read(workerSearchProvider.notifier)
                    .setLocation(textController.text.trim());
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      );
    },
  );
}


// Widget _buildChoiceChips<T>({
//   required List<T> options,
//   required bool Function(T) isSelected,
//   required void Function(T, bool) onSelected,
//   required String Function(T) displayName,
// }) {
//   return Padding(
//     padding: const EdgeInsets.all(12),
//     child: Wrap(
//       spacing: 6,
//       runSpacing: 6,
//       children: options.map((option) {
//         return ChoiceChip(
//           label: Text(displayName(option), style: _categoryTextStyle),
//           selected: isSelected(option),
//           onSelected: (selected) => onSelected(option, selected),
//           selectedColor: const Color(0xFF0a6b32),
//           backgroundColor: Colors.grey.shade100,
//           labelStyle: _categoryTextStyle.copyWith(
//             color: isSelected(option) ? Colors.white : Colors.black87,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(24),
//             side: BorderSide(
//               color: isSelected(option) 
//                   ? const Color(0xFF3E8728) 
//                   : Colors.grey.shade300,
//             ),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         );
//       }).toList(),
//     ),
//   );
// }


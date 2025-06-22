import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/features/search_filter/job/filterwidgets/job_filter_enum.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/features/search_filter/bottomsheet/custom_bottomsheet_components.dart';

// Reuse the same constants from workers_bottomsheet.dart




void showJobCategoryBottomSheet(BuildContext context, WidgetRef ref) {
  final currentCategory = ref.watch(jobSearchProvider).category;

  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return Container(
        decoration: bottomSheetDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildBottomSheetHeader(ctx, 'Job Categories'),
            buildChoiceChips(
              options: JobCategory.values,
              isSelected: (category) => currentCategory == category,
              onSelected: (category, selected) {
                ref.read(jobSearchProvider.notifier)
                    .setcategory(selected ? category : null);
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

void showJobSkillsBottomSheet(BuildContext context, WidgetRef ref) {
  final currentSkills = ref.watch(jobSearchProvider.select((s) => s.skills));
  final textController = TextEditingController();

  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            decoration: bottomSheetDecoration,
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
                            ref.read(jobSearchProvider.notifier)
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
                            ref.read(jobSearchProvider.notifier)
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

void showJobTypeBottomSheet(BuildContext context, WidgetRef ref) {
  final currentJobType = ref.watch(jobSearchProvider).jobType;

  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return Container(
        decoration: bottomSheetDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildBottomSheetHeader(ctx, 'Job Types'),
            buildChoiceChips(
              options: JobType.values,
              isSelected: (type) => currentJobType == type,
              onSelected: (type, selected) {
                ref.read(jobSearchProvider.notifier)
                    .setJobType(selected ? type : null);
              },
              displayName: (type) => type.displayName,
            ),
            buildBottomSheetApplyButton(ctx),
          ],
        ),
      );
    },
  );
}

// Job Location Bottom Sheet
void showJobLocationBottomSheet(BuildContext context, WidgetRef ref) {
  final currentLocation = ref.watch(jobSearchProvider).location;
  final textController = TextEditingController(text: currentLocation);

  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return Container(
        decoration: bottomSheetDecoration,
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
                      ref.read(jobSearchProvider.notifier)
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
                ref.read(jobSearchProvider.notifier)
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

// Job Working Days Bottom Sheet
void showJobWorkingDaysBottomSheet(BuildContext context, WidgetRef ref) {
  final currentWorkingDays = ref.watch(jobSearchProvider).workingDays;

  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            decoration: bottomSheetDecoration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildBottomSheetHeader(ctx, 'Working Days'),
                buildChoiceChips(
                  options: WorkingDays.values,
                  isSelected: (day) => currentWorkingDays?.contains(day) ?? false,
                  onSelected: (day, selected) {
                    final newDays = [...?currentWorkingDays];
                    if (selected) {
                      newDays.add(day);
                    } else {
                      newDays.remove(day);
                    }
                    ref.read(jobSearchProvider.notifier)
                        .setAvailability(newDays);
                    setState(() {});
                  },
                  displayName: (day) => day.displayName,
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

// Job Nature Bottom Sheet
void showJobNatureBottomSheet(BuildContext context, WidgetRef ref) {
  final currentJobNature = ref.watch(jobSearchProvider).jobNature;

  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return Container(
        decoration: bottomSheetDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildBottomSheetHeader(ctx, 'Job Nature'),
            buildChoiceChips(
              options: JobNature.values,
              isSelected: (nature) => currentJobNature == nature,
              onSelected: (nature, selected) {
                ref.read(jobSearchProvider.notifier)
                    .setJobNature(selected ? nature : null);
              },
              displayName: (nature) => nature.displayName,
            ),
            buildBottomSheetApplyButton(ctx),
          ],
        ),
      );
    },
  );
}


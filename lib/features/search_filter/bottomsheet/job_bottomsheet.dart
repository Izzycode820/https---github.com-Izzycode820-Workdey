import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/features/search_filter/bottomsheet/custom_bottomsheet_components.dart';
import 'package:workdey_frontend/features/search_filter/job_filter_enum.dart';
import 'package:workdey_frontend/shared/enum/search_type.dart';

// Reuse the same constants from workers_bottomsheet.dart




void showJobCategoryBottomSheet(BuildContext context, WidgetRef ref) {
  final currentCategory = ref.watch(jobSearchNotifierProvider).category;

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
                ref.read(jobSearchNotifierProvider.notifier)
                    .setCategory(selected ? category : null);
              },
              displayName: (category) => category.displayName,
            ),
            buildBottomSheetApplyButton(ctx,
              ref: ref,
              searchType: SearchType.job,),
          ],
        ),
      );
    },
  );
}

void showJobSkillsBottomSheet(BuildContext context, WidgetRef ref) {
  final currentSkills = ref.watch(jobSearchNotifierProvider.select((s) => s.skills));
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
                            ref.read(jobSearchNotifierProvider.notifier)
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
                            ref.read(jobSearchNotifierProvider.notifier)
                                .setSkills(newSkills);
                            setState(() {});
                          },
                        );
                      }).toList(),
                    ),
                  ),
                buildBottomSheetApplyButton(ctx,
              ref: ref,
              searchType: SearchType.job,),
              ],
            ),
          );
        },
      );
    },
  );
}

void showJobTypeBottomSheet(BuildContext context, WidgetRef ref) {
  final currentJobType = ref.watch(jobSearchNotifierProvider).jobType;

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
                ref.read(jobSearchNotifierProvider.notifier)
                    .setJobType(selected ? type : null);
              },
              displayName: (type) => type.displayName,
            ),
            buildBottomSheetApplyButton(ctx,
              ref: ref,
              searchType: SearchType.job,),
          ],
        ),
      );
    },
  );
}

// Job Location Bottom Sheet
void showJobLocationBottomSheet(BuildContext context, WidgetRef ref) {
  final currentLocation = ref.watch(jobSearchNotifierProvider).location;
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
                      ref.read(jobSearchNotifierProvider.notifier)
                          .setLocation(textController.text.trim());
                      Navigator.pop(ctx);
                    },
                  ),
                ),
              ),
            ),
            buildBottomSheetApplyButton(
              ctx, 
              ref: ref,
              searchType: SearchType.job,
              onPressed: () {
                ref.read(jobSearchNotifierProvider.notifier)
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
  final currentWorkingDays = ref.watch(jobSearchNotifierProvider).workingDays;

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
                    ref.read(jobSearchNotifierProvider.notifier)
                        .setWorkingDays(newDays);
                    setState(() {});
                  },
                  displayName: (day) => day.displayName,
                ),
                buildBottomSheetApplyButton(ctx,
              ref: ref,
              searchType: SearchType.job,),
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
  final currentJobNature = ref.watch(jobSearchNotifierProvider).jobNature;

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
                ref.read(jobSearchNotifierProvider.notifier)
                    .setJobNature(selected ? nature : null);
              },
              displayName: (nature) => nature.displayName,
            ),
            buildBottomSheetApplyButton(ctx,
              ref: ref,
              searchType: SearchType.job,),
          ],
        ),
      );
    },
  );
}


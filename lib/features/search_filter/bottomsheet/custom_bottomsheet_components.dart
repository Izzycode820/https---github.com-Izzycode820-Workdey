// shared_bottom_sheet_components.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/shared/enum/search_type.dart';

// Shared decoration
const bottomSheetDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4, offset: Offset(0, -4))],
);

// Shared text styles
const headerTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

const categoryTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

const buttonTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

// Reusable header widget
Widget buildBottomSheetHeader(BuildContext context, String title) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: headerTextStyle),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}

// Reusable choice chips widget
Widget buildChoiceChips<T>({
  required List<T> options,
  required bool Function(T) isSelected,
  required void Function(T, bool) onSelected,
  required String Function(T) displayName,
}) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Wrap(
      spacing: 6,
      runSpacing: 6,
      children: options.map((option) {
        return ChoiceChip(
          label: Text(displayName(option), style: categoryTextStyle),
          selected: isSelected(option),
          onSelected: (selected) => onSelected(option, selected),
          selectedColor: const Color(0xFF0a6b32),
          backgroundColor: Colors.grey.shade100,
          labelStyle: categoryTextStyle.copyWith(
            color: isSelected(option) ? Colors.white : Colors.black87,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: isSelected(option) 
                  ? const Color(0xFF3E8728) 
                  : Colors.grey.shade300,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        );
      }).toList(),
    ),
  );
}

// Reusable apply button
Widget buildBottomSheetApplyButton(
  BuildContext context, {
  required WidgetRef ref,
  required SearchType searchType,
  VoidCallback? onPressed,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3E8728),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.symmetric(vertical: 16)),
      onPressed: () {
        if (onPressed != null) onPressed();
        
        // Trigger search based on type
        if (searchType == SearchType.job) {
          ref.read(jobSearchNotifierProvider.notifier).searchJobs();
        } else {
          ref.read(workerSearchNotifierProvider.notifier).searchWorkers();
        }
        
        Navigator.pop(context);
      },
      child: Text('Show Results', style: buttonTextStyle),
    ),
  );
}
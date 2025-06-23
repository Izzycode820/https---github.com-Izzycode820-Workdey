import 'package:flutter/material.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  
  final bool isSelected;
  final VoidCallback onSelected;
  final VoidCallback? onDeleted;
  final int? count;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    this.onDeleted,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label),
            if (count != null) ...[
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.white : Colors.green,
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.green : Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
        selected: isSelected,
        onSelected: (_) => onSelected(),
        deleteIcon: onDeleted != null
            ? const Icon(Icons.close, size: 18)
            : null,
        onDeleted: onDeleted,
        backgroundColor: Colors.grey.shade100,
        selectedColor: Colors.green.shade100,
        checkmarkColor: Colors.green,
        labelStyle: TextStyle(
          color: isSelected ? Colors.green : Colors.black87,
        ),
        shape: StadiumBorder(
          side: BorderSide(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
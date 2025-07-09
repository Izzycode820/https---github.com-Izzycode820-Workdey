// lib/features/reviews/widgets/review_flag_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/review_provider.dart';

class ReviewFlagDialog extends ConsumerStatefulWidget {
  final int reviewId;

  const ReviewFlagDialog({super.key, required this.reviewId});

  @override
  ConsumerState<ReviewFlagDialog> createState() => _ReviewFlagDialogState();
}

class _ReviewFlagDialogState extends ConsumerState<ReviewFlagDialog> {
  String? _selectedReason;
  bool _isLoading = false;

  final List<String> _flagReasons = [
    'Inappropriate content',
    'False information',
    'Spam or irrelevant',
    'Personal attack',
    'Violates community guidelines',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Report Review'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Why are you reporting this review?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          
          ..._flagReasons.map((reason) {
            return RadioListTile<String>(
              title: Text(reason),
              value: reason,
              groupValue: _selectedReason,
              onChanged: (value) => setState(() => _selectedReason = value),
              activeColor: const Color(0xFF3E8728),
              dense: true,
              contentPadding: EdgeInsets.zero,
            );
          }).toList(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading || _selectedReason == null ? null : _submitFlag,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text('Report'),
        ),
      ],
    );
  }

  Future<void> _submitFlag() async {
    setState(() => _isLoading = true);

    try {
      await ref.read(reviewProvider.notifier).flagReview(widget.reviewId);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Review reported successfully'),
            backgroundColor: Color(0xFF3E8728),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error reporting review: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
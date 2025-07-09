import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/review_provider.dart';

class ReviewReplyDialog extends ConsumerStatefulWidget {
  final int reviewId;

  const ReviewReplyDialog({super.key, required this.reviewId});

  @override
  ConsumerState<ReviewReplyDialog> createState() => _ReviewReplyDialogState();
}

class _ReviewReplyDialogState extends ConsumerState<ReviewReplyDialog> {
  final _replyController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reply to Review'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Write a professional response to this review. Your reply will be visible to everyone.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _replyController,
            maxLines: 4,
            maxLength: 300,
            decoration: const InputDecoration(
              hintText: 'Thank you for your feedback...',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _submitReply,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3E8728),
          ),
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Reply'),
        ),
      ],
    );
  }

  Future<void> _submitReply() async {
    if (_replyController.text.trim().isEmpty) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(reviewProvider.notifier).replyToReview(
        widget.reviewId,
        _replyController.text.trim(),
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Reply posted successfully'),
            backgroundColor: Color(0xFF3E8728),
          ),
        );
        ref.read(reviewsReceivedProvider.notifier).refresh();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error posting reply: ${e.toString()}'),
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

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }
}
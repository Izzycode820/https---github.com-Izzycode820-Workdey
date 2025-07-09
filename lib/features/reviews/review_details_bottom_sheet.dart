// lib/features/reviews/widgets/review_details_bottom_sheet.dart - FIXED VERSION
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/profile/review/review_model.dart';
import 'package:workdey_frontend/core/providers/review_provider.dart';

class ReviewDetailsBottomSheet extends ConsumerStatefulWidget {
  final DetailedReview review; // ✅ Use DetailedReview instead of Review
  final bool isOwnReview;
  final VoidCallback? onReplyTap;
  final VoidCallback? onFlagTap;

  const ReviewDetailsBottomSheet({
    super.key,
    required this.review,
    this.isOwnReview = false,
    this.onReplyTap,
    this.onFlagTap,
  });

  @override
  ConsumerState<ReviewDetailsBottomSheet> createState() => _ReviewDetailsBottomSheetState();
}

class _ReviewDetailsBottomSheetState extends ConsumerState<ReviewDetailsBottomSheet> {
  bool _showFullComment = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          _buildHeader(),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRatingSection(),
                  const SizedBox(height: 24),
                  _buildCommentSection(),
                  if (widget.review.categoryRatings?.isNotEmpty == true) ...[
                    const SizedBox(height: 24),
                    _buildCategoryRatings(),
                  ],
                  const SizedBox(height: 24),
                  _buildReviewDetails(),
                  if (widget.review.reply != null) ...[
                    const SizedBox(height: 24),
                    _buildReplySection(),
                  ],
                  const SizedBox(height: 100), // Space for floating button
                ],
              ),
            ),
          ),

          // Action buttons
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Review type icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _getReviewTypeColor(widget.review.reviewType).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getReviewTypeIcon(widget.review.reviewType),
              color: _getReviewTypeColor(widget.review.reviewType),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.review.reviewTypeDisplay, // ✅ Use reviewTypeDisplay helper
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  widget.review.timeAgo, // ✅ Direct access to timeAgo
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // Close button
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber[200]!),
      ),
      child: Column(
        children: [
          // Overall rating
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                size: 32,
                color: Colors.amber[600],
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.review.overallRating}/5',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[700],
                    ),
                  ),
                  Text(
                    'Overall Rating',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              
              // Rating visualization
              Column(
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < widget.review.overallRating 
                            ? Icons.star 
                            : Icons.star_border,
                        size: 20,
                        color: Colors.amber,
                      );
                    }),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getRatingLabel(widget.review.overallRating),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Additional info
          if (widget.review.workComplexity != null || widget.review.wouldWorkAgain != null) ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (widget.review.workComplexity != null)
                  _buildInfoItem(
                    'Complexity',
                    widget.review.complexityDisplayText, // ✅ Use complexityDisplayText helper
                    Icons.psychology,
                  ),
                if (widget.review.wouldWorkAgain != null)
                  _buildInfoItem(
                    'Would Hire Again',
                    widget.review.wouldWorkAgain! ? 'Yes' : 'No',
                    widget.review.wouldWorkAgain! ? Icons.thumb_up : Icons.thumb_down,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.amber[600], size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCommentSection() {
    if (widget.review.comment.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.comment_outlined, color: Colors.grey[400], size: 24),
            const SizedBox(width: 12),
            Text(
              'No written review provided',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.format_quote, color: Colors.grey[600], size: 20),
              const SizedBox(width: 8),
              const Text(
                'Review Comment',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          Text(
            widget.review.comment,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.black87,
            ),
            maxLines: _showFullComment ? null : 3,
            overflow: _showFullComment ? null : TextOverflow.ellipsis,
          ),
          
          if (widget.review.comment.length > 150) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => setState(() => _showFullComment = !_showFullComment),
              child: Text(
                _showFullComment ? 'Show less' : 'Read more',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF3E8728),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCategoryRatings() {
    final categoryRatings = widget.review.categoryRatingsInt; // ✅ Use categoryRatingsInt helper
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Category Ratings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          ...categoryRatings.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      widget.review.getCategoryDisplayName(entry.key), // ✅ Use getCategoryDisplayName helper
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: entry.value / 5.0,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getRatingColor(entry.value),
                            ),
                            minHeight: 8,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${entry.value}/5',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getRatingColor(entry.value),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildReviewDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[600], size: 20),
              const SizedBox(width: 8),
              const Text(
                'Review Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          _buildDetailRow('Review ID', '#${widget.review.id}'),
          _buildDetailRow('Review Type', widget.review.reviewTypeDisplay),
          _buildDetailRow('Created', _formatFullDate(widget.review.createdAt)),
          _buildDetailRow('Reviewer', widget.review.reviewerInfo.role), // ✅ Use reviewerInfo.role
          // ✅ Removed updatedAt and isFlagged since they don't exist in response
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isWarning = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isWarning ? Colors.red[600] : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReplySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.reply, color: Colors.green[600], size: 20),
              const SizedBox(width: 8),
              const Text(
                'Reply',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Text(
                widget.review.reply!.timeAgo, // ✅ Use reply.timeAgo helper
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          Text(
            widget.review.reply!.replyText,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    if (widget.isOwnReview && widget.review.hasReply == false) { // ✅ Use hasReply helper
      // Show reply button for own reviews without replies
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _showFlagDialog(context),
                icon: const Icon(Icons.flag_outlined),
                label: const Text('Report'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: () => _showReplyDialog(context),
                icon: const Icon(Icons.reply),
                label: const Text('Reply'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E8728),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Show only report button for other cases
    return Container(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () => _showFlagDialog(context),
          icon: const Icon(Icons.flag_outlined),
          label: const Text('Report Review'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }

  // Dialog methods
  void _showReplyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ReviewReplyDialog(reviewId: widget.review.id),
    ).then((result) {
      if (result == true) {
        // Refresh reviews after successful reply
        ref.read(reviewsReceivedProvider.notifier).refresh();
        Navigator.pop(context); // Close bottom sheet
      }
    });
  }

  void _showFlagDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ReviewFlagDialog(reviewId: widget.review.id),
    ).then((result) {
      if (result == true) {
        Navigator.pop(context); // Close bottom sheet
      }
    });
  }

  // Helper methods
  IconData _getReviewTypeIcon(String reviewType) {
    switch (reviewType) {
      case 'JOB_EMP_WORKER':
        return Icons.work_outline;
      case 'JOB_WORKER_EMP':
        return Icons.person_outline;
      case 'SERVICE_CLIENT':
        return Icons.handyman_outlined;
      case 'COMMUNITY':
        return Icons.people_outline;
      default:
        return Icons.star_outline;
    }
  }

  Color _getReviewTypeColor(String reviewType) {
    switch (reviewType) {
      case 'JOB_EMP_WORKER':
        return Colors.blue;
      case 'JOB_WORKER_EMP':
        return Colors.green;
      case 'SERVICE_CLIENT':
        return Colors.orange;
      case 'COMMUNITY':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 5:
        return 'Excellent';
      case 4:
        return 'Very Good';
      case 3:
        return 'Good';
      case 2:
        return 'Fair';
      case 1:
        return 'Poor';
      default:
        return 'Not Rated';
    }
  }

  Color _getRatingColor(int rating) {
    if (rating >= 4) return Colors.green;
    if (rating >= 3) return Colors.orange;
    return Colors.red;
  }

  String _formatFullDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

// Dialog widgets for reply and flag functionality
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
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Reply posted successfully'),
            backgroundColor: Color(0xFF3E8728),
          ),
        );
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
        Navigator.pop(context, true);
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
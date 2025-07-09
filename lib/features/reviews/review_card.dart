// lib/features/reviews/widgets/review_card.dart - FIXED FOR ACTUAL BACKEND RESPONSE
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/review/review_model.dart';
import 'package:workdey_frontend/features/reviews/review_details_bottom_sheet.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  final bool isOwnReview;
  final VoidCallback? onReplyTap;
  final VoidCallback? onFlagTap;

  const ReviewCard({
    super.key,
    required this.review,
    this.isOwnReview = false,
    this.onReplyTap,
    this.onFlagTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showReviewDetailsBottomSheet(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildRatingRow(),
              const SizedBox(height: 8),
              _buildCommentPreview(),
              const SizedBox(height: 12),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Reviewer Avatar/Icon
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _getReviewTypeColor().withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            _getReviewTypeIcon(),
            color: _getReviewTypeColor(),
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Review Type or Reviewer Name
              Text(
                _isDetailedReview() ? _getReviewTypeDisplay() : _getReviewerName(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              // Time Ago
              Text(
                review.timeAgo ?? 'Recently',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        
        // Review Type Badge (only for detailed reviews)
        if (_isDetailedReview())
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getReviewTypeColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _getReviewTypeBadge(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: _getReviewTypeColor(),
              ),
            ),
          ),
        
        // Tap indicator
        const SizedBox(width: 8),
        Icon(
          Icons.chevron_right,
          size: 20,
          color: Colors.grey[400],
        ),
      ],
    );
  }

  Widget _buildRatingRow() {
    return Row(
      children: [
        // Star Rating
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < review.overallRating ? Icons.star : Icons.star_border,
              size: 16,
              color: Colors.amber,
            );
          }),
        ),
        const SizedBox(width: 8),
        
        // Rating Number
        Text(
          '${review.overallRating}/5',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        
        const Spacer(),
        
        // Work Complexity (if available)
        if (review.complexityDisplay != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              review.complexityDisplay!,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCommentPreview() {
    if (review.comment.isEmpty) {
      return Text(
        'No written review',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[500],
          fontStyle: FontStyle.italic,
        ),
      );
    }

    return Text(
      review.comment,
      style: const TextStyle(
        fontSize: 14,
        height: 1.4,
        color: Colors.black87,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        // Review Context
        Expanded(
          child: Text(
            _getReviewContext(),
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF3E8728),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        
        // Indicators
        Row(
          children: [
            // Would Work Again indicator
            if (review.wouldWorkAgain == true)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.thumb_up,
                      size: 10,
                      color: Colors.green[700],
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'Would hire again',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.green[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            
            // Reply indicator
            if (review.reply != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.reply,
                      size: 10,
                      color: Colors.blue[700],
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'Replied',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  void _showReviewDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReviewDetailsBottomSheet(
        review: review,
        isOwnReview: isOwnReview,
        onReplyTap: onReplyTap,
        onFlagTap: onFlagTap,
      ),
    );
  }

  // ========== HELPER METHODS ==========

  bool _isDetailedReview() {
    return review.reviewType != null;
  }

  String _getReviewerName() {
    return review.reviewerInfo?.role ?? 'Anonymous Reviewer';
  }

  String _getReviewContext() {
    if (review.reviewType != null) {
      switch (review.reviewType!) {
        case 'JOB_EMP_WORKER':
          return 'Job Review';
        case 'JOB_WORKER_EMP':
          return 'Employer Review';
        case 'SERVICE_CLIENT':
          return 'Service Review';
        case 'COMMUNITY':
          return 'Community Review';
        default:
          return 'Review';
      }
    }
    return 'General Review';
  }

  IconData _getReviewTypeIcon() {
    if (review.reviewType != null) {
      switch (review.reviewType!) {
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
    return Icons.star_outline;
  }

  Color _getReviewTypeColor() {
    if (review.reviewType != null) {
      switch (review.reviewType!) {
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
    return const Color(0xFF3E8728);
  }

  String _getReviewTypeDisplay() {
    if (review.reviewType == null) return 'Review';
    
    switch (review.reviewType!) {
      case 'JOB_EMP_WORKER':
        return 'Job Review from Employer';
      case 'JOB_WORKER_EMP':
        return 'Review for Employer';
      case 'SERVICE_CLIENT':
        return 'Service Review from Client';
      case 'COMMUNITY':
        return 'Community Endorsement';
      default:
        return 'Review';
    }
  }

  String _getReviewTypeBadge() {
    if (review.reviewType == null) return 'REV';
    
    switch (review.reviewType!) {
      case 'JOB_EMP_WORKER':
        return 'JOB';
      case 'JOB_WORKER_EMP':
        return 'EMP';
      case 'SERVICE_CLIENT':
        return 'SVC';
      case 'COMMUNITY':
        return 'COM';
      default:
        return 'REV';
    }
  }
}
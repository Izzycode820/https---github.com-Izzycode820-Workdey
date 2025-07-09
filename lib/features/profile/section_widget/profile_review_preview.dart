// lib/features/profile/widgets/profile_review_preview.dart
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/review/review_model.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/routes/routes.dart';
import 'package:workdey_frontend/features/reviews/review_card.dart';
import 'package:workdey_frontend/features/reviews/review_details_bottom_sheet.dart';

class ProfileReviewsPreview extends StatelessWidget {
  final List<Review> recentReviews;
  final ReviewSummary? reviewSummary;
  final bool isOwnProfile;

  const ProfileReviewsPreview({
    super.key,
    required this.recentReviews,
    this.reviewSummary,
    required this.isOwnProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Reviews',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  if (reviewSummary != null && reviewSummary!.totalReviews > 0) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 10,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${reviewSummary!.averageRating.toStringAsFixed(1)} (${reviewSummary!.totalReviews})',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              if (reviewSummary != null && reviewSummary!.totalReviews > 3)
                InkWell(
                  onTap: () => _navigateToAllReviews(context),
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 11,
                        color: const Color(0xFF3E8728),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Review Summary Stats
          if (reviewSummary != null && reviewSummary!.totalReviews > 0) ...[
            _buildReviewSummary(),
            const SizedBox(height: 12),
          ],
          
          // Recent Reviews
          if (recentReviews.isNotEmpty)
            _buildRecentReviews()
          else
            _buildEmptyState(),
        ],
      ),
    );
  }

  Widget _buildReviewSummary() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber[200]!),
      ),
      child: Column(
        children: [
          // Overall Rating Row
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                size: 24,
                color: Colors.amber[600],
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reviewSummary!.averageRating.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber[700],
                    ),
                  ),
                  Text(
                    'out of 5',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${reviewSummary!.totalReviews}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'review${reviewSummary!.totalReviews == 1 ? '' : 's'}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Key Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                '${reviewSummary!.positivePercentage!.toInt()}%',
                'Positive',
                Colors.green,
              ),
              _buildStatItem(
                '${reviewSummary!.wouldWorkAgainPercentage!.toInt()}%',
                'Rehire',
                Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRecentReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Reviews',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        ...recentReviews.take(3).map((review) => _buildReviewCard(review)),
      ],
    );
  }

  Widget _buildReviewCard(Review review) {
  return Builder(
    builder: (context) {
      return ReviewCard(
        review: review,
        isOwnReview: isOwnProfile,
        onReplyTap: isOwnProfile && review.reply == null
            ? () => _showReplyDialog(context, review.id)
            : null,
        onFlagTap: () => _showFlagDialog(context, review.id),
      );
    },
  );
}

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Icon(
            Icons.rate_review_outlined,
            size: 24,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            isOwnProfile ? 'No Reviews Yet' : 'No Reviews Available',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isOwnProfile
                ? 'Complete jobs to start receiving reviews'
                : 'This user hasn\'t received any reviews yet',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

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

  String _getReviewTypeDisplay(String reviewType) {
    switch (reviewType) {
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

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 30) {
      return DateFormat('MMM d').format(dateTime);
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Now';
    }
  }

 void _navigateToAllReviews(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.reviews);
}

void _showReplyDialog(BuildContext context, int reviewId) {
  showDialog(
    context: context,
    builder: (context) => ReviewReplyDialog(reviewId: reviewId),
  );
}

void _showFlagDialog(BuildContext context, int reviewId) {
  showDialog(
    context: context,
    builder: (context) => ReviewFlagDialog(reviewId: reviewId),
  );
}
}
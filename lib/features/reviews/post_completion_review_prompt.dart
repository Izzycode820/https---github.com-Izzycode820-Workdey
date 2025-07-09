// lib/features/reviews/widgets/post_completion_review_prompt.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/post_completion_review_provider.dart';
import 'package:workdey_frontend/features/reviews/create_review_form.dart';

class PostCompletionReviewPrompt extends ConsumerWidget {
  final Job job;
  final int applicationId;
  final String userRole; // 'employer' or 'worker'
  final VoidCallback? onReviewSubmitted;

  const PostCompletionReviewPrompt({
    super.key,
    required this.job,
    required this.applicationId,
    required this.userRole,
    this.onReviewSubmitted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3E8728).withOpacity(0.1),
            const Color(0xFF3E8728).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3E8728).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF3E8728).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.rate_review,
                  color: Color(0xFF3E8728),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Job Completed! 🎉',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Share your experience',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Job context
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3E8728),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      job.locationDisplayText,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Review prompt
          Text(
            _getReviewPromptText(),
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _dismissPrompt(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  child: const Text('Maybe Later'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () => _navigateToReviewForm(context),
                  icon: const Icon(Icons.star),
                  label: const Text('Write Review'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E8728),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getReviewPromptText() {
    switch (userRole) {
      case 'employer':
        return 'How was your experience with the worker? Your review helps other employers make informed hiring decisions and builds trust in our community.';
      case 'worker':
        return 'How was working for this employer? Share your experience to help other workers know what to expect.';
      default:
        return 'Share your experience to help build trust in our community.';
    }
  }

  void _navigateToReviewForm(BuildContext context) {
    final reviewType = userRole == 'employer' ? 'JOB_EMP_WORKER' : 'JOB_WORKER_EMP';
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateReviewForm(
          reviewType: reviewType,
          job: job,
          applicationId: applicationId,
        ),
      ),
    ).then((result) {
      if (result == true && onReviewSubmitted != null) {
        onReviewSubmitted!();
      }
    });
  }

  void _dismissPrompt(BuildContext context) {
    // For now, just hide the prompt
    // In a real app, you might want to save this preference
    Navigator.pop(context);
  }
}

// lib/features/reviews/widgets/pending_reviews_list.dart
class PendingReviewsList extends ConsumerWidget {
  const PendingReviewsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingReviews = ref.watch(postCompletionReviewProvider);

    return pendingReviews.when(
      data: (reviews) {
        if (reviews.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.pending_actions,
                      color: Colors.amber[700],
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pending Reviews',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '${reviews.length} completed job${reviews.length == 1 ? '' : 's'} waiting for your review',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Pending items
              ...reviews.take(3).map((reviewData) => _buildPendingReviewItem(
                context, 
                ref, 
                reviewData,
              )).toList(),
              
              // View all button if more than 3
              if (reviews.length > 3)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextButton(
                    onPressed: () => _navigateToAllPendingReviews(context),
                    child: Text(
                      'View all ${reviews.length} pending reviews',
                      style: const TextStyle(
                        color: Color(0xFF3E8728),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }

  Widget _buildPendingReviewItem(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> reviewData,
  ) {
    final job = Job.fromJson(reviewData['job']);
    final userRole = reviewData['user_role'] as String;
    final applicationId = reviewData['application_id'] as int;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          // Job type indicator
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getJobTypeColor(job.jobType).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.work_outline,
              color: _getJobTypeColor(job.jobType),
              size: 20,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Job info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Review ${userRole == 'employer' ? 'worker' : 'employer'}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // Review button
          ElevatedButton(
            onPressed: () => _navigateToReviewForm(
              context, 
              job, 
              applicationId, 
              userRole,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3E8728),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              minimumSize: Size.zero,
            ),
            child: const Text(
              'Review',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Color _getJobTypeColor(String jobType) {
    switch (jobType) {
      case 'PRO':
        return Colors.blue;
      case 'INT':
        return Colors.green;
      case 'VOL':
        return Colors.orange;
      case 'LOC':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  void _navigateToReviewForm(
    BuildContext context,
    Job job,
    int applicationId,
    String userRole,
  ) {
    final reviewType = userRole == 'employer' ? 'JOB_EMP_WORKER' : 'JOB_WORKER_EMP';
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateReviewForm(
          reviewType: reviewType,
          job: job,
          applicationId: applicationId,
        ),
      ),
    );
  }

  void _navigateToAllPendingReviews(BuildContext context) {
    // Navigate to a dedicated screen showing all pending reviews
    // Navigator.pushNamed(context, '/reviews/pending');
  }
}

// lib/features/reviews/widgets/review_completion_notification.dart
class ReviewCompletionNotification extends ConsumerWidget {
  final Job job;
  final String userRole;

  const ReviewCompletionNotification({
    super.key,
    required this.job,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showReviewPrompt(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF3E8728).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF3E8728).withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.rate_review,
                  color: const Color(0xFF3E8728),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Job completed successfully!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tap to share your experience',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF3E8728),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showReviewPrompt(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: PostCompletionReviewPrompt(
          job: job,
          applicationId: 0, // You'll need to pass the actual application ID
          userRole: userRole,
          onReviewSubmitted: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Thank you for your review!'),
                backgroundColor: Color(0xFF3E8728),
              ),
            );
          },
        ),
      ),
    );
  }
}
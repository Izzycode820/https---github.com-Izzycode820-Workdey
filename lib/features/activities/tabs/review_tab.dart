// lib/features/activities/tabs/review_tab.dart - FIXED FOR PENDING REVIEWS
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/activity_state_provider.dart';
import 'package:workdey_frontend/core/providers/post_completion_review_provider.dart';
import 'package:workdey_frontend/core/providers/review_provider.dart';
import 'package:workdey_frontend/features/activities/activity_state_builder.dart';
import 'package:workdey_frontend/features/reviews/create_review_form.dart';
import 'package:workdey_frontend/screens/reviews_screen.dart';

class ReviewsActivityTab extends ConsumerStatefulWidget {
  final VoidCallback? onRefresh;

  const ReviewsActivityTab({super.key, this.onRefresh});

  @override
  ConsumerState<ReviewsActivityTab> createState() => _ReviewsActivityTabState();
}

class _ReviewsActivityTabState extends ConsumerState<ReviewsActivityTab> {
  bool _isRefreshing = false;

  @override
  Widget build(BuildContext context) {
    // FIXED: Watch both activity tab state AND direct pending reviews provider
    final tabState = ref.watch(reviewsTabProvider);
    final pendingReviewsAsync = ref.watch(postCompletionReviewProvider);

    // FIXED: Debug logging
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint('🔍 ReviewsTab Debug:');
      debugPrint('  - Tab Status: ${tabState.status}');
      debugPrint('  - Tab Count: ${tabState.count}');
      debugPrint('  - Tab Data Type: ${tabState.data.runtimeType}');
      
      pendingReviewsAsync.when(
        data: (pending) => debugPrint('  - Direct Pending Count: ${pending.length}'),
        loading: () => debugPrint('  - Direct Pending: Loading'),
        error: (e, s) => debugPrint('  - Direct Pending Error: $e'),
      );
    });

    // FIXED: Use direct pending reviews provider as primary data source
    return pendingReviewsAsync.when(
      data: (pendingReviews) => _buildSuccessState(pendingReviews),
      loading: () => _buildLoadingState(),
      error: (error, stackTrace) => _buildErrorState(error, stackTrace),
    );
  }

  // FIXED: Build success state with pending reviews
  Widget _buildSuccessState(List<Map<String, dynamic>> pendingReviews) {
    return Column(
      children: [
        // Refresh header
        _buildRefreshHeader(pendingReviews.length),
        
        // Content based on pending reviews
        Expanded(
          child: pendingReviews.isEmpty 
              ? _buildNoPendingReviewsState()
              : _buildPendingReviewsList(pendingReviews),
        ),
      ],
    );
  }

  Widget _buildPendingReviewsList(List<Map<String, dynamic>> pendingReviews) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: Colors.orange,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pendingReviews.length + 1, // +1 for "View All Reviews" button
        itemBuilder: (context, index) {
          if (index == pendingReviews.length) {
            // "View All Reviews" button at the end
            return _buildViewAllReviewsButton();
          }

          final reviewOpportunity = pendingReviews[index];
          
          // FIXED: Debug each review opportunity
          debugPrint('🔍 Rendering Review Opportunity ${index + 1}:');
          debugPrint('  - Job ID: ${reviewOpportunity['job']?.id}');
          debugPrint('  - Job Title: ${reviewOpportunity['job']?.title}');
          debugPrint('  - User Role: ${reviewOpportunity['user_role']}');
          debugPrint('  - Application ID: ${reviewOpportunity['application_id']}');
          
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: PendingReviewCard(
              reviewOpportunity: reviewOpportunity,
              onReviewSubmitted: () {
                widget.onRefresh?.call();
                _handleRefresh();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoPendingReviewsState() {
    final totalReviewsCount = ref.watch(totalReviewsCountProvider);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_outline,
                size: 60,
                color: Colors.green[400],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'All Caught Up!',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF181A1F),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              totalReviewsCount > 0 
                  ? 'No pending reviews. You have $totalReviewsCount total reviews.'
                  : 'Complete jobs to start receiving and giving reviews.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (totalReviewsCount > 0) ...[
                  ElevatedButton.icon(
                    onPressed: () => _navigateToReviewsScreen(),
                    icon: const Icon(Icons.star, size: 18),
                    label: const Text('View Reviews'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3E8728),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                OutlinedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/find-jobs'),
                  icon: const Icon(Icons.search, size: 18),
                  label: const Text('Find Jobs'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF3E8728),
                    side: const BorderSide(color: Color(0xFF3E8728)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewAllReviewsButton() {
    final totalReviewsCount = ref.watch(totalReviewsCountProvider);
    
    if (totalReviewsCount == 0) return const SizedBox.shrink();
    
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 8),
      child: Material(
        color: const Color(0xFF3E8728).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: _navigateToReviewsScreen,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: Color(0xFF3E8728),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'View All Reviews ($totalReviewsCount)',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3E8728),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Loading review opportunities...',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF181A1F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error, StackTrace stackTrace) {
    debugPrint('❌ Reviews Tab Error: $error');
    debugPrint('Stack Trace: $stackTrace');

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.warning_outlined,
                size: 40,
                color: Colors.orange[600],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Unable to Load Reviews',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF181A1F),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Error: ${error.toString()}',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _handleRefresh,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: _navigateToReviewsScreen,
                  icon: const Icon(Icons.star),
                  label: const Text('View Reviews'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.orange,
                    side: const BorderSide(color: Colors.orange),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRefreshHeader(int pendingCount) {
    final totalReviewsCount = ref.watch(totalReviewsCountProvider);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Text(
            pendingCount > 0 
                ? '$pendingCount pending, $totalReviewsCount total'
                : '$totalReviewsCount reviews received',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: _isRefreshing ? null : _handleRefresh,
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isRefreshing)
                    SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[600]!),
                      ),
                    )
                  else
                    Icon(
                      Icons.refresh,
                      size: 14,
                      color: Colors.orange[600],
                    ),
                  const SizedBox(width: 4),
                  Text(
                    'Refresh',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // FIXED: Enhanced refresh with better error handling
  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;
    
    setState(() => _isRefreshing = true);
    
    try {
      debugPrint('🔄 ReviewsTab: Starting manual refresh...');
      
      // Refresh both pending reviews and activity center
      await Future.wait([
        ref.read(postCompletionReviewProvider.notifier).refresh(),
        ref.read(activityCenterProvider.notifier).refreshSingleTab(ActivityTab.reviews),
      ]);
      
      debugPrint('✅ ReviewsTab: Refresh completed');
      widget.onRefresh?.call();
      
    } catch (e) {
      debugPrint('❌ ReviewsTab: Refresh failed: $e');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to refresh reviews: ${e.toString()}'),
            backgroundColor: Colors.orange,
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: _handleRefresh,
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isRefreshing = false);
      }
    }
  }

  void _navigateToReviewsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ReviewsScreen(),
      ),
    );
  }
}

// FIXED: Simplified Pending Review Card
class PendingReviewCard extends StatelessWidget {
  final Map<String, dynamic> reviewOpportunity;
  final VoidCallback? onReviewSubmitted;

  const PendingReviewCard({
    super.key,
    required this.reviewOpportunity,
    this.onReviewSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final job = reviewOpportunity['job'];
    final userRole = reviewOpportunity['user_role'] as String? ?? '';
    final applicationId = reviewOpportunity['application_id'] as int?;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
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
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.rate_review, color: Colors.orange, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Review Needed',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF181A1F),
                      ),
                    ),
                    Text(
                      _getReviewTypeDisplay(userRole),
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
                size: 20,
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Job info
          if (job != null) ...[
            Text(
              job['title'] ?? 'Job Review',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF3E8728),
              ),
            ),
            const SizedBox(height: 4),
            if (job['location'] != null)
              Text(
                job['location'],
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
          ],
          
          const SizedBox(height: 8),
          const Text(
            'Job completed successfully! Share your experience.',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              height: 1.4,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Action button
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton.icon(
              onPressed: () => _navigateToReviewForm(context),
              icon: const Icon(Icons.star, size: 16),
              label: const Text(
                'Write Review',
                style: TextStyle(fontSize: 12),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getReviewTypeDisplay(String userRole) {
    switch (userRole) {
      case 'employer':
        return 'Review Worker Performance';
      case 'worker':
        return 'Review Employer Experience';
      default:
        return 'Leave Review';
    }
  }

  void _navigateToReviewForm(BuildContext context) {
    final userRole = reviewOpportunity['user_role'] as String? ?? '';
    final reviewType = userRole == 'employer' ? 'JOB_EMP_WORKER' : 'JOB_WORKER_EMP';
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateReviewForm(
          reviewType: reviewType,
          applicationId: reviewOpportunity['application_id'] as int?,
        ),
      ),
    ).then((result) {
      if (result == true && onReviewSubmitted != null) {
        onReviewSubmitted!();
      }
    });
  }
}
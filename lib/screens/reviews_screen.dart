// lib/features/reviews/screens/reviews_screen.dart - COMPLETELY FIXED
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/post_completion_review_provider.dart';
import 'package:workdey_frontend/core/providers/review_provider.dart';
import 'package:workdey_frontend/features/reviews/post_completion_review_prompt.dart';
import 'package:workdey_frontend/features/reviews/review_card.dart';
import 'package:workdey_frontend/features/reviews/review_filter_bar.dart';
import 'package:workdey_frontend/features/reviews/review_filter_bottom_sheet.dart';
import 'package:workdey_frontend/features/reviews/review_flag_dialog.dart';
import 'package:workdey_frontend/features/reviews/review_reply_dailog.dart';

class ReviewsScreen extends ConsumerStatefulWidget {
  final bool showGivenReviews;

  const ReviewsScreen({
    super.key,
    this.showGivenReviews = false,
  });

  @override
  ConsumerState<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends ConsumerState<ReviewsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.showGivenReviews ? 1 : 0,
    );
    // ✅ Removed _onScroll listener since there's no pagination
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Reviews'),
        backgroundColor: const Color(0xFF3E8728),
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Received', icon: Icon(Icons.star, size: 20)),
            Tab(text: 'Given', icon: Icon(Icons.rate_review, size: 20)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter bar
          const ReviewFilterBar(),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildReceivedReviewsTab(),
                _buildGivenReviewsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceivedReviewsTab() {
    final reviewsReceived = ref.watch(reviewsReceivedProvider);
    final hasPendingReviews = ref.watch(hasPendingReviewsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(reviewsReceivedProvider.notifier).refresh();
        await ref.read(postCompletionReviewProvider.notifier).refresh();
      },
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Pending reviews prompt
          if (hasPendingReviews)
            const SliverToBoxAdapter(
              child: PendingReviewsList(),
            ),

          // Reviews list
          reviewsReceived.when(
            data: (reviewsResponse) { // ✅ Fixed: use ReviewsResponse, not paginatedReviews
              if (reviewsResponse.reviews.isEmpty) {
                return SliverFillRemaining(
                  child: _buildEmptyState(
                    'No Reviews Yet',
                    'Complete jobs and provide services to start receiving reviews from the community.',
                    Icons.star_outline,
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    // ✅ Removed loadMore logic since there's no pagination
                    final review = reviewsResponse.reviews[index]; // ✅ Fixed: access reviews list
                    return ReviewCard(
                      review: review,
                      isOwnReview: true,
                      onReplyTap: review.reply == null
                          ? () => _showReplyDialog(context, review.id)
                          : null,
                      onFlagTap: () => _showFlagDialog(context, review.id),
                    );
                  },
                  childCount: reviewsResponse.reviews.length, // ✅ Fixed: use reviews list length
                ),
              );
            },
            loading: () => SliverFillRemaining(
              child: _buildLoadingState(),
            ),
            error: (error, stack) => SliverFillRemaining(
              child: _buildErrorState(error.toString()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGivenReviewsTab() {
    final reviewsGiven = ref.watch(reviewsGivenProvider);

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(reviewsGivenProvider.notifier).refresh();
      },
      child: reviewsGiven.when(
        data: (reviewsResponse) { // ✅ Fixed: use ReviewsResponse, not paginatedReviews
          if (reviewsResponse.reviews.isEmpty) {
            return _buildEmptyState(
              'No Reviews Written',
              'You haven\'t written any reviews yet. Complete jobs and share your experience.',
              Icons.rate_review_outlined,
            );
          }

          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: reviewsResponse.reviews.length, // ✅ Fixed: use reviews list length, no pagination
            itemBuilder: (context, index) {
              final review = reviewsResponse.reviews[index]; // ✅ Fixed: access reviews list
              return ReviewCard(
                review: review,
                isOwnReview: false, // User wrote this review
                onReplyTap: null, // Can't reply to own reviews
                onFlagTap: null, // Can't flag own reviews
              );
            },
          );
        },
        loading: () => _buildLoadingState(),
        error: (error, stack) => _buildErrorState(error.toString()),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Color(0xFF3E8728)),
          SizedBox(height: 16),
          Text(
            'Loading reviews...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Unable to load reviews',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                if (_tabController.index == 0) {
                  ref.read(reviewsReceivedProvider.notifier).refresh();
                } else {
                  ref.read(reviewsGivenProvider.notifier).refresh();
                }
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E8728),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String title, String description, IconData icon) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to jobs or services
                Navigator.pushNamed(context, '/find-jobs');
              },
              icon: const Icon(Icons.work),
              label: const Text('Find Jobs'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E8728),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Removed _buildLoadMoreIndicator since there's no pagination

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ReviewFilterBottomSheet(),
    );
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
      builder: (context) {
        return ReviewFlagDialog(reviewId: reviewId);
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
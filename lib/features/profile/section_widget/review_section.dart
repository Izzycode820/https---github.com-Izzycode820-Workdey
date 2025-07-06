// lib/features/profile/widgets/profile_reviews_section.dart
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/review/review_model.dart';

class ProfileReviewsSection extends StatefulWidget {
  final List<Review> reviews;
  final ReviewSummary? reviewSummary;
  final bool isOwnProfile;

  const ProfileReviewsSection({
    super.key,
    required this.reviews,
    this.reviewSummary,
    required this.isOwnProfile,
  });

  @override
  State<ProfileReviewsSection> createState() => _ProfileReviewsSectionState();
}

class _ProfileReviewsSectionState extends State<ProfileReviewsSection> {
  String _selectedFilter = 'all';
  bool _showAllReviews = false;

  @override
  Widget build(BuildContext context) {
    final filteredReviews = _getFilteredReviews();
    final displayReviews = _showAllReviews ? filteredReviews : filteredReviews.take(3).toList();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
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
      child: Padding(
        padding: const EdgeInsets.all(20),
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    if (widget.reviews.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 12,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.reviewSummary?.averageRating.toStringAsFixed(1) ?? '0.0',
                              style: const TextStyle(
                                fontSize: 12,
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
                if (widget.reviews.isNotEmpty)
                  TextButton(
                    onPressed: () => _showAllReviewsDialog(context),
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF3E8728),
                      ),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Reviews Content
            if (widget.reviews.isNotEmpty) ...[
              // Review Summary Stats
              if (widget.reviewSummary != null)
                _buildReviewSummary(),
              
              const SizedBox(height: 16),
              
              // Review Filters
              _buildReviewFilters(),
              
              const SizedBox(height: 16),
              
              // Review List
              ...displayReviews.map((review) => _buildReviewCard(review)),
              
              // Show More Button
              if (filteredReviews.length > 3 && !_showAllReviews)
                _buildShowMoreButton(filteredReviews.length - 3),
            ] else
              _buildEmptyState(),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewSummary() {
    final summary = widget.reviewSummary!;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.amber.withOpacity(0.1),
            Colors.orange.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          // Overall Rating
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          summary.averageRating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < summary.averageRating.floor()
                                      ? Icons.star
                                      : index < summary.averageRating
                                          ? Icons.star_half
                                          : Icons.star_border,
                                  color: Colors.amber,
                                  size: 16,
                                );
                              }),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${summary.totalReviews} review${summary.totalReviews == 1 ? '' : 's'}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Would Work Again Percentage
              if (summary.wouldWorkAgainPercentage > 0)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${summary.wouldWorkAgainPercentage.round()}%',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Would hire\nagain',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.green[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Rating Breakdown
          if (summary.ratingBreakdown != null)
            _buildRatingBreakdown(summary.ratingBreakdown!),
        ],
      ),
    );
  }

  Widget _buildRatingBreakdown(Map<String, int> breakdown) {
    final total = breakdown.values.fold(0, (sum, count) => sum + count);
    
    return Column(
      children: [
        for (int rating = 5; rating >= 1; rating--)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Text(
                  '$rating',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.star, size: 12, color: Colors.amber),
                const SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: total > 0 ? (breakdown['$rating'] ?? 0) / total : 0.0,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                    minHeight: 4,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${breakdown['$rating'] ?? 0}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildReviewFilters() {
    final filters = [
      {'key': 'all', 'label': 'All', 'count': widget.reviews.length},
      {'key': 'positive', 'label': 'Positive', 'count': widget.reviews.where((r) => r.isPositive).length},
      {'key': 'job', 'label': 'Job Reviews', 'count': widget.reviews.where((r) => r.reviewType.contains('JOB')).length},
      {'key': 'service', 'label': 'Service Reviews', 'count': widget.reviews.where((r) => r.reviewType == 'SERVICE_CLIENT').length},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = _selectedFilter == filter['key'];
          final count = filter['count'] as int;
          
          if (count == 0 && filter['key'] != 'all') return const SizedBox.shrink();
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(
                '${filter['label']} ($count)',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.grey[700],
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter['key'] as String;
                  _showAllReviews = false;
                });
              },
              selectedColor: const Color(0xFF3E8728),
              backgroundColor: Colors.grey[100],
              checkmarkColor: Colors.white,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Review Header
          Row(
            children: [
              // Reviewer Info
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF3E8728).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  review.reviewerInfo?.role ?? 'Reviewer',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3E8728),
                  ),
                ),
              ),
              
              const Spacer(),
              
              // Rating
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return Icon(
                      index < review.overallRating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 14,
                    );
                  }),
                  const SizedBox(width: 4),
                  Text(
                    review.overallRating.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Review Content
          Text(
            review.comment,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Colors.black87,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Review Details
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              // Work Complexity
              if (review.workComplexity != null)
                _buildReviewDetail(
                  Icons.insights,
                  review.complexityDisplay,
                  Colors.blue,
                ),
              
              // Would Work Again
              if (review.wouldWorkAgain != null)
                _buildReviewDetail(
                  review.wouldWorkAgain! ? Icons.thumb_up : Icons.thumb_down,
                  review.wouldWorkAgain! ? 'Would hire again' : 'Would not hire again',
                  review.wouldWorkAgain! ? Colors.green : Colors.red,
                ),
              
              // Job/Service Context
              if (review.jobTitle != null)
                _buildReviewDetail(
                  Icons.work,
                  review.jobTitle!,
                  Colors.purple,
                ),
              
              if (review.serviceDescription != null)
                _buildReviewDetail(
                  Icons.handyman,
                  review.serviceDescription!,
                  Colors.orange,
                ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Review Footer
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 12,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 4),
              Text(
                review.timeAgo,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
              
              const Spacer(),
              
              // Review Type
              Text(
                review.reviewTypeDisplay,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          
          // Review Reply
          if (review.reply != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.reply,
                        size: 14,
                        color: Colors.blue[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Response',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[700],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        review.reply!.timeAgo,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    review.reply!.replyText,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue[800],
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReviewDetail(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 12,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildShowMoreButton(int remainingCount) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          setState(() {
            _showAllReviews = true;
          });
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: Colors.grey[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Show $remainingCount more review${remainingCount == 1 ? '' : 's'}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF3E8728),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Icon(
            Icons.rate_review_outlined,
            size: 32,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 12),
          Text(
            widget.isOwnProfile ? 'No Reviews Yet' : 'No Reviews Available',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.isOwnProfile
                ? 'Complete jobs and provide services to receive your first reviews'
                : 'This user hasn\'t received any reviews yet',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<Review> _getFilteredReviews() {
    switch (_selectedFilter) {
      case 'positive':
        return widget.reviews.where((r) => r.isPositive).toList();
      case 'job':
        return widget.reviews.where((r) => r.reviewType.contains('JOB')).toList();
      case 'service':
        return widget.reviews.where((r) => r.reviewType == 'SERVICE_CLIENT').toList();
      default:
        return widget.reviews;
    }
  }

  void _showAllReviewsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Text(
                      'All Reviews',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: widget.reviews.length,
                  itemBuilder: (context, index) => _buildReviewCard(widget.reviews[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// lib/features/profile/widgets/review_section.dart - SIMPLIFIED VERSION
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/review/review_model.dart';

class ProfileReviewsSection extends StatefulWidget {
  final List<ProfileReview> reviews;
  final bool isOwnProfile;

  const ProfileReviewsSection({
    super.key,
    required this.reviews,
    required this.isOwnProfile,
  });

  @override
  State<ProfileReviewsSection> createState() => _ProfileReviewsSectionState();
}

class _ProfileReviewsSectionState extends State<ProfileReviewsSection> {
  bool _showAllReviews = false;

  @override
  Widget build(BuildContext context) {
    final displayReviews = _showAllReviews 
        ? widget.reviews 
        : widget.reviews.take(3).toList();

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
                  if (widget.reviews.isNotEmpty) ...[
                    const SizedBox(width: 6),
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
                            _calculateAverageRating().toStringAsFixed(1),
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
              if (widget.reviews.length > 3)
                InkWell(
                  onTap: () => _showAllReviewsDialog(context),
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      'View All (${widget.reviews.length})',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF3E8728),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Reviews Content
          if (widget.reviews.isNotEmpty) ...[
            // Quick Stats
            _buildQuickStats(),
            
            const SizedBox(height: 12),
            
            // Review List
            ...displayReviews.map((review) => _buildReviewCard(review)),
            
            // Show More Button
            if (widget.reviews.length > 3 && !_showAllReviews)
              _buildShowMoreButton(),
          ] else
            _buildEmptyState(),
        ],
      ),
    );
  }

  // Calculate average rating from available reviews
  double _calculateAverageRating() {
    if (widget.reviews.isEmpty) return 0.0;
    final total = widget.reviews.fold(0, (sum, review) => sum + review.overallRating);
    return total / widget.reviews.length;
  }

  Widget _buildQuickStats() {
    final averageRating = _calculateAverageRating();
    final totalReviews = widget.reviews.length;
    final positiveReviews = widget.reviews.where((r) => r.overallRating >= 4).length;
    final positivePercentage = totalReviews > 0 ? (positiveReviews / totalReviews * 100) : 0.0;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber[200]!),
      ),
      child: Row(
        children: [
          // Average Rating
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < averageRating.floor()
                              ? Icons.star
                              : index < averageRating
                                  ? Icons.star_half
                                  : Icons.star_border,
                          color: Colors.amber,
                          size: 14,
                        );
                      }),
                    ),
                  ],
                ),
                Text(
                  '$totalReviews review${totalReviews == 1 ? '' : 's'}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // Positive Percentage
          if (positivePercentage > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  Text(
                    '${positivePercentage.round()}%',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    'Positive',
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(ProfileReview review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Review Header
          Row(
            children: [
              // Reviewer Avatar
              CircleAvatar(
                radius: 12,
                backgroundColor: const Color(0xFF3E8728).withOpacity(0.1),
                child: Text(
                  review.reviewerName.split(' ').map((n) => n[0]).take(2).join(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E8728),
                  ),
                ),
              ),
              
              const SizedBox(width: 8),
              
              // Reviewer Name
              Expanded(
                child: Text(
                  review.reviewerName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              
              // Rating Stars
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return Icon(
                      index < review.overallRating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 12,
                    );
                  }),
                  const SizedBox(width: 4),
                  Text(
                    review.overallRating.toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Review Comment
          Text(
            review.comment,
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Colors.black87,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 8),
          
          // Review Footer
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 11,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 4),
              Text(
                review.timeAgo,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[600],
                ),
              ),
              
              const Spacer(),
              
              // Job Context (if available)
              if (review.job != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.work_outline,
                        size: 8,
                        color: Colors.blue[700],
                      ),
                      const SizedBox(width: 2),
                      Text(
                        'Job Review',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShowMoreButton() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: double.infinity,
      child: InkWell(
        onTap: () {
          setState(() {
            _showAllReviews = true;
          });
        },
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF3E8728).withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFF3E8728).withOpacity(0.3)),
          ),
          child: Text(
            'Show ${widget.reviews.length - 3} more review${widget.reviews.length - 3 == 1 ? '' : 's'}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3E8728),
            ),
            textAlign: TextAlign.center,
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
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.isOwnProfile
                ? 'Complete jobs to receive your first reviews'
                : 'This user hasn\'t received any reviews yet',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showAllReviewsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'All Reviews (${widget.reviews.length})',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, size: 20),
                    ),
                  ],
                ),
              ),
              
              // Reviews List
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: widget.reviews.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _buildReviewCard(widget.reviews[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
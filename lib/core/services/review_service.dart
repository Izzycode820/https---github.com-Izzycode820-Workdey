// lib/core/services/review/review_service.dart - DEDICATED REVIEW SERVICE
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:workdey_frontend/core/models/profile/review/review_model.dart';

class ReviewService {
  final Dio _dio;

  ReviewService(this._dio);

  // ========== REVIEWS RECEIVED (For Reviews Tab) ==========
  
  /// Get reviews received by current user - Returns ReviewsResponse with summary + detailed reviews
  Future<ReviewsResponse> getReviewsReceived({
    String? reviewType,
    int? minRating,
    int? maxRating,
    String? ordering,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      
      if (reviewType != null) queryParams['review_type'] = reviewType;
      if (minRating != null) queryParams['min_rating'] = minRating;
      if (maxRating != null) queryParams['max_rating'] = maxRating;
      if (ordering != null) queryParams['ordering'] = ordering;

      final response = await _dio.get('/api/profiles/reviews/my_reviews_received/', 
        queryParameters: queryParams);
      
      // Parse the response according to the actual backend format
      final responseData = response.data as Map<String, dynamic>;
      debugPrint('✅ Reviews received API response keys: ${responseData.keys}');
      
      return ReviewsResponse.fromJson(responseData);
      
    } on DioException catch (e) {
      debugPrint('❌ Reviews Received Error: ${e.response?.data}');
      
      // Return empty response on error
      return ReviewsResponse(
        summary: ReviewSummary(
          totalReviews: 0,
          averageRating: 0.0,
        ),
        reviews: [],
      );
    }
  }

  /// Get reviews given by current user - Returns ReviewsResponse
  Future<ReviewsResponse> getReviewsGiven() async {
  try {
    final response = await _dio.get('/api/profiles/reviews/my_reviews_given/');
    
    final responseData = response.data as Map<String, dynamic>;
    debugPrint('✅ Reviews given API response keys: ${responseData.keys}');
    
    // ✅ FIXED: Handle the different response structure for reviews given
    if (responseData.containsKey('count') && responseData.containsKey('reviews')) {
      // Reviews given format: { "count": 1, "reviews": [...] }
      final reviewsList = responseData['reviews'] as List;
      final reviews = reviewsList.map((json) => DetailedReview.fromJson(json as Map<String, dynamic>)).toList();
      
      // Create summary from reviews (since given reviews don't have summary)
      final summary = _createSummaryFromReviews(reviews);
      
      return ReviewsResponse(
        summary: summary,
        reviews: reviews,
      );
    } else if (responseData.containsKey('summary') && responseData.containsKey('reviews')) {
      // Same format as received reviews
      return ReviewsResponse.fromJson(responseData);
    } else {
      // Fallback: treat entire response as reviews list
      final reviewsList = responseData as List? ?? [];
      final reviews = reviewsList.map((json) => DetailedReview.fromJson(json as Map<String, dynamic>)).toList();
      
      final summary = _createSummaryFromReviews(reviews);
      
      return ReviewsResponse(
        summary: summary,
        reviews: reviews,
      );
    }
    
  } on DioException catch (e) {
    debugPrint('❌ Reviews Given Error: ${e.response?.data}');
    
    return ReviewsResponse(
      summary: ReviewSummary(
        totalReviews: 0,
        averageRating: 0.0,
      ),
      reviews: [],
    );
  }
}

  /// Get reviews for a specific user (public profile context)
  Future<ReviewsResponse> getReviewsForUser(int userId) async {
    try {
      final response = await _dio.get('/api/profiles/reviews/for-user/', 
        queryParameters: {'user_id': userId});
      
      final responseData = response.data as Map<String, dynamic>;
      return ReviewsResponse.fromJson(responseData);
      
    } on DioException catch (e) {
      debugPrint('❌ Reviews For User Error: ${e.response?.data}');
      
      return ReviewsResponse(
        summary: ReviewSummary(
          totalReviews: 0,
          averageRating: 0.0,
        ),
        reviews: [],
      );
    }
  }

  // ========== REVIEW CREATION ==========
  
  /// Create a job review
  Future<DetailedReview> createJobReview(Map<String, dynamic> reviewData) async {
    try {
      final response = await _dio.post('/api/profiles/reviews/create_job_review/', data: reviewData);
      return DetailedReview.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Create Job Review Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Create a service review
  Future<DetailedReview> createServiceReview(Map<String, dynamic> reviewData) async {
    try {
      final response = await _dio.post('/api/profiles/reviews/create_service_review/', data: reviewData);
      return DetailedReview.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Create Service Review Error: ${e.response?.data}');
      rethrow;
    }
  }

  // ========== REVIEW INTERACTIONS ==========
  
  /// Reply to a review
  Future<void> replyToReview(int reviewId, String replyText) async {
    try {
      await _dio.post('/api/profiles/reviews/$reviewId/reply/', data: {
        'reply_text': replyText,
      });
      debugPrint('✅ Review reply posted successfully');
    } on DioException catch (e) {
      debugPrint('❌ Reply to Review Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Flag a review for moderation
  Future<void> flagReview(int reviewId) async {
    try {
      await _dio.post('/api/profiles/reviews/$reviewId/flag/');
      debugPrint('✅ Review flagged successfully');
    } on DioException catch (e) {
      debugPrint('❌ Flag Review Error: ${e.response?.data}');
      rethrow;
    }
  }

  // ========== REVIEW STATISTICS ==========
  
  /// Get review statistics for current user
  Future<Map<String, dynamic>> getMyReviewStats() async {
    try {
      final receivedResponse = await getReviewsReceived();
      final givenResponse = await getReviewsGiven();
      
      return {
        'received': {
          'total': receivedResponse.summary.totalReviews,
          'average_rating': receivedResponse.summary.averageRating,
          'positive_percentage': receivedResponse.summary.positivePercentageComputed,
          'quality_level': receivedResponse.summary.qualityLevel,
        },
        'given': {
          'total': givenResponse.summary.totalReviews,
          'average_rating': givenResponse.summary.averageRating,
        },
        'combined': {
          'total_activity': receivedResponse.summary.totalReviews + givenResponse.summary.totalReviews,
          'reputation_score': _calculateReputationScore(receivedResponse.summary),
        }
      };
    } catch (e) {
      debugPrint('❌ Review Stats Error: $e');
      return {
        'received': {'total': 0, 'average_rating': 0.0},
        'given': {'total': 0, 'average_rating': 0.0},
        'combined': {'total_activity': 0, 'reputation_score': 0.0},
      };
    }
  }

  /// Get review counts by type for current user
  Future<Map<String, int>> getReviewCountsByType() async {
    try {
      final receivedResponse = await getReviewsReceived();
      final counts = <String, int>{};
      
      for (final review in receivedResponse.reviews) {
        final reviewType = review.reviewType;
        counts[reviewType] = (counts[reviewType] ?? 0) + 1;
      }
      
      return counts;
    } catch (e) {
      debugPrint('❌ Review Counts Error: $e');
      return {};
    }
  }

  // ========== REVIEW FILTERING & SEARCH ==========
  
  /// Get filtered reviews with advanced options
  Future<ReviewsResponse> getFilteredReviews({
    String? reviewType,
    int? minRating,
    int? maxRating,
    String? sortBy,
    bool includeReplies = true,
    bool includeFlagged = false,
    String? searchText,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      
      if (reviewType != null) queryParams['review_type'] = reviewType;
      if (minRating != null) queryParams['min_rating'] = minRating;
      if (maxRating != null) queryParams['max_rating'] = maxRating;
      if (sortBy != null) queryParams['ordering'] = sortBy;
      if (!includeReplies) queryParams['exclude_replies'] = true;
      if (includeFlagged) queryParams['include_flagged'] = true;
      if (searchText != null && searchText.isNotEmpty) queryParams['search'] = searchText;

      final response = await _dio.get('/api/profiles/reviews/my_reviews_received/', 
        queryParameters: queryParams);
      
      final responseData = response.data as Map<String, dynamic>;
      return ReviewsResponse.fromJson(responseData);
      
    } on DioException catch (e) {
      debugPrint('❌ Filtered Reviews Error: ${e.response?.data}');
      rethrow;
    }
  }

  // ========== REVIEW MANAGEMENT ==========
  
  /// Get reviews that can be replied to (no existing reply)
  Future<List<DetailedReview>> getRepliableReviews() async {
    try {
      final reviewsResponse = await getReviewsReceived();
      
      return reviewsResponse.reviews
          .where((review) => review.reply == null)
          .toList();
          
    } catch (e) {
      debugPrint('❌ Repliable Reviews Error: $e');
      return [];
    }
  }

  /// Get recent reviews (last 30 days)
  Future<List<DetailedReview>> getRecentReviews({int days = 30}) async {
    try {
      final reviewsResponse = await getReviewsReceived();
      final cutoffDate = DateTime.now().subtract(Duration(days: days));
      
      return reviewsResponse.reviews
          .where((review) => review.createdAt.isAfter(cutoffDate))
          .toList();
          
    } catch (e) {
      debugPrint('❌ Recent Reviews Error: $e');
      return [];
    }
  }

  /// Get reviews by rating range
  Future<List<DetailedReview>> getReviewsByRating(int minRating, int maxRating) async {
    try {
      final reviewsResponse = await getReviewsReceived(
        minRating: minRating,
        maxRating: maxRating,
      );
      
      return reviewsResponse.reviews;
          
    } catch (e) {
      debugPrint('❌ Reviews By Rating Error: $e');
      return [];
    }
  }

  // ========== HELPER METHODS ==========
  
  /// Create a ReviewSummary from a list of detailed reviews
  ReviewSummary _createSummaryFromReviews(List<DetailedReview> reviews) {
    if (reviews.isEmpty) {
      return ReviewSummary(
        totalReviews: 0,
        averageRating: 0.0,
      );
    }
    
    final totalReviews = reviews.length;
    final averageRating = reviews.fold(0.0, (sum, review) => sum + review.overallRating) / totalReviews;
    
    // Count ratings by star level
    final ratingCounts = <int, int>{};
    for (int i = 1; i <= 5; i++) {
      ratingCounts[i] = reviews.where((r) => r.overallRating == i).length;
    }
    
    // Count would work again
    final wouldWorkAgainCount = reviews.where((r) => r.wouldWorkAgain == true).length;
    final wouldWorkAgainPercentage = (wouldWorkAgainCount / totalReviews) * 100;
    
    return ReviewSummary(
      totalReviews: totalReviews,
      averageRating: averageRating,
      fiveStarCount: ratingCounts[5],
      fourStarCount: ratingCounts[4],
      threeStarCount: ratingCounts[3],
      twoStarCount: ratingCounts[2],
      oneStarCount: ratingCounts[1],
      wouldWorkAgainPercentage: wouldWorkAgainPercentage,
    );
  }

  /// Calculate reputation score based on review summary
  double _calculateReputationScore(ReviewSummary summary) {
    if (summary.totalReviews == 0) return 0.0;
    
    // Simple reputation score: average rating * log(review count + 1) * positive percentage
    final baseScore = summary.averageRating;
    final volumeMultiplier = (summary.totalReviews + 1).toDouble();
    final positiveMultiplier = summary.positivePercentageComputed / 100;
    
    return (baseScore * volumeMultiplier * positiveMultiplier).clamp(0.0, 100.0);
  }

  // ========== ERROR HANDLING ==========
  
  /// Handle common review errors
  String getErrorMessage(DioException error) {
    if (error.response == null) {
      return 'Network error. Please check your connection.';
    }
    
    switch (error.response!.statusCode) {
      case 400:
        return 'Invalid review data. Please check your inputs.';
      case 401:
        return 'Please log in to access reviews.';
      case 403:
        return 'You don\'t have permission to perform this action.';
      case 404:
        return 'Review not found.';
      case 409:
        return 'You have already reviewed this job/service.';
      case 422:
        final data = error.response!.data;
        if (data is Map && data.containsKey('detail')) {
          return data['detail'].toString();
        }
        return 'Review validation error. Please check your inputs.';
      case 429:
        return 'Too many requests. Please wait before trying again.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  // ========== CACHE MANAGEMENT ==========
  
  /// Clear review cache (force refresh on next load)
  void clearCache() {
    // Implementation would depend on your caching strategy
    debugPrint('🗑️ Review cache cleared');
  }

  // ========== BATCH OPERATIONS ==========
  
  /// Mark multiple reviews as read (if such functionality exists)
  Future<void> markReviewsAsRead(List<int> reviewIds) async {
    try {
      await _dio.post('/api/profiles/reviews/mark-read/', data: {
        'review_ids': reviewIds,
      });
      debugPrint('✅ Reviews marked as read');
    } on DioException catch (e) {
      debugPrint('❌ Mark Reviews Read Error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Get review analytics for charts/graphs
  Future<Map<String, dynamic>> getReviewAnalytics() async {
    try {
      final receivedResponse = await getReviewsReceived();
      final summary = receivedResponse.summary;
      
      // Calculate rating distribution
      final ratingDistribution = <String, double>{};
      for (int i = 1; i <= 5; i++) {
        ratingDistribution['${i}_star'] = summary.getRatingPercentage(i);
      }
      
      // Calculate monthly trends (if we had date data)
      final monthlyTrends = <String, int>{};
      for (final review in receivedResponse.reviews) {
        final monthKey = '${review.createdAt.year}-${review.createdAt.month.toString().padLeft(2, '0')}';
        monthlyTrends[monthKey] = (monthlyTrends[monthKey] ?? 0) + 1;
      }
      
      return {
        'rating_distribution': ratingDistribution,
        'monthly_trends': monthlyTrends,
        'total_reviews': summary.totalReviews,
        'average_rating': summary.averageRating,
        'positive_percentage': summary.positivePercentageComputed,
      };
      
    } catch (e) {
      debugPrint('❌ Review Analytics Error: $e');
      return {};
    }
  }
}
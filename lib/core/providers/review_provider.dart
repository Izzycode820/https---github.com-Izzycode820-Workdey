// lib/core/providers/review_provider.dart - CORRECTED VERSION
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/profile/review/review_model.dart';
import 'package:workdey_frontend/core/providers/post_completion_review_provider.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/profiles/profile_service.dart';
import 'package:workdey_frontend/core/services/review_service.dart';

// ========== REVIEW SERVICE PROVIDER ==========
final reviewServiceProvider = Provider<ReviewService>((ref) {
  return ReviewService(ref.read(dioProvider));
});

// ========== REVIEWS RECEIVED PROVIDER ==========
final reviewsReceivedProvider = StateNotifierProvider<ReviewsReceivedNotifier, AsyncValue<ReviewsResponse>>((ref) {
  return ReviewsReceivedNotifier(ref.read(reviewServiceProvider));
});

class ReviewsReceivedNotifier extends StateNotifier<AsyncValue<ReviewsResponse>> {
  final ReviewService _reviewService;
  String? _currentFilter;

  ReviewsReceivedNotifier(this._reviewService) : super(const AsyncValue.loading()) {
    loadReviews();
  }

  Future<void> loadReviews({bool forceRefresh = false, String? filter}) async {
    try {
      if (forceRefresh || filter != _currentFilter) {
        _currentFilter = filter;
      }
      
      state = const AsyncValue.loading();
      
      // ✅ Call the correct service method that returns ReviewsResponse
      final reviewsResponse = await _reviewService.getReviewsReceived(
        reviewType: filter,
      );
      
      state = AsyncValue.data(reviewsResponse);
      debugPrint('✅ Reviews received loaded: ${reviewsResponse.reviews.length} items');
      
    } catch (e, st) {
      debugPrint('❌ Reviews loading error: $e');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => loadReviews(forceRefresh: true);
  
  Future<void> filterBy(String? reviewType) => loadReviews(filter: reviewType);
  
  // Force refresh method for activity center
  Future<void> forceRefresh() async {
    try {
      final reviewsResponse = await _reviewService.getReviewsReceived(
        reviewType: _currentFilter,
      );
      state = AsyncValue.data(reviewsResponse);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// ========== REVIEWS GIVEN PROVIDER ==========
final reviewsGivenProvider = StateNotifierProvider<ReviewsGivenNotifier, AsyncValue<ReviewsResponse>>((ref) {
  return ReviewsGivenNotifier(ref.read(reviewServiceProvider));
});

class ReviewsGivenNotifier extends StateNotifier<AsyncValue<ReviewsResponse>> {
  final ReviewService _reviewService;

  ReviewsGivenNotifier(this._reviewService) : super(const AsyncValue.loading()) {
    loadReviews();
  }

  Future<void> loadReviews({bool forceRefresh = false}) async {
    try {      
      state = const AsyncValue.loading();
      
      final reviewsResponse = await _reviewService.getReviewsGiven();
      
      state = AsyncValue.data(reviewsResponse);
      debugPrint('✅ Reviews given loaded: ${reviewsResponse.reviews.length} items');
      
    } catch (e, st) {
      debugPrint('❌ Reviews given loading error: $e');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => loadReviews(forceRefresh: true);

// Force refresh method for activity center
  Future<void> forceRefresh() async {
    try {
      final reviewsResponse = await _reviewService.getReviewsGiven();
      state = AsyncValue.data(reviewsResponse);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// ========== REVIEW CREATION PROVIDER ==========
final reviewProvider = StateNotifierProvider<ReviewNotifier, AsyncValue<void>>((ref) {
  return ReviewNotifier(ref.read(reviewServiceProvider));
});

class ReviewNotifier extends StateNotifier<AsyncValue<void>> {
  final ReviewService _reviewService;

  ReviewNotifier(this._reviewService) : super(const AsyncValue.data(null));

  Future<void> createJobReview(Map<String, dynamic> reviewData) async {
    try {
      state = const AsyncValue.loading();
      await _reviewService.createJobReview(reviewData);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      debugPrint('❌ Create job review error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> createServiceReview(Map<String, dynamic> reviewData) async {
    try {
      state = const AsyncValue.loading();
      await _reviewService.createServiceReview(reviewData);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      debugPrint('❌ Create service review error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> flagReview(int reviewId) async {
    try {
      state = const AsyncValue.loading();
      await _reviewService.flagReview(reviewId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      debugPrint('❌ Flag review error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> replyToReview(int reviewId, String replyText) async {
    try {
      state = const AsyncValue.loading();
      await _reviewService.replyToReview(reviewId, replyText);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      debugPrint('❌ Reply to review error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

// ========== REVIEW FILTERING PROVIDER ==========
final reviewFilterProvider = StateProvider<ReviewFilter>((ref) {
  return ReviewFilter();
});

class ReviewFilter {
  final String? reviewType;
  final int? minRating;
  final int? maxRating;
  final String? sortBy;
  final bool showFlagged;

  ReviewFilter({
    this.reviewType,
    this.minRating,
    this.maxRating,
    this.sortBy = 'created_at',
    this.showFlagged = false,
  });

  ReviewFilter copyWith({
    String? reviewType,
    int? minRating,
    int? maxRating,
    String? sortBy,
    bool? showFlagged,
  }) {
    return ReviewFilter(
      reviewType: reviewType,
      minRating: minRating ?? this.minRating,
      maxRating: maxRating ?? this.maxRating,
      sortBy: sortBy ?? this.sortBy,
      showFlagged: showFlagged ?? this.showFlagged,
    );
  }

  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{};
    if (reviewType != null) params['review_type'] = reviewType;
    if (minRating != null) params['min_rating'] = minRating;
    if (maxRating != null) params['max_rating'] = maxRating;
    if (sortBy != null) params['ordering'] = sortBy;
    if (showFlagged) params['include_flagged'] = true;
    return params;
  }
}

// ========== CONVENIENCE PROVIDERS ==========

/// Get reviews that can be replied to (for current user)
final repliableReviewsProvider = Provider<AsyncValue<List<DetailedReview>>>((ref) {
  final reviewsReceived = ref.watch(reviewsReceivedProvider);
  
  return reviewsReceived.when(
    data: (reviewsResponse) {
      final repliable = reviewsResponse.reviews
          .where((review) => review.reply == null)
          .toList();
      return AsyncValue.data(repliable);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Get review counts by type
final reviewCountsProvider = Provider<Map<String, int>>((ref) {
  final reviewsReceived = ref.watch(reviewsReceivedProvider);
  
  return reviewsReceived.when(
    data: (reviewsResponse) {
      final counts = <String, int>{};
      for (final review in reviewsResponse.reviews) {
        final reviewType = review.reviewType;
        counts[reviewType] = (counts[reviewType] ?? 0) + 1;
      }
      return counts;
    },
    loading: () => <String, int>{},
    error: (error, stack) => <String, int>{},
  );
});

/// Get review summary provider
final reviewSummaryProvider = Provider<ReviewSummary?>((ref) {
  final reviewsReceived = ref.watch(reviewsReceivedProvider);
  
  return reviewsReceived.when(
    data: (reviewsResponse) => reviewsResponse.summary,
    loading: () => null,
    error: (error, stack) => null,
  );
});

/// Get total reviews count
final totalReviewsCountProvider = Provider<int>((ref) {
  final reviewsReceived = ref.watch(reviewsReceivedProvider);
  
  return reviewsReceived.when(
    data: (reviewsResponse) => reviewsResponse.summary.totalReviews,
    loading: () => 0,
    error: (error, stack) => 0,
  );
});

/// Get average rating
final averageRatingProvider = Provider<double>((ref) {
  final reviewsReceived = ref.watch(reviewsReceivedProvider);
  
  return reviewsReceived.when(
    data: (reviewsResponse) => reviewsResponse.summary.averageRating,
    loading: () => 0.0,
    error: (error, stack) => 0.0,
  );
});

// ========== REVIEW STATS PROVIDER ==========
final reviewStatsProvider = Provider<Map<String, dynamic>>((ref) {
  final reviewsReceived = ref.watch(reviewsReceivedProvider);
  final reviewsGiven = ref.watch(reviewsGivenProvider);
  
  return {
    'received': reviewsReceived.maybeWhen(
      data: (response) => {
        'count': response.summary.totalReviews,
        'average': response.summary.averageRating,
        'positive_percentage': response.summary.positivePercentageComputed,
      },
      orElse: () => {
        'count': 0,
        'average': 0.0,
        'positive_percentage': 0.0,
      },
    ),
    'given': reviewsGiven.maybeWhen(
      data: (response) => {
        'count': response.summary.totalReviews,
        'average': response.summary.averageRating,
      },
      orElse: () => {
        'count': 0,
        'average': 0.0,
      },
    ),
  };
});

// ========== ACTIVITY CENTER INTEGRATION ==========
/// Provider for activity center - returns simple count
final reviewActivityCountProvider = Provider<int>((ref) {
  final pendingReviews = ref.watch(postCompletionReviewProvider);
  
  return pendingReviews.maybeWhen(
    data: (reviews) => reviews.length,
    orElse: () => 0,
  );
});

/// Provider for activity center - returns pending reviews data
final reviewActivityDataProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final pendingReviews = ref.watch(postCompletionReviewProvider);
  
  return pendingReviews.maybeWhen(
    data: (reviews) => reviews,
    orElse: () => [],
  );
});
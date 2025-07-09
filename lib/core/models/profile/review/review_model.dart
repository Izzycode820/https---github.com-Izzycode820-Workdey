// lib/core/models/profile/review/review_model.dart - FIXED: Separate models for different contexts
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

// ========== PROFILE CONTEXT MODELS ==========
// Simple reviewer model for profile context
@freezed
class ProfileReviewer with _$ProfileReviewer {
  const factory ProfileReviewer({
    required int id,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String email,
  }) = _ProfileReviewer;

  factory ProfileReviewer.fromJson(Map<String, dynamic> json) => 
      _$ProfileReviewerFromJson(json);
}

// Simple review model for profile context
@freezed
class ProfileReview with _$ProfileReview {
  const ProfileReview._();

  const factory ProfileReview({
    required int id,
    required ProfileReviewer reviewer,
    @JsonKey(name: 'overall_rating') required int overallRating,
    required String comment,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    int? job, // Can be null or job ID
  }) = _ProfileReview;

  factory ProfileReview.fromJson(Map<String, dynamic> json) => 
      _$ProfileReviewFromJson(json);

  // Helper methods
  String get reviewerName => '${reviewer.firstName} ${reviewer.lastName}';
  String get ratingStars => '⭐' * overallRating;
  
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    }
  }
}

// ========== DETAILED REVIEW CONTEXT MODELS ==========
// Reviewer info for detailed/anonymous context
@freezed
class ReviewerInfo with _$ReviewerInfo {
  const factory ReviewerInfo({
    required String role,
    @JsonKey(name: 'verified_level') int? verifiedLevel,
    @JsonKey(name: 'trust_level') String? trustLevel,
  }) = _ReviewerInfo;

  factory ReviewerInfo.fromJson(Map<String, dynamic> json) => 
      _$ReviewerInfoFromJson(json);
}

// Review reply model
@freezed
class ReviewReply with _$ReviewReply {
  const ReviewReply._();

  const factory ReviewReply({
    @JsonKey(name: 'reply_text') required String replyText,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _ReviewReply;

  factory ReviewReply.fromJson(Map<String, dynamic> json) => 
      _$ReviewReplyFromJson(json);

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    }
  }
}

// Detailed review model for reviews tab/detail context
@freezed
class DetailedReview with _$DetailedReview {
  const DetailedReview._();

  const factory DetailedReview({
    required int id,
    @JsonKey(name: 'review_type') required String reviewType,
    @JsonKey(name: 'overall_rating') required int overallRating,
    required String comment,
    @JsonKey(name: 'category_ratings') Map<String, dynamic>? categoryRatings,
    @JsonKey(name: 'work_complexity') String? workComplexity,
    @JsonKey(name: 'complexity_display') String? complexityDisplay,
    @JsonKey(name: 'would_work_again') bool? wouldWorkAgain,
    @JsonKey(name: 'reviewer_info') required ReviewerInfo reviewerInfo,
    ReviewReply? reply,
    @JsonKey(name: 'time_ago') required String timeAgo,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _DetailedReview;

  factory DetailedReview.fromJson(Map<String, dynamic> json) => 
      _$DetailedReviewFromJson(json);

  // Helper methods
  String get reviewTypeDisplay {
    switch (reviewType) {
      case 'JOB_EMP_WORKER':
        return 'Job Review (Employer → Worker)';
      case 'JOB_WORKER_EMP':
        return 'Job Review (Worker → Employer)';
      case 'SERVICE_CLIENT':
        return 'Service Review';
      case 'COMMUNITY':
        return 'Community Review';
      default:
        return 'Review';
    }
  }

  String get complexityDisplayText {
    if (complexityDisplay != null && complexityDisplay!.isNotEmpty) {
      return complexityDisplay!;
    }
    
    switch (workComplexity) {
      case 'SIMPLE':
        return 'Simple Task';
      case 'MODERATE':
        return 'Moderate Complexity';
      case 'COMPLEX':
        return 'Complex Project';
      default:
        return 'Not Specified';
    }
  }

  String get ratingStars => '⭐' * overallRating;
  bool get isPositive => overallRating >= 4;
  bool get isNegative => overallRating <= 2;
  bool get isNeutral => overallRating == 3;
  bool get hasReply => reply != null;

  // Get category ratings as integers
  Map<String, int> get categoryRatingsInt {
    if (categoryRatings == null) return {};
    
    return categoryRatings!.map((key, value) {
      if (value is num) {
        return MapEntry(key, value.toInt());
      } else if (value is String) {
        return MapEntry(key, int.tryParse(value) ?? 0);
      }
      return MapEntry(key, 0);
    });
  }

  String getCategoryDisplayName(String category) {
    switch (category) {
      case 'communication':
        return 'Communication';
      case 'work_quality':
        return 'Work Quality';
      case 'punctuality':
        return 'Punctuality';
      case 'professionalism':
        return 'Professionalism';
      case 'reliability':
        return 'Reliability';
      case 'technical_skills':
        return 'Technical Skills';
      default:
        return category.split('_').map((word) => 
          word[0].toUpperCase() + word.substring(1)
        ).join(' ');
    }
  }
}

// ========== SUMMARY MODELS ==========
@freezed
class ReviewSummary with _$ReviewSummary {
  const ReviewSummary._();

  const factory ReviewSummary({
    @JsonKey(name: 'total_reviews', defaultValue: 0) required int totalReviews,
    @JsonKey(name: 'average_rating', defaultValue: 0.0) required double averageRating,
    @JsonKey(name: 'five_star_count') int? fiveStarCount,
    @JsonKey(name: 'four_star_count') int? fourStarCount,
    @JsonKey(name: 'three_star_count') int? threeStarCount,
    @JsonKey(name: 'two_star_count') int? twoStarCount,
    @JsonKey(name: 'one_star_count') int? oneStarCount,
    @JsonKey(name: 'positive_percentage') double? positivePercentage,
    @JsonKey(name: 'would_work_again_percentage') double? wouldWorkAgainPercentage,
  }) = _ReviewSummary;

  factory ReviewSummary.fromJson(Map<String, dynamic> json) => 
      _$ReviewSummaryFromJson(json);

  // Helper methods
  bool get hasReviews => totalReviews > 0;
  String get ratingDisplay => averageRating.toStringAsFixed(1);
  
  String get qualityLevel {
    if (averageRating >= 4.5) return 'Excellent';
    if (averageRating >= 4.0) return 'Very Good';
    if (averageRating >= 3.5) return 'Good';
    if (averageRating >= 3.0) return 'Average';
    return 'Needs Improvement';
  }

  // Get rating count with fallback
  int getRatingCount(int stars) {
    switch (stars) {
      case 5: return fiveStarCount ?? 0;
      case 4: return fourStarCount ?? 0;
      case 3: return threeStarCount ?? 0;
      case 2: return twoStarCount ?? 0;
      case 1: return oneStarCount ?? 0;
      default: return 0;
    }
  }

  // Get rating percentage
  double getRatingPercentage(int stars) {
    if (totalReviews == 0) return 0.0;
    return (getRatingCount(stars) / totalReviews) * 100;
  }

  double get positivePercentageComputed {
    if (positivePercentage != null) return positivePercentage!;
    if (totalReviews == 0) return 0.0;
    final positiveCount = getRatingCount(4) + getRatingCount(5);
    return (positiveCount / totalReviews) * 100;
  }
}

// ========== RESPONSE WRAPPER MODELS ==========
// For detailed reviews response (reviews tab)
@freezed
class ReviewsResponse with _$ReviewsResponse {
  const factory ReviewsResponse({
    required ReviewSummary summary,
    required List<DetailedReview> reviews,
  }) = _ReviewsResponse;

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) => 
      _$ReviewsResponseFromJson(json);
}

// For profile reviews (simple list)
@freezed
class ProfileReviewsResponse with _$ProfileReviewsResponse {
  const factory ProfileReviewsResponse({
    required List<ProfileReview> reviews,
  }) = _ProfileReviewsResponse;

  factory ProfileReviewsResponse.fromJson(Map<String, dynamic> json) => 
      _$ProfileReviewsResponseFromJson(json);
}

// ========== UTILITY MODELS ==========
// Filter model for reviews
@freezed
class ReviewFilter with _$ReviewFilter {
  const factory ReviewFilter({
    String? reviewType,
    int? minRating,
    int? maxRating,
    @Default('created_at') String sortBy,
    @Default(false) bool showFlagged,
  }) = _ReviewFilter;

  factory ReviewFilter.fromJson(Map<String, dynamic> json) => 
      _$ReviewFilterFromJson(json);
}

// Extension for ReviewFilter methods
extension ReviewFilterX on ReviewFilter {
  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{};
    if (reviewType != null) params['review_type'] = reviewType;
    if (minRating != null) params['min_rating'] = minRating;
    if (maxRating != null) params['max_rating'] = maxRating;
    params['ordering'] = sortBy;
    if (showFlagged) params['include_flagged'] = true;
    return params;
  }
}

// ========== BACKWARD COMPATIBILITY ==========
// For existing code that expects the old Review model
typedef Review = DetailedReview;

// ========== HELPER FUNCTIONS ==========
class ReviewUtils {
  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  static String getRatingLabel(int rating) {
    switch (rating) {
      case 5: return 'Excellent';
      case 4: return 'Very Good';
      case 3: return 'Good';
      case 2: return 'Fair';
      case 1: return 'Poor';
      default: return 'Not Rated';
    }
  }
}
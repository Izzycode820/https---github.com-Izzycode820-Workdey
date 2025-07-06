// lib/core/models/profile/review/review_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
class Review with _$Review {
  const Review._();

  @JsonSerializable(explicitToJson: true)
  const factory Review({
    required int id,
    @JsonKey(name: 'review_type') required String reviewType,
    @JsonKey(name: 'overall_rating') required int overallRating,
    required String comment,
    @JsonKey(name: 'category_ratings') Map<String, int>? categoryRatings,
    @JsonKey(name: 'work_complexity') String? workComplexity,
    @JsonKey(name: 'would_work_again') bool? wouldWorkAgain,
    @JsonKey(name: 'is_flagged', defaultValue: false) required bool isFlagged,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    
    // Reviewer info (anonymous)
    @JsonKey(name: 'reviewer_info') ReviewerInfo? reviewerInfo,
    
    // Related job/service info
    @JsonKey(name: 'job_title') String? jobTitle,
    @JsonKey(name: 'service_description') String? serviceDescription,
    
    // Reply if any
    ReviewReply? reply,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => 
      _$ReviewFromJson(json);

  // Helper methods
  String get ratingStars => '⭐' * overallRating;
  
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    
    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    }
  }

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

  String get complexityDisplay {
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

  bool get isPositive => overallRating >= 4;
  bool get isNegative => overallRating <= 2;
}

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

@freezed
class ReviewReply with _$ReviewReply {
  const ReviewReply._();

  const factory ReviewReply({
    required int id,
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

@freezed
class ReviewSummary with _$ReviewSummary {
  const factory ReviewSummary({
    @JsonKey(name: 'total_reviews', defaultValue: 0) required int totalReviews,
    @JsonKey(name: 'average_rating', defaultValue: 0.0) required double averageRating,
    @JsonKey(name: 'rating_breakdown') Map<String, int>? ratingBreakdown,
    @JsonKey(name: 'would_work_again_percentage', defaultValue: 0.0) required double wouldWorkAgainPercentage,
    @JsonKey(name: 'recent_reviews') List<Review>? recentReviews,
  }) = _ReviewSummary;

  factory ReviewSummary.fromJson(Map<String, dynamic> json) => 
      _$ReviewSummaryFromJson(json);
}
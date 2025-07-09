// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileReviewerImpl _$$ProfileReviewerImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileReviewerImpl(
      id: (json['id'] as num).toInt(),
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$ProfileReviewerImplToJson(
        _$ProfileReviewerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
    };

_$ProfileReviewImpl _$$ProfileReviewImplFromJson(Map<String, dynamic> json) =>
    _$ProfileReviewImpl(
      id: (json['id'] as num).toInt(),
      reviewer:
          ProfileReviewer.fromJson(json['reviewer'] as Map<String, dynamic>),
      overallRating: (json['overall_rating'] as num).toInt(),
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      job: (json['job'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ProfileReviewImplToJson(_$ProfileReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reviewer': instance.reviewer,
      'overall_rating': instance.overallRating,
      'comment': instance.comment,
      'created_at': instance.createdAt.toIso8601String(),
      'job': instance.job,
    };

_$ReviewerInfoImpl _$$ReviewerInfoImplFromJson(Map<String, dynamic> json) =>
    _$ReviewerInfoImpl(
      role: json['role'] as String,
      verifiedLevel: (json['verified_level'] as num?)?.toInt(),
      trustLevel: json['trust_level'] as String?,
    );

Map<String, dynamic> _$$ReviewerInfoImplToJson(_$ReviewerInfoImpl instance) =>
    <String, dynamic>{
      'role': instance.role,
      'verified_level': instance.verifiedLevel,
      'trust_level': instance.trustLevel,
    };

_$ReviewReplyImpl _$$ReviewReplyImplFromJson(Map<String, dynamic> json) =>
    _$ReviewReplyImpl(
      replyText: json['reply_text'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ReviewReplyImplToJson(_$ReviewReplyImpl instance) =>
    <String, dynamic>{
      'reply_text': instance.replyText,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$DetailedReviewImpl _$$DetailedReviewImplFromJson(Map<String, dynamic> json) =>
    _$DetailedReviewImpl(
      id: (json['id'] as num).toInt(),
      reviewType: json['review_type'] as String,
      overallRating: (json['overall_rating'] as num).toInt(),
      comment: json['comment'] as String,
      categoryRatings: json['category_ratings'] as Map<String, dynamic>?,
      workComplexity: json['work_complexity'] as String?,
      complexityDisplay: json['complexity_display'] as String?,
      wouldWorkAgain: json['would_work_again'] as bool?,
      reviewerInfo:
          ReviewerInfo.fromJson(json['reviewer_info'] as Map<String, dynamic>),
      reply: json['reply'] == null
          ? null
          : ReviewReply.fromJson(json['reply'] as Map<String, dynamic>),
      timeAgo: json['time_ago'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$DetailedReviewImplToJson(
        _$DetailedReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'review_type': instance.reviewType,
      'overall_rating': instance.overallRating,
      'comment': instance.comment,
      'category_ratings': instance.categoryRatings,
      'work_complexity': instance.workComplexity,
      'complexity_display': instance.complexityDisplay,
      'would_work_again': instance.wouldWorkAgain,
      'reviewer_info': instance.reviewerInfo,
      'reply': instance.reply,
      'time_ago': instance.timeAgo,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$ReviewSummaryImpl _$$ReviewSummaryImplFromJson(Map<String, dynamic> json) =>
    _$ReviewSummaryImpl(
      totalReviews: (json['total_reviews'] as num?)?.toInt() ?? 0,
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
      fiveStarCount: (json['five_star_count'] as num?)?.toInt(),
      fourStarCount: (json['four_star_count'] as num?)?.toInt(),
      threeStarCount: (json['three_star_count'] as num?)?.toInt(),
      twoStarCount: (json['two_star_count'] as num?)?.toInt(),
      oneStarCount: (json['one_star_count'] as num?)?.toInt(),
      positivePercentage: (json['positive_percentage'] as num?)?.toDouble(),
      wouldWorkAgainPercentage:
          (json['would_work_again_percentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ReviewSummaryImplToJson(_$ReviewSummaryImpl instance) =>
    <String, dynamic>{
      'total_reviews': instance.totalReviews,
      'average_rating': instance.averageRating,
      'five_star_count': instance.fiveStarCount,
      'four_star_count': instance.fourStarCount,
      'three_star_count': instance.threeStarCount,
      'two_star_count': instance.twoStarCount,
      'one_star_count': instance.oneStarCount,
      'positive_percentage': instance.positivePercentage,
      'would_work_again_percentage': instance.wouldWorkAgainPercentage,
    };

_$ReviewsResponseImpl _$$ReviewsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ReviewsResponseImpl(
      summary: ReviewSummary.fromJson(json['summary'] as Map<String, dynamic>),
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => DetailedReview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ReviewsResponseImplToJson(
        _$ReviewsResponseImpl instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'reviews': instance.reviews,
    };

_$ProfileReviewsResponseImpl _$$ProfileReviewsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileReviewsResponseImpl(
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => ProfileReview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProfileReviewsResponseImplToJson(
        _$ProfileReviewsResponseImpl instance) =>
    <String, dynamic>{
      'reviews': instance.reviews,
    };

_$ReviewFilterImpl _$$ReviewFilterImplFromJson(Map<String, dynamic> json) =>
    _$ReviewFilterImpl(
      reviewType: json['reviewType'] as String?,
      minRating: (json['minRating'] as num?)?.toInt(),
      maxRating: (json['maxRating'] as num?)?.toInt(),
      sortBy: json['sortBy'] as String? ?? 'created_at',
      showFlagged: json['showFlagged'] as bool? ?? false,
    );

Map<String, dynamic> _$$ReviewFilterImplToJson(_$ReviewFilterImpl instance) =>
    <String, dynamic>{
      'reviewType': instance.reviewType,
      'minRating': instance.minRating,
      'maxRating': instance.maxRating,
      'sortBy': instance.sortBy,
      'showFlagged': instance.showFlagged,
    };

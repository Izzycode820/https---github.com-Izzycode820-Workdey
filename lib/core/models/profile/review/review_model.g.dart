// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
      id: (json['id'] as num).toInt(),
      reviewType: json['review_type'] as String,
      overallRating: (json['overall_rating'] as num).toInt(),
      comment: json['comment'] as String,
      categoryRatings: (json['category_ratings'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      workComplexity: json['work_complexity'] as String?,
      wouldWorkAgain: json['would_work_again'] as bool?,
      isFlagged: json['is_flagged'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      reviewerInfo: json['reviewer_info'] == null
          ? null
          : ReviewerInfo.fromJson(
              json['reviewer_info'] as Map<String, dynamic>),
      jobTitle: json['job_title'] as String?,
      serviceDescription: json['service_description'] as String?,
      reply: json['reply'] == null
          ? null
          : ReviewReply.fromJson(json['reply'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'review_type': instance.reviewType,
      'overall_rating': instance.overallRating,
      'comment': instance.comment,
      'category_ratings': instance.categoryRatings,
      'work_complexity': instance.workComplexity,
      'would_work_again': instance.wouldWorkAgain,
      'is_flagged': instance.isFlagged,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'reviewer_info': instance.reviewerInfo?.toJson(),
      'job_title': instance.jobTitle,
      'service_description': instance.serviceDescription,
      'reply': instance.reply?.toJson(),
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
      id: (json['id'] as num).toInt(),
      replyText: json['reply_text'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ReviewReplyImplToJson(_$ReviewReplyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reply_text': instance.replyText,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$ReviewSummaryImpl _$$ReviewSummaryImplFromJson(Map<String, dynamic> json) =>
    _$ReviewSummaryImpl(
      totalReviews: (json['total_reviews'] as num?)?.toInt() ?? 0,
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
      ratingBreakdown: (json['rating_breakdown'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      wouldWorkAgainPercentage:
          (json['would_work_again_percentage'] as num?)?.toDouble() ?? 0.0,
      recentReviews: (json['recent_reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ReviewSummaryImplToJson(_$ReviewSummaryImpl instance) =>
    <String, dynamic>{
      'total_reviews': instance.totalReviews,
      'average_rating': instance.averageRating,
      'rating_breakdown': instance.ratingBreakdown,
      'would_work_again_percentage': instance.wouldWorkAgainPercentage,
      'recent_reviews': instance.recentReviews,
    };

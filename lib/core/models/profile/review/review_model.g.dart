// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
      id: (json['id'] as num?)?.toInt(),
      reviewer: json['reviewer'] == null
          ? null
          : User.fromJson(json['reviewer'] as Map<String, dynamic>),
      worker: json['worker'] == null
          ? null
          : User.fromJson(json['worker'] as Map<String, dynamic>),
      rating: (json['rating'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      reviewerType: json['reviewer_type'] as String?,
      job: (json['job'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reviewer': instance.reviewer,
      'worker': instance.worker,
      'rating': instance.rating,
      'comment': instance.comment,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'reviewer_type': instance.reviewerType,
      'job': instance.job,
    };

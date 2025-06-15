// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_workers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkerImpl _$$WorkerImplFromJson(Map<String, dynamic> json) => _$WorkerImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      category: json['category'] as String,
      user: (json['user'] as num?)?.toInt(),
      location: json['location'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      bio: json['bio'] as String?,
      availability: json['availability'] as String?,
      experienceYears: (json['experience_years'] as num?)?.toInt(),
      portfolioLink: json['portfolio_link'] as String?,
      postTime: json['post_time'] as String?,
      categoryDisplay: json['category_display'] as String?,
      verificationBadges: json['verification_badges'] as Map<String, dynamic>?,
      isSaved: json['is_saved'] as bool? ?? false,
      profilePicture: json['profile_picture'] as String?,
      userName: json['name'] as String?,
    );

Map<String, dynamic> _$$WorkerImplToJson(_$WorkerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'user': instance.user,
      'location': instance.location,
      'created_at': instance.createdAt.toIso8601String(),
      'skills': instance.skills,
      'bio': instance.bio,
      'availability': instance.availability,
      'experience_years': instance.experienceYears,
      'portfolio_link': instance.portfolioLink,
      'post_time': instance.postTime,
      'category_display': instance.categoryDisplay,
      'verification_badges': instance.verificationBadges,
      'is_saved': instance.isSaved,
      'profile_picture': instance.profilePicture,
      'name': instance.userName,
    };

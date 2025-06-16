// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_worker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostWorkerImpl _$$PostWorkerImplFromJson(Map<String, dynamic> json) =>
    _$PostWorkerImpl(
      title: json['title'] as String,
      category: json['category'] as String,
      location: json['location'] as String,
      skills:
          (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      bio: json['bio'] as String?,
      availability: json['availability'] as String?,
      experienceYears: (json['experience_years'] as num?)?.toInt(),
      portfolioLink: json['portfolio_link'] as String?,
    );

Map<String, dynamic> _$$PostWorkerImplToJson(_$PostWorkerImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'category': instance.category,
      'location': instance.location,
      'skills': instance.skills,
      'bio': instance.bio,
      'availability': instance.availability,
      'experience_years': instance.experienceYears,
      'portfolio_link': instance.portfolioLink,
    };

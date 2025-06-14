// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: (json['id'] as num?)?.toInt(),
      bio: json['bio'] as String,
      location: json['location'] as String?,
      transport: json['transport'] as String?,
      availability: (json['availability'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      willingToLearn: json['willing_to_learn'] as bool,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      jobsCompleted: (json['jobs_completed'] as num?)?.toInt() ?? 0,
      verificationBadges: json['verification_badges'] as Map<String, dynamic>,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      skills: (json['skills'] as List<dynamic>)
          .map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList(),
      experiences: (json['experiences'] as List<dynamic>)
          .map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList(),
      educations: (json['educations'] as List<dynamic>)
          .map((e) => Education.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bio': instance.bio,
      'location': instance.location,
      'transport': instance.transport,
      'availability': instance.availability,
      'willing_to_learn': instance.willingToLearn,
      'rating': instance.rating,
      'jobs_completed': instance.jobsCompleted,
      'verification_badges': instance.verificationBadges,
      'user': instance.user.toJson(),
      'skills': instance.skills.map((e) => e.toJson()).toList(),
      'experiences': instance.experiences.map((e) => e.toJson()).toList(),
      'educations': instance.educations.map((e) => e.toJson()).toList(),
      'reviews': instance.reviews.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

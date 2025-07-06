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
      city: json['city'] as String?,
      district: json['district'] as String?,
      transport: json['transport'] as String?,
      availability: (json['availability'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      willingToLearn: json['willing_to_learn'] as bool,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      jobsCompleted: (json['jobs_completed'] as num?)?.toInt() ?? 0,
      verificationBadges: json['verification_badges'] as Map<String, dynamic>,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      trustScore: json['trust_score'] == null
          ? null
          : TrustScore.fromJson(json['trust_score'] as Map<String, dynamic>),
      recentReviews: (json['recent_reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewSummary: json['review_summary'] == null
          ? null
          : ReviewSummary.fromJson(
              json['review_summary'] as Map<String, dynamic>),
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
      profileCompleteness: (json['profile_completeness'] as num?)?.toInt(),
      languagesSpoken: (json['languages_spoken'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      preferredJobTypes: (json['preferred_job_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      hourlyRateMin: (json['hourly_rate_min'] as num?)?.toDouble(),
      hourlyRateMax: (json['hourly_rate_max'] as num?)?.toDouble(),
      portfolioLinks: (json['portfolio_links'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      profileVisibility: json['profile_visibility'] as String?,
      showContactInfo: json['show_contact_info'] as bool?,
      showLocation: json['show_location'] as bool?,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bio': instance.bio,
      'location': instance.location,
      'city': instance.city,
      'district': instance.district,
      'transport': instance.transport,
      'availability': instance.availability,
      'willing_to_learn': instance.willingToLearn,
      'rating': instance.rating,
      'jobs_completed': instance.jobsCompleted,
      'verification_badges': instance.verificationBadges,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'user': instance.user.toJson(),
      'trust_score': instance.trustScore?.toJson(),
      'recent_reviews': instance.recentReviews?.map((e) => e.toJson()).toList(),
      'review_summary': instance.reviewSummary?.toJson(),
      'skills': instance.skills.map((e) => e.toJson()).toList(),
      'experiences': instance.experiences.map((e) => e.toJson()).toList(),
      'educations': instance.educations.map((e) => e.toJson()).toList(),
      'reviews': instance.reviews.map((e) => e.toJson()).toList(),
      'profile_completeness': instance.profileCompleteness,
      'languages_spoken': instance.languagesSpoken,
      'preferred_job_types': instance.preferredJobTypes,
      'hourly_rate_min': instance.hourlyRateMin,
      'hourly_rate_max': instance.hourlyRateMax,
      'portfolio_links': instance.portfolioLinks,
      'profile_visibility': instance.profileVisibility,
      'show_contact_info': instance.showContactInfo,
      'show_location': instance.showLocation,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getjob_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JobImpl _$$JobImplFromJson(Map<String, dynamic> json) => _$JobImpl(
      id: (json['id'] as num).toInt(),
      jobType: json['job_type'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      poster: (json['poster'] as num).toInt(),
      location: json['location'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      jobNature: json['job_nature'] as String?,
      posterName: json['poster_name'] as String?,
      workingDays: (json['working_days'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      requirements: (json['requirements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      description: json['description'] as String,
      rolesDescription: json['roles_description'] as String?,
      typeSpecific: json['type_specific'] as Map<String, dynamic>,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      postTime: json['post_time'] as String?,
      salaryDisplay: json['salary_display'] as String?,
      verificationBadges: json['verification_badges'] as Map<String, dynamic>?,
      hasApplied: json['has_applied'] as bool? ?? false,
      isSaved: json['is_saved'] as bool? ?? false,
      expiresIn: json['expires_in'] as String?,
      posterPicture: json['poster_picture'] as String?,
    );

Map<String, dynamic> _$$JobImplToJson(_$JobImpl instance) => <String, dynamic>{
      'id': instance.id,
      'job_type': instance.jobType,
      'title': instance.title,
      'category': instance.category,
      'poster': instance.poster,
      'location': instance.location,
      'created_at': instance.createdAt.toIso8601String(),
      'job_nature': instance.jobNature,
      'poster_name': instance.posterName,
      'working_days': instance.workingDays,
      'due_date': instance.dueDate?.toIso8601String(),
      'requirements': instance.requirements,
      'description': instance.description,
      'roles_description': instance.rolesDescription,
      'type_specific': instance.typeSpecific,
      'updated_at': instance.updatedAt.toIso8601String(),
      'post_time': instance.postTime,
      'salary_display': instance.salaryDisplay,
      'verification_badges': instance.verificationBadges,
      'has_applied': instance.hasApplied,
      'is_saved': instance.isSaved,
      'expires_in': instance.expiresIn,
      'poster_picture': instance.posterPicture,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostJobImpl _$$PostJobImplFromJson(Map<String, dynamic> json) =>
    _$PostJobImpl(
      id: (json['id'] as num?)?.toInt(),
      jobType: json['job_type'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      location: json['location'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      job_nature: json['job_nature'] as String?,
      description: json['description'] as String,
      rolesDescription: json['roles_description'] as String?,
      requirements: (json['requirements'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      workingDays: (json['working_days'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      dueDate: json['due_date'] as String?,
      typeSpecific: json['type_specific'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$PostJobImplToJson(_$PostJobImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'job_type': instance.jobType,
      'title': instance.title,
      'category': instance.category,
      'location': instance.location,
      'city': instance.city,
      'district': instance.district,
      'job_nature': instance.job_nature,
      'description': instance.description,
      'roles_description': instance.rolesDescription,
      'requirements': instance.requirements,
      'working_days': instance.workingDays,
      'due_date': instance.dueDate,
      'type_specific': instance.typeSpecific,
    };

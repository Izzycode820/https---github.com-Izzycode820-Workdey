// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applicant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplicantImpl _$$ApplicantImplFromJson(Map<String, dynamic> json) =>
    _$ApplicantImpl(
      id: (json['id'] as num).toInt(),
      appliedAt: DateTime.parse(json['applied_at'] as String),
      details: ApplicantDetails.fromJson(
          json['applicant_details'] as Map<String, dynamic>),
      badges: Map<String, bool>.from(json['badges'] as Map),
    );

Map<String, dynamic> _$$ApplicantImplToJson(_$ApplicantImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'applied_at': instance.appliedAt.toIso8601String(),
      'applicant_details': instance.details,
      'badges': instance.badges,
    };

_$ApplicantDetailsImpl _$$ApplicantDetailsImplFromJson(
        Map<String, dynamic> json) =>
    _$ApplicantDetailsImpl(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$$ApplicantDetailsImplToJson(
        _$ApplicantDetailsImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
    };

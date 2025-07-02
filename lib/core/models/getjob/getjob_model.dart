import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:workdey_frontend/core/models/postjob/post_job_model.dart';

part 'getjob_model.freezed.dart';
part 'getjob_model.g.dart';

@freezed
class Job with _$Job {
  @JsonSerializable(explicitToJson: true)
  const factory Job({
    required int id,
    @JsonKey(name: 'job_type') required String jobType,
    required String title,
    required String category,
    required int poster, // Can be String if just ID
    required String location,
    String? city,
    String? district,
    @JsonKey(name: 'location_display') String? locationDisplay,
    @JsonKey(name: 'is_precise') bool? isPrecise,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'job_nature') String? jobNature,
    @JsonKey(name: 'poster_name') String? posterName,
    @JsonKey(name: 'working_days') List<String>? workingDays,
    @JsonKey(name: 'due_date') DateTime? dueDate,
    List<String>? requirements,
    required String description,
    @JsonKey(name: 'roles_description') String? rolesDescription,
    @JsonKey(name: 'type_specific') required Map<String, dynamic> typeSpecific,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    
    // Computed fields from serializer
    @JsonKey(name: 'post_time') String? postTime,
    @JsonKey(name: 'salary_display') String? salaryDisplay,
    @JsonKey(name: 'verification_badges') Map<String, dynamic>? verificationBadges,
    @JsonKey(name: 'has_applied') @Default(false) bool hasApplied,
    @JsonKey(name: 'is_saved') @Default(false) bool isSaved,
    @JsonKey(name: 'expires_in') String? expiresIn,
    @JsonKey(name: 'poster_picture') String? posterPicture,
    @JsonKey(name: 'fallback_message') String? fallbackMessage,
    @JsonKey(name: 'required_skills') required List<String> requiredSkills,
    @JsonKey(name: 'optional_skills') required List<String> optionalSkills,
  }) = _Job;

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
}



  extension JobX on Job {
  PostJob toPostJob() {
    return PostJob(
      id: id,
      jobType: jobType,
      title: title,
      job_nature: jobNature ?? 'Full time',
      category: category,
      location: location,
      city: city,
      district: district,
    //  locationDisplay: locationDisplay,
      description: description,
      rolesDescription: rolesDescription,
      dueDate: dueDate?.toIso8601String().substring(0, 10),
      typeSpecific: Map<String, dynamic>.from(typeSpecific),
      requirements: requirements ?? [],
      workingDays: workingDays ?? [],
   //   requiredSkills: requiredSkills ?? [],
    );
  }
}
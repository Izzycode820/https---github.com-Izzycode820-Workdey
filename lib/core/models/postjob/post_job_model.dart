import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'post_job_model.freezed.dart';
part 'post_job_model.g.dart';

@freezed
class PostJob with _$PostJob{
  @JsonSerializable(explicitToJson: true)
  const factory PostJob({
    int? id,
     @JsonKey(name: 'job_type') required String jobType,  // Match backend
    required String title,
    required String category,
    String? location,
    String? city,   
    String? district,
    @JsonKey(name: 'job_nature') String? job_nature,  // Match backend
    required String description,
    @JsonKey(name: 'roles_description') String? rolesDescription,  // Match backend
    @Default([]) @JsonKey(name: 'requirements') List<String> requirements,
    @Default([]) @JsonKey(name: 'working_days') List<String> workingDays,
    @JsonKey(name: 'due_date') String? dueDate,  // Match backend
    @JsonKey(name: 'type_specific') @Default({}) Map<String, dynamic> typeSpecific,
    @Default([]) @JsonKey(name: 'required_skills') List<String> requiredSkills,
    @Default([]) @JsonKey(name: 'optional_skills') List<String> optionalSkills,
  }) = _PostJob;

  factory PostJob.fromJson(Map<String, dynamic> json) => _$PostJobFromJson(json);
}

  extension PostJobValidation on PostJob {
  Map<String, String>? validate() {
    final errors = <String, String>{};
    
    if (location == null && (city == null || district == null)) {
      errors['location'] = 'Either provide full location or both city and district';
    }
    
    if (title.isEmpty) {
      errors['title'] = 'Job title is required';
    }
    
    if (description.isEmpty) {
      errors['description'] = 'Description is required';
    }
    
    if (dueDate == null) {
      errors['dueDate'] = 'Due date is required';
    } else if (DateTime.tryParse(dueDate!) == null) {
      errors['dueDate'] = 'Invalid date format (YYYY-MM-DD)';
    }
    
    if (jobType == 'PRO' || jobType == 'LOC') {
      final salary = typeSpecific['salary'];
      if (salary == null || salary <= 0) {
        errors['salary'] = 'Salary must be positive';
      }
    }
    
    if (requiredSkills.isEmpty) {
      errors['requiredSkills'] = 'At least one required skill is needed';
    }
    
    return errors.isNotEmpty ? errors : null;
  }}
// lib/core/models/getworker/getworker_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:workdey_frontend/core/models/postworker/post_worker_model.dart';

part 'get_workers_model.freezed.dart';
part 'get_workers_model.g.dart';

@freezed
class Worker with _$Worker {
  @JsonSerializable(explicitToJson: true)
  const factory Worker({
    required int id,
    required String title,
    required String category,
    int? user,
    required String location,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    List<String>? skills,
    String? bio,
    String? availability,
    @JsonKey(name: 'experience_years') int? experienceYears,
    @JsonKey(name: 'portfolio_link') String? portfolioLink,
    
    // Computed fields
    @JsonKey(name: 'post_time') String? postTime,
    @JsonKey(name: 'category_display') String? categoryDisplay,
    @JsonKey(name: 'verification_badges') Map<String, dynamic>? verificationBadges,
    @JsonKey(name: 'is_saved') @Default(false) bool isSaved,
    @JsonKey(name: 'profile_picture') String? profilePicture,
    @JsonKey(name: 'name') String? userName,
  }) = _Worker;

  factory Worker.fromJson(Map<String, dynamic> json) => _$WorkerFromJson(json);
}

extension WorkerX on Worker {
  PostWorker toPostWorker() {
    if (title == null || category == null || location == null || 
        skills == null || bio == null || availability == null || 
        experienceYears == null) {
      throw ArgumentError('Required worker fields cannot be null');
    }

    return PostWorker(
      title: title!,
      category: category!,
      location: location!,
      skills: skills!,
      bio: bio!,
      availability: availability!,
      experienceYears: experienceYears!,
      portfolioLink: portfolioLink,
    );
  }
}
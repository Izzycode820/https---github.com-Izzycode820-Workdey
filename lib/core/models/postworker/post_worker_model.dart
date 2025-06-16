// models/post_worker_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'post_worker_model.freezed.dart';
part 'post_worker_model.g.dart';

@freezed
class PostWorker with _$PostWorker {
  @JsonSerializable(explicitToJson: true)
  const factory PostWorker({
    required String title,
    required String category,
    required String location,
    required List<String> skills,
    String? bio,
    String? availability,
    @JsonKey(name: 'experience_years') int? experienceYears,
    @JsonKey(name: 'portfolio_link') String? portfolioLink,
  }) = _PostWorker;

  factory PostWorker.fromJson(Map<String, dynamic> json) => _$PostWorkerFromJson(json);
}
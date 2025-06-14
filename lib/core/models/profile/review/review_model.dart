import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:workdey_frontend/core/models/user/user_model.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
class Review with _$Review {
  const factory Review({
    int? id,
    User? reviewer,
    User? worker,
    int? rating,
    String? comment,
    @JsonKey(name: 'created_at')  DateTime? createdAt,
    @JsonKey(name: 'updated_at')  DateTime? updatedAt,
    @JsonKey(name: 'reviewer_type') String? reviewerType,
    int? job,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill_model.freezed.dart';
part 'skill_model.g.dart';

@freezed
class Skill with _$Skill {
  const factory Skill({
    required int id,
    @JsonKey(name: 'user_id') int? userId,
    required String name,
    required String proficiency,
    @JsonKey(name: 'is_willing_to_learn') required bool isWillingToLearn,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}
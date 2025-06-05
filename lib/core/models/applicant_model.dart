// applicant_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'applicant_model.freezed.dart';
part 'applicant_model.g.dart';

@freezed
class Applicant with _$Applicant {
  const factory Applicant({
    required int id,
    @JsonKey(name: 'applied_at') required DateTime appliedAt,
    @JsonKey(name: 'applicant_details') required ApplicantDetails details,
    required Map<String, bool> badges,
  }) = _Applicant;

  factory Applicant.fromJson(Map<String, dynamic> json) => 
      _$ApplicantFromJson(json);
}

@freezed
class ApplicantDetails with _$ApplicantDetails {
  const factory ApplicantDetails({
    required String name,
    required String email,
    required String phone,
  }) = _ApplicantDetails;

  factory ApplicantDetails.fromJson(Map<String, dynamic> json) => 
      _$ApplicantDetailsFromJson(json);
}
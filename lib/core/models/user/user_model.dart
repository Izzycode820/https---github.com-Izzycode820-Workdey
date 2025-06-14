import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  const User._();
  const factory User({
    required int id,
    required String email,
    String? phone,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'verification_status') Map<String, dynamic>? verificationStatus,
    @JsonKey(name: 'profile_picture') String? profilePicture,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  String get fullName => [firstName, lastName].where((part) => part != null).join(' ');
}
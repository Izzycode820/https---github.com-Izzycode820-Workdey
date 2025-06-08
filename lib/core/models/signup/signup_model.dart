import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_model.freezed.dart';
part 'signup_model.g.dart';

@freezed
class Signup with _$Signup {
  const factory Signup({
    required String email,
    required String phone,
    required String password,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
  }) = _Signup;

  factory Signup.fromJson(Map<String, dynamic> json) =>
      _$SignupFromJson(json);
}
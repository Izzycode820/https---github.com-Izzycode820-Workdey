import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:workdey_frontend/core/models/login/login_model.dart';

part 'login_state.freezed.dart';
part 'login_state.g.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(AuthResponse response) = _Authenticated;
  const factory AuthState.error(String message) = _Error;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
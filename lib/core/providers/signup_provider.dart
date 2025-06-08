import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/signup/signup_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/signup_service.dart';

final signupServiceProvider = Provider<SignupService>((ref) {
  return SignupService(ref.read(dioProvider));
});

final signupProvider = StateNotifierProvider<SignupNotifier, AsyncValue<void>>((ref) {
  return SignupNotifier(ref.read(signupServiceProvider));
});

class SignupNotifier extends StateNotifier<AsyncValue<void>> {
  final SignupService _signupService;

  SignupNotifier(this._signupService) : super(const AsyncValue.data(null));

  Future<void> signup(Signup signup) async {
    state = const AsyncValue.loading();
    try {
      await _signupService.signup(signup);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
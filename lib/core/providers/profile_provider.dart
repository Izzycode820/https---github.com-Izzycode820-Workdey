import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/profile/profile_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/profile_service.dart';

final profileServiceProvider = Provider<ProfileService>((ref) {
  return ProfileService(ref.read(dioProvider));
});

// Main profile provider
final profileProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<UserProfile>>((ref) {
  return ProfileNotifier(ref.read(profileServiceProvider));
});

class ProfileNotifier extends StateNotifier<AsyncValue<UserProfile>> {
  final ProfileService _profileService;

  ProfileNotifier(this._profileService) : super(const AsyncValue.loading()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      state = const AsyncValue.loading();
      final profile = await _profileService.getMyProfile();
      if (profile == null) {
        throw Exception('Profile data is null');
}
      state = AsyncValue.data(profile);
    } catch (e, st) {
      debugPrint('Profile Notifier Error: $e');
      state = AsyncValue.error(e, st);
    }
  }

   Future<void> updateProfile(Map<String, dynamic> data) async {
    try {
      state = const AsyncValue.loading();
      final updatedProfile = await _profileService.updateMyProfile(data);
      state = AsyncValue.data(updatedProfile);
    } catch (e, st) {
      debugPrint('Update Profile Notifier Error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
  }


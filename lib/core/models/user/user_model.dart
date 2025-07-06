// lib/core/models/user/user_model.dart
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
  
  // Add these helper methods to properly access verification data:
  int get verificationLevel {
    if (verificationStatus == null) return 0;
    final level = verificationStatus!['level'];
    
    // Handle both string and int responses
    if (level is int) return level;
    if (level is String) {
      switch (level.toLowerCase()) {
        case 'unverified': return 0;
        case 'email only': return 1;
        case 'email + phone': return 2;
        case 'fully verified': return 3;
        default: return 0;
      }
    }
    return 0;
  }
  
  Map<String, dynamic>? get verificationBadges {
    return verificationStatus?['badges'] as Map<String, dynamic>?;
  }
  
  String get verificationLevelDisplay {
    return verificationStatus?['level'] as String? ?? 'Unverified';
  }
}
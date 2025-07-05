import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:workdey_frontend/core/models/location/locationzone/location_zone_model.dart';


part 'user_location_preference_model.freezed.dart';
part 'user_location_preference_model.g.dart';

@freezed
class UserLocationPreference with _$UserLocationPreference {
  const factory UserLocationPreference({
    int? id,
    LocationZone? homeZone,
    LocationZone? workZone,
    LocationZone? schoolZone,
    @Default(30) int maxTravelTime, // minutes
    @Default(1000) int maxTransportCost, // FCFA
    @Default([]) List<String> preferredTransport,
    @Default(true) bool notifyNearbyJobs,
    double? currentLatitude,
    double? currentLongitude,
    DateTime? lastLocationUpdate,
    @Default([]) List<LocationZone> reachableZones,
  }) = _UserLocationPreference;

  factory UserLocationPreference.fromJson(Map<String, dynamic> json) => 
      _$UserLocationPreferenceFromJson(json);
}
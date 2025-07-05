// Based on your backend LocationZone model
import 'package:freezed_annotation/freezed_annotation.dart';


part 'location_zone_model.freezed.dart';
part 'location_zone_model.g.dart';

@freezed
class LocationZone with _$LocationZone {
  const factory LocationZone({
    required int id,
    required String name,
    required String city,
    String? district,
    String? description,
    @Default(false) bool isPopular,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'full_name') String? fullName,
  }) = _LocationZone;

  factory LocationZone.fromJson(Map<String, dynamic> json) => 
      _$LocationZoneFromJson(json);
}
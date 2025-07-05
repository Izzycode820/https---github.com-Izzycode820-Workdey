// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location_preference_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserLocationPreferenceImpl _$$UserLocationPreferenceImplFromJson(
        Map<String, dynamic> json) =>
    _$UserLocationPreferenceImpl(
      id: (json['id'] as num?)?.toInt(),
      homeZone: json['homeZone'] == null
          ? null
          : LocationZone.fromJson(json['homeZone'] as Map<String, dynamic>),
      workZone: json['workZone'] == null
          ? null
          : LocationZone.fromJson(json['workZone'] as Map<String, dynamic>),
      schoolZone: json['schoolZone'] == null
          ? null
          : LocationZone.fromJson(json['schoolZone'] as Map<String, dynamic>),
      maxTravelTime: (json['maxTravelTime'] as num?)?.toInt() ?? 30,
      maxTransportCost: (json['maxTransportCost'] as num?)?.toInt() ?? 1000,
      preferredTransport: (json['preferredTransport'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      notifyNearbyJobs: json['notifyNearbyJobs'] as bool? ?? true,
      currentLatitude: (json['currentLatitude'] as num?)?.toDouble(),
      currentLongitude: (json['currentLongitude'] as num?)?.toDouble(),
      lastLocationUpdate: json['lastLocationUpdate'] == null
          ? null
          : DateTime.parse(json['lastLocationUpdate'] as String),
      reachableZones: (json['reachableZones'] as List<dynamic>?)
              ?.map((e) => LocationZone.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserLocationPreferenceImplToJson(
        _$UserLocationPreferenceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'homeZone': instance.homeZone,
      'workZone': instance.workZone,
      'schoolZone': instance.schoolZone,
      'maxTravelTime': instance.maxTravelTime,
      'maxTransportCost': instance.maxTransportCost,
      'preferredTransport': instance.preferredTransport,
      'notifyNearbyJobs': instance.notifyNearbyJobs,
      'currentLatitude': instance.currentLatitude,
      'currentLongitude': instance.currentLongitude,
      'lastLocationUpdate': instance.lastLocationUpdate?.toIso8601String(),
      'reachableZones': instance.reachableZones,
    };

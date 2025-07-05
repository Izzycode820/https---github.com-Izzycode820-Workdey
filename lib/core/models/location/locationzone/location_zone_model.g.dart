// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_zone_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationZoneImpl _$$LocationZoneImplFromJson(Map<String, dynamic> json) =>
    _$LocationZoneImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      city: json['city'] as String,
      district: json['district'] as String?,
      description: json['description'] as String?,
      isPopular: json['isPopular'] as bool? ?? false,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      fullName: json['full_name'] as String?,
    );

Map<String, dynamic> _$$LocationZoneImplToJson(_$LocationZoneImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'district': instance.district,
      'description': instance.description,
      'isPopular': instance.isPopular,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'full_name': instance.fullName,
    };

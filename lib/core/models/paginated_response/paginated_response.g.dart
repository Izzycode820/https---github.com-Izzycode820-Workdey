// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginatedResponseImpl<T> _$$PaginatedResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$PaginatedResponseImpl<T>(
      count: (json['count'] as num).toInt(),
      results: (json['results'] as List<dynamic>).map(fromJsonT).toList(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
    );

Map<String, dynamic> _$$PaginatedResponseImplToJson<T>(
  _$PaginatedResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'count': instance.count,
      'results': instance.results.map(toJsonT).toList(),
      'next': instance.next,
      'previous': instance.previous,
    };

import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_response.freezed.dart';
part 'paginated_response.g.dart';

@Freezed(genericArgumentFactories: true) // Add this critical line
class PaginatedResponse<T> with _$PaginatedResponse<T> {
  const factory PaginatedResponse({
    required int count,
    required List<T> results,
    String? next,
    String? previous,
  }) = _PaginatedResponse<T>;

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT, // This handles the generic type
  ) =>
      _$PaginatedResponseFromJson(json, fromJsonT);
}
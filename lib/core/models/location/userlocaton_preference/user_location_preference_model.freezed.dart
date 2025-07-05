// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_location_preference_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserLocationPreference _$UserLocationPreferenceFromJson(
    Map<String, dynamic> json) {
  return _UserLocationPreference.fromJson(json);
}

/// @nodoc
mixin _$UserLocationPreference {
  int? get id => throw _privateConstructorUsedError;
  LocationZone? get homeZone => throw _privateConstructorUsedError;
  LocationZone? get workZone => throw _privateConstructorUsedError;
  LocationZone? get schoolZone => throw _privateConstructorUsedError;
  int get maxTravelTime => throw _privateConstructorUsedError; // minutes
  int get maxTransportCost => throw _privateConstructorUsedError; // FCFA
  List<String> get preferredTransport => throw _privateConstructorUsedError;
  bool get notifyNearbyJobs => throw _privateConstructorUsedError;
  double? get currentLatitude => throw _privateConstructorUsedError;
  double? get currentLongitude => throw _privateConstructorUsedError;
  DateTime? get lastLocationUpdate => throw _privateConstructorUsedError;
  List<LocationZone> get reachableZones => throw _privateConstructorUsedError;

  /// Serializes this UserLocationPreference to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserLocationPreference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserLocationPreferenceCopyWith<UserLocationPreference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserLocationPreferenceCopyWith<$Res> {
  factory $UserLocationPreferenceCopyWith(UserLocationPreference value,
          $Res Function(UserLocationPreference) then) =
      _$UserLocationPreferenceCopyWithImpl<$Res, UserLocationPreference>;
  @useResult
  $Res call(
      {int? id,
      LocationZone? homeZone,
      LocationZone? workZone,
      LocationZone? schoolZone,
      int maxTravelTime,
      int maxTransportCost,
      List<String> preferredTransport,
      bool notifyNearbyJobs,
      double? currentLatitude,
      double? currentLongitude,
      DateTime? lastLocationUpdate,
      List<LocationZone> reachableZones});

  $LocationZoneCopyWith<$Res>? get homeZone;
  $LocationZoneCopyWith<$Res>? get workZone;
  $LocationZoneCopyWith<$Res>? get schoolZone;
}

/// @nodoc
class _$UserLocationPreferenceCopyWithImpl<$Res,
        $Val extends UserLocationPreference>
    implements $UserLocationPreferenceCopyWith<$Res> {
  _$UserLocationPreferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserLocationPreference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? homeZone = freezed,
    Object? workZone = freezed,
    Object? schoolZone = freezed,
    Object? maxTravelTime = null,
    Object? maxTransportCost = null,
    Object? preferredTransport = null,
    Object? notifyNearbyJobs = null,
    Object? currentLatitude = freezed,
    Object? currentLongitude = freezed,
    Object? lastLocationUpdate = freezed,
    Object? reachableZones = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      homeZone: freezed == homeZone
          ? _value.homeZone
          : homeZone // ignore: cast_nullable_to_non_nullable
              as LocationZone?,
      workZone: freezed == workZone
          ? _value.workZone
          : workZone // ignore: cast_nullable_to_non_nullable
              as LocationZone?,
      schoolZone: freezed == schoolZone
          ? _value.schoolZone
          : schoolZone // ignore: cast_nullable_to_non_nullable
              as LocationZone?,
      maxTravelTime: null == maxTravelTime
          ? _value.maxTravelTime
          : maxTravelTime // ignore: cast_nullable_to_non_nullable
              as int,
      maxTransportCost: null == maxTransportCost
          ? _value.maxTransportCost
          : maxTransportCost // ignore: cast_nullable_to_non_nullable
              as int,
      preferredTransport: null == preferredTransport
          ? _value.preferredTransport
          : preferredTransport // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notifyNearbyJobs: null == notifyNearbyJobs
          ? _value.notifyNearbyJobs
          : notifyNearbyJobs // ignore: cast_nullable_to_non_nullable
              as bool,
      currentLatitude: freezed == currentLatitude
          ? _value.currentLatitude
          : currentLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      currentLongitude: freezed == currentLongitude
          ? _value.currentLongitude
          : currentLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      lastLocationUpdate: freezed == lastLocationUpdate
          ? _value.lastLocationUpdate
          : lastLocationUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reachableZones: null == reachableZones
          ? _value.reachableZones
          : reachableZones // ignore: cast_nullable_to_non_nullable
              as List<LocationZone>,
    ) as $Val);
  }

  /// Create a copy of UserLocationPreference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationZoneCopyWith<$Res>? get homeZone {
    if (_value.homeZone == null) {
      return null;
    }

    return $LocationZoneCopyWith<$Res>(_value.homeZone!, (value) {
      return _then(_value.copyWith(homeZone: value) as $Val);
    });
  }

  /// Create a copy of UserLocationPreference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationZoneCopyWith<$Res>? get workZone {
    if (_value.workZone == null) {
      return null;
    }

    return $LocationZoneCopyWith<$Res>(_value.workZone!, (value) {
      return _then(_value.copyWith(workZone: value) as $Val);
    });
  }

  /// Create a copy of UserLocationPreference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationZoneCopyWith<$Res>? get schoolZone {
    if (_value.schoolZone == null) {
      return null;
    }

    return $LocationZoneCopyWith<$Res>(_value.schoolZone!, (value) {
      return _then(_value.copyWith(schoolZone: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserLocationPreferenceImplCopyWith<$Res>
    implements $UserLocationPreferenceCopyWith<$Res> {
  factory _$$UserLocationPreferenceImplCopyWith(
          _$UserLocationPreferenceImpl value,
          $Res Function(_$UserLocationPreferenceImpl) then) =
      __$$UserLocationPreferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      LocationZone? homeZone,
      LocationZone? workZone,
      LocationZone? schoolZone,
      int maxTravelTime,
      int maxTransportCost,
      List<String> preferredTransport,
      bool notifyNearbyJobs,
      double? currentLatitude,
      double? currentLongitude,
      DateTime? lastLocationUpdate,
      List<LocationZone> reachableZones});

  @override
  $LocationZoneCopyWith<$Res>? get homeZone;
  @override
  $LocationZoneCopyWith<$Res>? get workZone;
  @override
  $LocationZoneCopyWith<$Res>? get schoolZone;
}

/// @nodoc
class __$$UserLocationPreferenceImplCopyWithImpl<$Res>
    extends _$UserLocationPreferenceCopyWithImpl<$Res,
        _$UserLocationPreferenceImpl>
    implements _$$UserLocationPreferenceImplCopyWith<$Res> {
  __$$UserLocationPreferenceImplCopyWithImpl(
      _$UserLocationPreferenceImpl _value,
      $Res Function(_$UserLocationPreferenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserLocationPreference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? homeZone = freezed,
    Object? workZone = freezed,
    Object? schoolZone = freezed,
    Object? maxTravelTime = null,
    Object? maxTransportCost = null,
    Object? preferredTransport = null,
    Object? notifyNearbyJobs = null,
    Object? currentLatitude = freezed,
    Object? currentLongitude = freezed,
    Object? lastLocationUpdate = freezed,
    Object? reachableZones = null,
  }) {
    return _then(_$UserLocationPreferenceImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      homeZone: freezed == homeZone
          ? _value.homeZone
          : homeZone // ignore: cast_nullable_to_non_nullable
              as LocationZone?,
      workZone: freezed == workZone
          ? _value.workZone
          : workZone // ignore: cast_nullable_to_non_nullable
              as LocationZone?,
      schoolZone: freezed == schoolZone
          ? _value.schoolZone
          : schoolZone // ignore: cast_nullable_to_non_nullable
              as LocationZone?,
      maxTravelTime: null == maxTravelTime
          ? _value.maxTravelTime
          : maxTravelTime // ignore: cast_nullable_to_non_nullable
              as int,
      maxTransportCost: null == maxTransportCost
          ? _value.maxTransportCost
          : maxTransportCost // ignore: cast_nullable_to_non_nullable
              as int,
      preferredTransport: null == preferredTransport
          ? _value._preferredTransport
          : preferredTransport // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notifyNearbyJobs: null == notifyNearbyJobs
          ? _value.notifyNearbyJobs
          : notifyNearbyJobs // ignore: cast_nullable_to_non_nullable
              as bool,
      currentLatitude: freezed == currentLatitude
          ? _value.currentLatitude
          : currentLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      currentLongitude: freezed == currentLongitude
          ? _value.currentLongitude
          : currentLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      lastLocationUpdate: freezed == lastLocationUpdate
          ? _value.lastLocationUpdate
          : lastLocationUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reachableZones: null == reachableZones
          ? _value._reachableZones
          : reachableZones // ignore: cast_nullable_to_non_nullable
              as List<LocationZone>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserLocationPreferenceImpl implements _UserLocationPreference {
  const _$UserLocationPreferenceImpl(
      {this.id,
      this.homeZone,
      this.workZone,
      this.schoolZone,
      this.maxTravelTime = 30,
      this.maxTransportCost = 1000,
      final List<String> preferredTransport = const [],
      this.notifyNearbyJobs = true,
      this.currentLatitude,
      this.currentLongitude,
      this.lastLocationUpdate,
      final List<LocationZone> reachableZones = const []})
      : _preferredTransport = preferredTransport,
        _reachableZones = reachableZones;

  factory _$UserLocationPreferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserLocationPreferenceImplFromJson(json);

  @override
  final int? id;
  @override
  final LocationZone? homeZone;
  @override
  final LocationZone? workZone;
  @override
  final LocationZone? schoolZone;
  @override
  @JsonKey()
  final int maxTravelTime;
// minutes
  @override
  @JsonKey()
  final int maxTransportCost;
// FCFA
  final List<String> _preferredTransport;
// FCFA
  @override
  @JsonKey()
  List<String> get preferredTransport {
    if (_preferredTransport is EqualUnmodifiableListView)
      return _preferredTransport;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredTransport);
  }

  @override
  @JsonKey()
  final bool notifyNearbyJobs;
  @override
  final double? currentLatitude;
  @override
  final double? currentLongitude;
  @override
  final DateTime? lastLocationUpdate;
  final List<LocationZone> _reachableZones;
  @override
  @JsonKey()
  List<LocationZone> get reachableZones {
    if (_reachableZones is EqualUnmodifiableListView) return _reachableZones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reachableZones);
  }

  @override
  String toString() {
    return 'UserLocationPreference(id: $id, homeZone: $homeZone, workZone: $workZone, schoolZone: $schoolZone, maxTravelTime: $maxTravelTime, maxTransportCost: $maxTransportCost, preferredTransport: $preferredTransport, notifyNearbyJobs: $notifyNearbyJobs, currentLatitude: $currentLatitude, currentLongitude: $currentLongitude, lastLocationUpdate: $lastLocationUpdate, reachableZones: $reachableZones)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserLocationPreferenceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.homeZone, homeZone) ||
                other.homeZone == homeZone) &&
            (identical(other.workZone, workZone) ||
                other.workZone == workZone) &&
            (identical(other.schoolZone, schoolZone) ||
                other.schoolZone == schoolZone) &&
            (identical(other.maxTravelTime, maxTravelTime) ||
                other.maxTravelTime == maxTravelTime) &&
            (identical(other.maxTransportCost, maxTransportCost) ||
                other.maxTransportCost == maxTransportCost) &&
            const DeepCollectionEquality()
                .equals(other._preferredTransport, _preferredTransport) &&
            (identical(other.notifyNearbyJobs, notifyNearbyJobs) ||
                other.notifyNearbyJobs == notifyNearbyJobs) &&
            (identical(other.currentLatitude, currentLatitude) ||
                other.currentLatitude == currentLatitude) &&
            (identical(other.currentLongitude, currentLongitude) ||
                other.currentLongitude == currentLongitude) &&
            (identical(other.lastLocationUpdate, lastLocationUpdate) ||
                other.lastLocationUpdate == lastLocationUpdate) &&
            const DeepCollectionEquality()
                .equals(other._reachableZones, _reachableZones));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      homeZone,
      workZone,
      schoolZone,
      maxTravelTime,
      maxTransportCost,
      const DeepCollectionEquality().hash(_preferredTransport),
      notifyNearbyJobs,
      currentLatitude,
      currentLongitude,
      lastLocationUpdate,
      const DeepCollectionEquality().hash(_reachableZones));

  /// Create a copy of UserLocationPreference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserLocationPreferenceImplCopyWith<_$UserLocationPreferenceImpl>
      get copyWith => __$$UserLocationPreferenceImplCopyWithImpl<
          _$UserLocationPreferenceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserLocationPreferenceImplToJson(
      this,
    );
  }
}

abstract class _UserLocationPreference implements UserLocationPreference {
  const factory _UserLocationPreference(
      {final int? id,
      final LocationZone? homeZone,
      final LocationZone? workZone,
      final LocationZone? schoolZone,
      final int maxTravelTime,
      final int maxTransportCost,
      final List<String> preferredTransport,
      final bool notifyNearbyJobs,
      final double? currentLatitude,
      final double? currentLongitude,
      final DateTime? lastLocationUpdate,
      final List<LocationZone> reachableZones}) = _$UserLocationPreferenceImpl;

  factory _UserLocationPreference.fromJson(Map<String, dynamic> json) =
      _$UserLocationPreferenceImpl.fromJson;

  @override
  int? get id;
  @override
  LocationZone? get homeZone;
  @override
  LocationZone? get workZone;
  @override
  LocationZone? get schoolZone;
  @override
  int get maxTravelTime; // minutes
  @override
  int get maxTransportCost; // FCFA
  @override
  List<String> get preferredTransport;
  @override
  bool get notifyNearbyJobs;
  @override
  double? get currentLatitude;
  @override
  double? get currentLongitude;
  @override
  DateTime? get lastLocationUpdate;
  @override
  List<LocationZone> get reachableZones;

  /// Create a copy of UserLocationPreference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserLocationPreferenceImplCopyWith<_$UserLocationPreferenceImpl>
      get copyWith => throw _privateConstructorUsedError;
}

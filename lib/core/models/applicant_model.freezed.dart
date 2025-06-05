// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'applicant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Applicant _$ApplicantFromJson(Map<String, dynamic> json) {
  return _Applicant.fromJson(json);
}

/// @nodoc
mixin _$Applicant {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'applied_at')
  DateTime get appliedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'applicant_details')
  ApplicantDetails get details => throw _privateConstructorUsedError;
  Map<String, bool> get badges => throw _privateConstructorUsedError;

  /// Serializes this Applicant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Applicant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApplicantCopyWith<Applicant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicantCopyWith<$Res> {
  factory $ApplicantCopyWith(Applicant value, $Res Function(Applicant) then) =
      _$ApplicantCopyWithImpl<$Res, Applicant>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'applied_at') DateTime appliedAt,
      @JsonKey(name: 'applicant_details') ApplicantDetails details,
      Map<String, bool> badges});

  $ApplicantDetailsCopyWith<$Res> get details;
}

/// @nodoc
class _$ApplicantCopyWithImpl<$Res, $Val extends Applicant>
    implements $ApplicantCopyWith<$Res> {
  _$ApplicantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Applicant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appliedAt = null,
    Object? details = null,
    Object? badges = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      appliedAt: null == appliedAt
          ? _value.appliedAt
          : appliedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as ApplicantDetails,
      badges: null == badges
          ? _value.badges
          : badges // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ) as $Val);
  }

  /// Create a copy of Applicant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApplicantDetailsCopyWith<$Res> get details {
    return $ApplicantDetailsCopyWith<$Res>(_value.details, (value) {
      return _then(_value.copyWith(details: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApplicantImplCopyWith<$Res>
    implements $ApplicantCopyWith<$Res> {
  factory _$$ApplicantImplCopyWith(
          _$ApplicantImpl value, $Res Function(_$ApplicantImpl) then) =
      __$$ApplicantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'applied_at') DateTime appliedAt,
      @JsonKey(name: 'applicant_details') ApplicantDetails details,
      Map<String, bool> badges});

  @override
  $ApplicantDetailsCopyWith<$Res> get details;
}

/// @nodoc
class __$$ApplicantImplCopyWithImpl<$Res>
    extends _$ApplicantCopyWithImpl<$Res, _$ApplicantImpl>
    implements _$$ApplicantImplCopyWith<$Res> {
  __$$ApplicantImplCopyWithImpl(
      _$ApplicantImpl _value, $Res Function(_$ApplicantImpl) _then)
      : super(_value, _then);

  /// Create a copy of Applicant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appliedAt = null,
    Object? details = null,
    Object? badges = null,
  }) {
    return _then(_$ApplicantImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      appliedAt: null == appliedAt
          ? _value.appliedAt
          : appliedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as ApplicantDetails,
      badges: null == badges
          ? _value._badges
          : badges // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApplicantImpl implements _Applicant {
  const _$ApplicantImpl(
      {required this.id,
      @JsonKey(name: 'applied_at') required this.appliedAt,
      @JsonKey(name: 'applicant_details') required this.details,
      required final Map<String, bool> badges})
      : _badges = badges;

  factory _$ApplicantImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplicantImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'applied_at')
  final DateTime appliedAt;
  @override
  @JsonKey(name: 'applicant_details')
  final ApplicantDetails details;
  final Map<String, bool> _badges;
  @override
  Map<String, bool> get badges {
    if (_badges is EqualUnmodifiableMapView) return _badges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_badges);
  }

  @override
  String toString() {
    return 'Applicant(id: $id, appliedAt: $appliedAt, details: $details, badges: $badges)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplicantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.appliedAt, appliedAt) ||
                other.appliedAt == appliedAt) &&
            (identical(other.details, details) || other.details == details) &&
            const DeepCollectionEquality().equals(other._badges, _badges));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, appliedAt, details,
      const DeepCollectionEquality().hash(_badges));

  /// Create a copy of Applicant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplicantImplCopyWith<_$ApplicantImpl> get copyWith =>
      __$$ApplicantImplCopyWithImpl<_$ApplicantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplicantImplToJson(
      this,
    );
  }
}

abstract class _Applicant implements Applicant {
  const factory _Applicant(
      {required final int id,
      @JsonKey(name: 'applied_at') required final DateTime appliedAt,
      @JsonKey(name: 'applicant_details')
      required final ApplicantDetails details,
      required final Map<String, bool> badges}) = _$ApplicantImpl;

  factory _Applicant.fromJson(Map<String, dynamic> json) =
      _$ApplicantImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'applied_at')
  DateTime get appliedAt;
  @override
  @JsonKey(name: 'applicant_details')
  ApplicantDetails get details;
  @override
  Map<String, bool> get badges;

  /// Create a copy of Applicant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplicantImplCopyWith<_$ApplicantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApplicantDetails _$ApplicantDetailsFromJson(Map<String, dynamic> json) {
  return _ApplicantDetails.fromJson(json);
}

/// @nodoc
mixin _$ApplicantDetails {
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;

  /// Serializes this ApplicantDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApplicantDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApplicantDetailsCopyWith<ApplicantDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicantDetailsCopyWith<$Res> {
  factory $ApplicantDetailsCopyWith(
          ApplicantDetails value, $Res Function(ApplicantDetails) then) =
      _$ApplicantDetailsCopyWithImpl<$Res, ApplicantDetails>;
  @useResult
  $Res call({String name, String email, String phone});
}

/// @nodoc
class _$ApplicantDetailsCopyWithImpl<$Res, $Val extends ApplicantDetails>
    implements $ApplicantDetailsCopyWith<$Res> {
  _$ApplicantDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApplicantDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? phone = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApplicantDetailsImplCopyWith<$Res>
    implements $ApplicantDetailsCopyWith<$Res> {
  factory _$$ApplicantDetailsImplCopyWith(_$ApplicantDetailsImpl value,
          $Res Function(_$ApplicantDetailsImpl) then) =
      __$$ApplicantDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String email, String phone});
}

/// @nodoc
class __$$ApplicantDetailsImplCopyWithImpl<$Res>
    extends _$ApplicantDetailsCopyWithImpl<$Res, _$ApplicantDetailsImpl>
    implements _$$ApplicantDetailsImplCopyWith<$Res> {
  __$$ApplicantDetailsImplCopyWithImpl(_$ApplicantDetailsImpl _value,
      $Res Function(_$ApplicantDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApplicantDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? phone = null,
  }) {
    return _then(_$ApplicantDetailsImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApplicantDetailsImpl implements _ApplicantDetails {
  const _$ApplicantDetailsImpl(
      {required this.name, required this.email, required this.phone});

  factory _$ApplicantDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplicantDetailsImplFromJson(json);

  @override
  final String name;
  @override
  final String email;
  @override
  final String phone;

  @override
  String toString() {
    return 'ApplicantDetails(name: $name, email: $email, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplicantDetailsImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, phone);

  /// Create a copy of ApplicantDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplicantDetailsImplCopyWith<_$ApplicantDetailsImpl> get copyWith =>
      __$$ApplicantDetailsImplCopyWithImpl<_$ApplicantDetailsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplicantDetailsImplToJson(
      this,
    );
  }
}

abstract class _ApplicantDetails implements ApplicantDetails {
  const factory _ApplicantDetails(
      {required final String name,
      required final String email,
      required final String phone}) = _$ApplicantDetailsImpl;

  factory _ApplicantDetails.fromJson(Map<String, dynamic> json) =
      _$ApplicantDetailsImpl.fromJson;

  @override
  String get name;
  @override
  String get email;
  @override
  String get phone;

  /// Create a copy of ApplicantDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplicantDetailsImplCopyWith<_$ApplicantDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Signup _$SignupFromJson(Map<String, dynamic> json) {
  return _Signup.fromJson(json);
}

/// @nodoc
mixin _$Signup {
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String get lastName => throw _privateConstructorUsedError;

  /// Serializes this Signup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Signup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignupCopyWith<Signup> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupCopyWith<$Res> {
  factory $SignupCopyWith(Signup value, $Res Function(Signup) then) =
      _$SignupCopyWithImpl<$Res, Signup>;
  @useResult
  $Res call(
      {String email,
      String phone,
      String password,
      @JsonKey(name: 'first_name') String firstName,
      @JsonKey(name: 'last_name') String lastName});
}

/// @nodoc
class _$SignupCopyWithImpl<$Res, $Val extends Signup>
    implements $SignupCopyWith<$Res> {
  _$SignupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Signup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? phone = null,
    Object? password = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignupImplCopyWith<$Res> implements $SignupCopyWith<$Res> {
  factory _$$SignupImplCopyWith(
          _$SignupImpl value, $Res Function(_$SignupImpl) then) =
      __$$SignupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String phone,
      String password,
      @JsonKey(name: 'first_name') String firstName,
      @JsonKey(name: 'last_name') String lastName});
}

/// @nodoc
class __$$SignupImplCopyWithImpl<$Res>
    extends _$SignupCopyWithImpl<$Res, _$SignupImpl>
    implements _$$SignupImplCopyWith<$Res> {
  __$$SignupImplCopyWithImpl(
      _$SignupImpl _value, $Res Function(_$SignupImpl) _then)
      : super(_value, _then);

  /// Create a copy of Signup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? phone = null,
    Object? password = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(_$SignupImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignupImpl implements _Signup {
  const _$SignupImpl(
      {required this.email,
      required this.phone,
      required this.password,
      @JsonKey(name: 'first_name') required this.firstName,
      @JsonKey(name: 'last_name') required this.lastName});

  factory _$SignupImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignupImplFromJson(json);

  @override
  final String email;
  @override
  final String phone;
  @override
  final String password;
  @override
  @JsonKey(name: 'first_name')
  final String firstName;
  @override
  @JsonKey(name: 'last_name')
  final String lastName;

  @override
  String toString() {
    return 'Signup(email: $email, phone: $phone, password: $password, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, phone, password, firstName, lastName);

  /// Create a copy of Signup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupImplCopyWith<_$SignupImpl> get copyWith =>
      __$$SignupImplCopyWithImpl<_$SignupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignupImplToJson(
      this,
    );
  }
}

abstract class _Signup implements Signup {
  const factory _Signup(
          {required final String email,
          required final String phone,
          required final String password,
          @JsonKey(name: 'first_name') required final String firstName,
          @JsonKey(name: 'last_name') required final String lastName}) =
      _$SignupImpl;

  factory _Signup.fromJson(Map<String, dynamic> json) = _$SignupImpl.fromJson;

  @override
  String get email;
  @override
  String get phone;
  @override
  String get password;
  @override
  @JsonKey(name: 'first_name')
  String get firstName;
  @override
  @JsonKey(name: 'last_name')
  String get lastName;

  /// Create a copy of Signup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupImplCopyWith<_$SignupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

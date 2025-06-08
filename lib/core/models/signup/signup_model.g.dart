// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignupImpl _$$SignupImplFromJson(Map<String, dynamic> json) => _$SignupImpl(
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );

Map<String, dynamic> _$$SignupImplToJson(_$SignupImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };

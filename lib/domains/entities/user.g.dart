// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      isEmailVerified: json['is_email_verified'] as bool? ?? false,
      phoneNumber: json['phone_number'] as String?,
      isAdmin: json['is_admin'] as bool?,
      lastLogin: DateTime.parse(json['last_login'] as String),
      dateJoined: DateTime.parse(json['date_joined'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'name': instance.name,
      'created_at': instance.createdAt.toIso8601String(),
      'is_email_verified': instance.isEmailVerified,
      'phone_number': instance.phoneNumber,
      'is_admin': instance.isAdmin,
      'last_login': instance.lastLogin.toIso8601String(),
      'date_joined': instance.dateJoined.toIso8601String(),
    };

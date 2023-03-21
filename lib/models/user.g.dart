// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['id'] as int?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      salt: json['salt'] as String?,
      hashPassword: json['hashPassword'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'password': instance.password,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'salt': instance.salt,
      'hashPassword': instance.hashPassword,
      'isActive': instance.isActive,
    };

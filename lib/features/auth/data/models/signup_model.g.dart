// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpModel _$SignUpModelFromEntity(SignUpEntity instance) => SignUpModel(
    uId: instance.uId,
    firstName: instance.firstName,
    lastName: instance.lastName,
    email: instance.email,
    password: instance.password,
    role: instance.role);

SignUpEntity _$SignUpModelToEntity(Map<String, dynamic> json) => SignUpEntity(
  uId: json['uId'] as String?,
  email: json['email'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  password: json['password'] as String?,
  role: json['role'] as String? //$enumDecodeNullable(_$UserRolesEnumMap, json['role']),
);


SignUpModel _$SignUpModelFromJson(Map<String, dynamic> json) => SignUpModel(
      uId: json['uId'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String? //$enumDecodeNullable(_$UserRolesEnumMap, json['role']),
    );

Map<String, dynamic> _$SignUpModelToJson(SignUpModel instance) =>
    <String, dynamic>{
      'uId': instance.uId,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'password': instance.password,
      'role': UserRolesEnumMap[instance.role],
    };

// const _$UserRolesEnumMap = {
//   UserRoles.USER: 'USER',
//   UserRoles.DOCTOR: 'DOCTOR',
//   UserRoles.ADMIN: 'ADMIN',
// };
 const _$UserRolesEnumMap = {
  UserRoles.USER: 'User',
  UserRoles.DOCTOR: 'Doctor',
  UserRoles.ADMIN: 'Admin',
};




import 'package:moms_care/core/constants/enam/user_roles.dart';
import 'package:moms_care/features/auth/domain/entities/signup_entity.dart';


// part 'signup_model.g.dart';


class SignUpModel extends SignUpEntity{

  late String?  fullName;

   SignUpModel({
     super.uId,
     super.email,
     super.firstName,
     super.lastName,
     super.password,
     super.role,
  }){
    this.fullName=" ${firstName} ${" "} ${lastName}";
  }

   SignUpModel copyWith({String? uId,String? email,String ? role,
      String ? firstName, String ? lastName,String ? password}){
     return  SignUpModel(
         uId: uId ?? this.uId,
         email: email ?? this.email,
         firstName: firstName ?? this.firstName,
         lastName: lastName ?? this.lastName,
         password: password ?? this.password,
         role: role ?? this.role);
   }

  factory SignUpModel.fromJson(Map<String, dynamic> json) => _$SignUpModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);
  SignUpEntity toEntity(Map<String, dynamic> json) => _$SignUpModelToEntity(json);
  factory SignUpModel.fromEntity(SignUpEntity instance) =>_$SignUpModelFromEntity(instance);





}

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
      'role': instance.role,
    };
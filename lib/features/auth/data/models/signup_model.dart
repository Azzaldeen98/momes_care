
import 'package:json_annotation/json_annotation.dart';
import 'package:moms_care/core/constants/enam/user_roles.dart';
import 'package:moms_care/features/auth/domain/entities/signup_entity.dart';


part 'signup_model.g.dart';

@JsonSerializable()
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
import 'package:equatable/equatable.dart';

import 'package:moms_care/core/constants/enam/user_roles.dart';

class SignUpEntity extends Equatable{
  final String ? uId;
  final String ? email;
  final String ? firstName;
  final String ? lastName;
  final String ? password;
  final String ? role;

  const SignUpEntity({
    this.uId,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.role,
  });

  @override
  List < Object ? > get props => [uId,email, firstName, lastName, password,role];

}
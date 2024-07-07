import 'package:equatable/equatable.dart';

class SignUpEntity extends Equatable{
  final String ? email;
  final String ? firstName;
  final String ? lastName;
  final String ? password;
  final String ? role;

  const SignUpEntity({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.role,
  });

  @override
  List < Object ? > get props {
    return [
      email,
      firstName,
      lastName,
      password,
      role,

    ];
  }
}
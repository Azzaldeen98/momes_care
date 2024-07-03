import 'package:equatable/equatable.dart';

class SignUpEntity extends Equatable{
  final String ? email;
  final String ? firstName;
  final String ? lastName;
  final String ? password;

  const SignUpEntity({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
  });

  @override
  List < Object ? > get props {
    return [
      email,
      firstName,
      lastName,
      password,

    ];
  }
}
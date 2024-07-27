// ignore_for_file: constant_identifier_names

enum UserRoles {
  USER('User'),
  DOCTOR('Doctor'),
  ADMIN('Admin');

  final String? text;
  const UserRoles(this.text);
}

const UserRolesEnumMap = {
  UserRoles.USER: 'User',
  UserRoles.DOCTOR: 'Doctor',
  UserRoles.ADMIN: 'Admin',
};

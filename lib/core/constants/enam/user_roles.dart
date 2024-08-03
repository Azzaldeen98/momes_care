// ignore_for_file: constant_identifier_names

enum UserRoles {
  USER('User'),
  DOCTOR('Doctor'),
  ADMIN('Admin');

  final String? text;
  const UserRoles(this.text);


  static UserRoles? firstValue() {
    return UserRoles.values[0];
  }
  static UserRoles? fromString(String type) {
    for (UserRoles typeEnum in UserRoles.values) {
      if (typeEnum.text == type) {
        return typeEnum;
      }
    }
    return null;
  }
  static bool isValid(String value) {
    for (var course in UserRoles.values) {
      if (course.text == value) {
        return true;
      }
    }
    return false;
  }


}

// const UserRolesEnumMap = {
//   UserRoles.USER: 'User',
//   UserRoles.DOCTOR: 'Doctor',
//   UserRoles.ADMIN: 'Admin',
// };

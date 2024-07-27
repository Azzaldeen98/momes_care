

enum CourseType {
  Course1("Course1"),
  Course2("Course2");

  final String text;
  const CourseType(this.text);

 static List<String?> getStringValues() {
    return  CourseType.values.map((course) => course.text).toList();
  }

  static CourseType? firstValue() {
      return CourseType.values[0];
  }
  static CourseType? fromString(String type) {
    for (CourseType typeEnum in CourseType.values) {
      if (typeEnum.text == type) {
        return typeEnum;
      }
    }
    return null;
  }

  static bool isValid(String value) {
    for (var course in CourseType.values) {
      if (course.text == value) {
        return true;
      }
    }
    return false;
  }
}
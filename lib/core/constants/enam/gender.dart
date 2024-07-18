

enum Gender {
  male,
  female
}

enum LanguageCode {
  AR('ar'),
  EN('en');


  final String code;
  const LanguageCode(this.code);
}

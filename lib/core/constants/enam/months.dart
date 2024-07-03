enum Months {
  january(monthArabic: "يناير", monthEnglish: "January"),
  february(monthArabic: "فبراير", monthEnglish: "February"),
  march(monthArabic: "مارس", monthEnglish: "March"),
  april(monthArabic: "إبريل", monthEnglish: "April"),
  may(monthArabic: "مايو", monthEnglish: "May"),
  june(monthArabic: "يونيو", monthEnglish: "June"),
  july(monthArabic: "يوليو", monthEnglish: "July"),
  august(monthArabic: "أغسطس", monthEnglish: "August"),
  september(monthArabic: "سبتمبر", monthEnglish: "September"),
  october(monthArabic: "أكتوبر", monthEnglish: "October"),
  november(monthArabic: "نوفمبر", monthEnglish: "November"),
  december(monthArabic: "ديسمبر", monthEnglish: "December");

  const Months({required this.monthArabic, required this.monthEnglish});
  final String monthArabic;
  final String monthEnglish;
}

extension MonthsX on int {
  String monthName(String language) {
    if (language == "ar") {
      return switch (this) {
        1 => Months.january.monthArabic,
        2 => Months.february.monthArabic,
        3 => Months.march.monthArabic,
        4 => Months.april.monthArabic,
        5 => Months.may.monthArabic,
        6 => Months.june.monthArabic,
        7 => Months.july.monthArabic,
        8 => Months.august.monthArabic,
        9 => Months.september.monthArabic,
        10 => Months.october.monthArabic,
        11 => Months.november.monthArabic,
        _ => Months.december.monthArabic,
      };
    } else {
      return switch (this) {
        1 => Months.january.monthEnglish,
        2 => Months.february.monthEnglish,
        3 => Months.march.monthEnglish,
        4 => Months.april.monthEnglish,
        5 => Months.may.monthEnglish,
        6 => Months.june.monthEnglish,
        7 => Months.july.monthEnglish,
        8 => Months.august.monthEnglish,
        9 => Months.september.monthEnglish,
        10 => Months.october.monthEnglish,
        11 => Months.november.monthEnglish,
        _ => Months.december.monthEnglish
      };
    }
  }
}

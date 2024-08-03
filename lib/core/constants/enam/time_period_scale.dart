
enum TimePeriodScale  {
  Daily("Daily"),
  Month("Month"),
  MonthForMultiYear("Month for multi year"),
  Year("Year");

  final String text;
  const TimePeriodScale(this.text);

  static List<String?> getStringValues() {
    return  TimePeriodScale.values.map((item) => item.text).toList();
  }
}
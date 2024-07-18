import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late final SharedPreferences sharedPreferences;
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static void setString(String key, String value) =>
      sharedPreferences.setString(key, value);

  static void setInt(String key, int value) =>
      sharedPreferences.setInt(key, value);
  static void setBool(String key, bool value)  =>
      sharedPreferences.setBool(key, value);


  static String? getString(String key) => sharedPreferences.getString(key);
  static int? getInt(String key) => sharedPreferences.getInt(key);
  static bool? getBool(String key) =>  sharedPreferences.getBool(key);

  static Future<bool> removeAt(String key) => sharedPreferences.remove(key);
  static Future<bool> clearAll() => sharedPreferences.clear();
}

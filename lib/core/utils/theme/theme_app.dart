import 'package:flutter/material.dart';
import '../../../helpers/cache_helper.dart';
import 'package:get/get.dart';
import '../../constants/cached/cached_name.dart';
import 'color_app.dart';
import 'font_manager.dart';

const Color kprimeryColor = AppColors.mainOneColor;
const TextStyle textStyleSecondary = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: FontFamilyNames.tajawalRFont,
    color: AppColors.grayTwoColor);
const TextStyle textStylePrimery = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w700,
  fontFamily: FontFamilyNames.tajawalRFont,
  color: Colors.black,
);

class Themes {
  static ThemeData themeArabic = ThemeData(
      primarySwatch: AppColors.primaryMaterialColor,
      brightness: Brightness.light,
      primaryColor: kprimeryColor,
      useMaterial3: false,
      textTheme: const TextTheme(
        labelLarge: TextStyle(fontFamily: FontFamilyNames.tajawalRFont),
        labelMedium: TextStyle(fontFamily: FontFamilyNames.tajawalBFont),
      ));
  static ThemeData themeEnglish = ThemeData(
      primarySwatch: AppColors.primaryMaterialColor,
      brightness: Brightness.light,
      useMaterial3: false,
      primaryColor: kprimeryColor,
      textTheme: const TextTheme(
        labelLarge: TextStyle(fontFamily: FontFamilyNames.poppinsFont),
        labelMedium: TextStyle(fontFamily: FontFamilyNames.poppinsFont),
      ));
}

extension FontFamilyX on String {
  String typeFontFamily() {
    if (CacheHelper.getString(LANGUAGE_TYPE_CACHED) != null) {
      switch (CacheHelper.getString(LANGUAGE_TYPE_CACHED)) {
        case 'ar':
          return this;
        default:
          return "";
      }
    } else {
      switch (Get.deviceLocale!.languageCode) {
        case 'ar':
          return this;
        default:
          return "";
      }
    }
  }
}

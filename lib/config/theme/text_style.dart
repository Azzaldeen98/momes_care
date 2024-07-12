import 'package:flutter/material.dart';
import 'package:moms_care/config/theme/theme_preference.dart';
import 'app_color.dart';
import 'color_app.dart';
import 'font_manager.dart';




mixin AppTextStyles {



  static TextStyle getBasicStyle(
      {double fontSize = FontSizeManager.s14,
        FontWeight fontWeight = FontWeightManager.regular,
        Color color = AppColor.primaryTextColor}) {
    Color _color=color;
    return TextStyle(
      fontFamily: FontFamilyNames.shamelBook,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: _color,
    );
  }



  static TextStyle getLabelStyle(
      {double fontSize = FontSizeManager.s14,
        FontWeight fontWeight = FontWeightManager.regular,
        Color color = AppColor.primaryTextColor}) {
    return TextStyle(
      fontFamily: FontFamilyNames.shamelBook,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle getButtonTextStyle(
      {double fontSize = FontSizeManager.s16,
        FontWeight fontWeight = FontWeightManager.semiBold,
        Color color = AppColor.buttonTextPrimaryColor}) {
    return getBasicStyle(fontSize: fontSize,fontWeight: fontWeight,color:color);
  }

  static TextStyle getErrorStyle(
      {double fontSize = FontSizeManager.s12,
        FontWeight fontWeight = FontWeightManager.regular,
        Color color = AppColor.inputFieldErrorText}) {
    return getBasicStyle(fontSize: fontSize,fontWeight: fontWeight,color:color);
  }
  //* ShamelBook
  static TextStyle getShamelBookStyle(
      {double fontSize = FontSizeManager.s14,
      FontWeight fontWeight = FontWeightManager.regular,
      Color color = AppColors.grayOneColor})  {
    () async{
      final isDarkMode = await ThemePreferences.getThemeMode();
    };

    return TextStyle(
      fontFamily: FontFamilyNames.shamelBook,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  //* ShamelBold
  static TextStyle getShamelBoldStyle(
      {double fontSize = FontSizeManager.s14,
      FontWeight fontWeight = FontWeightManager.regular,
      Color color = AppColors.grayOneColor}) {
    return TextStyle(
      fontFamily: FontFamilyNames.shamelBold,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  //* UltraLight
  static TextStyle getUltraLightStyle(
      {double fontSize = FontSizeManager.s14,
      FontWeight fontWeight = FontWeightManager.regular,
      Color color = AppColors.grayOneColor}) {
    return TextStyle(
      fontFamily: FontFamilyNames.dINNextLTArabicUltraLight,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

//* regular
  static TextStyle getRegularStyle(
      {double fontSize = FontSizeManager.s14,
      FontWeight fontWeight = FontWeightManager.regular,
      Color color = AppColors.grayOneColor}) {
    return TextStyle(
      fontFamily: FontFamilyNames.dINNextLTArabicRegular,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

//* medium
  static TextStyle getMediumStyle(
      {double fontSize = FontSizeManager.s14,
      FontWeight fontWeight = FontWeightManager.regular,
      Color color = AppColors.grayOneColor}) {
    return TextStyle(
      fontFamily: FontFamilyNames.dINNextLTArabicMedium,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle getTitleStyle(
      {double fontSize = FontSizeManager.s20,
        FontWeight fontWeight = FontWeightManager.regular,
        Color color = AppColor.primaryTextColor}) {
    return getBoldStyle(fontSize:  fontSize,fontWeight: fontWeight,color: color);
  }

  static TextStyle getTextPrimaryStyle(
      {double fontSize = FontSizeManager.s18,
        FontWeight fontWeight = FontWeightManager.bold,
        Color color = AppColor.buttonTextPrimaryColor}) {
    return getBoldStyle(fontSize: fontSize,fontWeight: fontWeight,color: color);
  }

//* Bold
  static TextStyle getBoldStyle(
      {double fontSize = FontSizeManager.s14,
      FontWeight fontWeight = FontWeightManager.bold,
      Color color = AppColors.grayOneColor,
      TextDecoration decoration= TextDecoration.none}) {
    return TextStyle(
      fontFamily: FontFamilyNames.dINNextLTArabicBold,
      fontWeight: fontWeight,
      fontSize: fontSize,
      decoration: decoration,
      color: color,
    );
  }

  // static TextStyle getBoldStyle()=>getBoldStyle(fontSize: FontSizeManager())
}

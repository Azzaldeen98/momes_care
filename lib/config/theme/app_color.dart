import 'package:flutter/material.dart';
import 'package:moms_care/config/theme/color_app.dart';

class AppBaseColor{
  static const Color black= Color(0xFF000000);
  static const Color white= Color(0xFFFFFFFF);
  static const Color red= Color(0xFFFF0000);
  static const  Color baseColor=Color(0xFFDA4849);
}
class AppColor {

  static const Color errorColor = Color(0xFFF30303);
  static const Color whiteColor = Color(0xFFFFFFFF);

  /// Light
  static const primaryColor =Color(0xFFDA4849);
  static const primaryColor2 =Color(0xFAD3595A);
  static const secondColor =Color(0xFFFCC6C6);
  static const scaffoldBackgroundColor = Color(0xFFFCC6C6);
  static const Color primaryTextColor = AppBaseColor.white;
  static const Color secondaryTextColor = AppBaseColor.black;
  static const Color secondaryIconColor = AppBaseColor.black;
  static const Color primaryIconColor = AppBaseColor.white;

  /// Dark
  static const primaryDarkColor =Color(0xFF050505);
  static const secondDarkColor =Color(0xFF2C2B2B);
  static const scaffoldBackgroundDarkColor =Color(0xFF2C2B2B);
  static const Color primaryTextDarkColor = AppBaseColor.white;
  static const Color primaryIconDarkColor = AppBaseColor.white;
  // Color.fromRGBO(243, 3, 3, 1.0);
  // AppColors.deepPurple ;

  static const primaryLinearGradientColor = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.topRight,
      colors: [AppBaseColor.white, Colors.red,],
      stops: [0,1],
  );
  static const onPrimaryColor = primaryColor;
  static const onSecondaryColor = Color.fromRGBO(
      82, 155, 250, 0.5);
  /// Basic Buttons  Colors
  static const Color buttonPrimaryColor = AppBaseColor.baseColor;
  static const Color buttonSecondaryColor = AppColors.redOneColor;
  /// Buttons Icon - Colors
  static const Color buttonIconColor = primaryColor;
  /// Buttons Text - Colors
  static const Color buttonTextColor = primaryColor;
  /// Buttons Text Links - Colors
  static const Color buttonLinkColor = Colors.blue;
  static const Color buttonTextPrimaryColor = AppBaseColor.white;

  /// Basic Text - Colors

  static const Color basicTextLight = AppBaseColor.black;


  /// input Field  - Colors
  static const Color inputFieldBg2 = Color(0xFAD3595A);
  static const Color inputFieldBg1 = Colors.white;
  static const Color inputFieldBg = Color(0x24858282);

  static const Color inputFieldText =  AppBaseColor.black;
  static const Color inputFieldErrorText = Color(0xFFF30303);



  ///  background opacity
    static const Color  cancelButton = Color.fromRGBO(
        200, 228, 255, 0.792156862745098);
    static const Color  cancelButtonText= AppBaseColor.white;
    static const Color primaryOpacityBgLight = Color.fromRGBO(103, 58, 183, .1);

    static const Color backgroundLight = AppBaseColor.white;
  static const Color backgroundCard = Color(0x42858282);

}

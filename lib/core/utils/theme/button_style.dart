import 'package:flutter/material.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/color_app.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import 'color_app.dart';
import 'font_manager.dart';

mixin AppButtonStyles {

  static ButtonStyle getBasicButtonStyle(
      {double fontSize = FontSizeManager.s14,
      FontWeight fontWeight = FontWeightManager.regular,
      Color bgColor = AppColor.buttonPrimaryColor,
      Color iconColor = AppColor.buttonPrimaryColor,
        TextStyle? textStyle  ,
      }) {
    return TextButton.styleFrom(
        backgroundColor: bgColor,
        iconColor:iconColor,
        textStyle: textStyle??AppTextStyles.getBasicStyle());

  }



}

import 'package:flutter/material.dart';

import '../theme/color_app.dart';
import '../theme/text_style.dart';

abstract class BorderTextFiled {
  static const UnderlineInputBorder underlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.mainOneColor, width: 1));

  static const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: AppColors.mainOneColor, width: 1));

  static InputBorder enabledBorder(bool outline, double radius) {
    return outline
        ? outlineInputBorder.copyWith(
            borderSide: const BorderSide(
                color: Color.fromRGBO(148, 148, 150, 0.5), width: 1),
            borderRadius: BorderRadius.circular(radius))
        : underlineInputBorder;
  }

  static InputBorder focusedBorder(bool outline, double radius) {
    return outline
        ? outlineInputBorder.copyWith(
            borderRadius: BorderRadius.circular(radius))
        : underlineInputBorder;
  }

  static InputBorder border(bool outline, double radius) {
    return outline
        ? outlineInputBorder.copyWith(
            borderRadius: BorderRadius.circular(radius))
        : underlineInputBorder;
  }

  static InputBorder errorBorder(bool outline, double radius) {
    return outline
        ? outlineInputBorder.copyWith(
            borderSide:
                const BorderSide(color: AppColors.redOneColor, width: 1),
            borderRadius: BorderRadius.circular(radius))
        : underlineInputBorder.copyWith(
            borderSide:
                const BorderSide(color: AppColors.redThreeColor, width: 1),
            borderRadius: BorderRadius.circular(radius));
  }

  static TextStyle get errorStyle {
    return AppTextStyles.getRegularStyle(
      color: Colors.redAccent,
      fontSize: 10,
    );
  }
}

import 'package:flutter/material.dart';

import '../../utils/theme/color_app.dart';
import '../../utils/theme/font_manager.dart';

class TextStarWidget extends StatelessWidget {
  const TextStarWidget(
      {super.key,
      required this.text,
      this.fontSize = 15,
      this.showStar = true,
      this.fontWeight = FontWeight.w700,
      this.color = Colors.black});
  final String text;
  final double fontSize;
  final bool showStar;
  final FontWeight fontWeight;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: FontFamilyNames.dINNextLTArabicMedium,
          color: color,
        ),
        // textStyleSecondary.copyWith(fontSize: fontSize),
        children: [
          TextSpan(text: text),
          if (showStar)
            const TextSpan(
                text: "*",
                style: TextStyle(
                    fontFamily: FontFamilyNames.cairoFont,
                    color: AppColors.redOneColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 24)),
        ]));
  }
}

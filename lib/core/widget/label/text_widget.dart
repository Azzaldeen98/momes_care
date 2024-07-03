import 'package:flutter/material.dart';
import '../../utils/theme/color_app.dart';
import '../../utils/theme/font_manager.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(this.text,
      {super.key,
      this.fontSize = 14,
      this.fontWeight = FontWeight.w400,
      this.titleCenter = true,
      this.maxLines = 1,
      this.color = AppColors.grayOneColor,
      this.textAlign});
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final bool titleCenter;
  final Color color;
  final int? maxLines;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      textAlign:
          textAlign ?? (titleCenter ? TextAlign.center : TextAlign.start),
      maxLines: maxLines,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: FontFamilyNames.dINNextLTArabicRegular,
          color: color),
    );
  }
}

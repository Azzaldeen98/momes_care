import 'package:flutter/material.dart';
import '../../utils/theme/color_app.dart';
import '../../utils/theme/font_manager.dart';

class TextNewPriceWidget extends StatelessWidget {
  const TextNewPriceWidget(
      {super.key,
      required this.newPrice,
      this.fontSize = 14,
      this.titleCenter = true,
      this.fontWeight = FontWeight.w400});
  final bool titleCenter;
  final String newPrice;
  final double fontSize;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      newPrice,
      overflow: TextOverflow.ellipsis,
      textAlign: titleCenter ? TextAlign.center : TextAlign.start,
      maxLines: 1,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: FontFamilyNames.dINNextLTArabicBold,
          color: AppColors.secondaryOneColor),
    );
  }
}

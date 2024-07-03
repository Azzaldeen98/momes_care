import 'package:responsive_builder/responsive_builder.dart';

import '../../utils/theme/color_app.dart';
import 'package:flutter/material.dart';
import '../../utils/theme/font_manager.dart';
import '../../utils/theme/theme_app.dart';

class ButtonGrWidget extends StatelessWidget {
  const ButtonGrWidget({
    Key? key,
    required this.onTap,
    required this.text,
    this.color,
    this.radius = 18,
  }) : super(key: key);

  final VoidCallback onTap;
  final String text;
  final Color? color;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: AppGradientColors.mainGradien,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: color == null ? AppGradientColors.mainGradien : null,
                color: color,
                borderRadius: BorderRadius.circular(radius)),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: getValueForScreenType<double>(
                  context: context, mobile: 56, tablet: 66),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getValueForScreenType<double>(
                      context: context, mobile: 16, tablet: 20),
                  fontFamily: FontFamilyNames.dINNextLTArabicMedium,
                ),
              ),
            ),
          ),
        ));
  }
}

class ButtonGrIconWidget extends StatelessWidget {
  const ButtonGrIconWidget(
      {super.key,
      this.text,
      required this.onTap,
      required this.icon,
      this.fontSize = 12,
      this.revers = false,
      this.radius = 20,
      this.color});
  final String? text;
  final VoidCallback onTap;
  final double fontSize;
  final double radius;
  final IconData icon;
  final bool revers;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: AppGradientColors.mainGradien,
          borderRadius: BorderRadius.circular(18),
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)),
          ),
          child: DecoratedBox(
              decoration: BoxDecoration(
                  gradient:
                      color == null ? AppGradientColors.mainGradien : null,
                  color: color,
                  borderRadius: BorderRadius.circular(radius)),
              child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: getValueForScreenType<double>(
                      context: context, mobile: 56, tablet: 66),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (revers) ...{
                        if (text != null) ...[
                          _textWidget(),
                          const SizedBox(width: 10),
                        ],
                        _iconWidget(),
                      } else ...{
                        _iconWidget(),
                        if (text != null) ...[
                          const SizedBox(width: 10),
                          _textWidget()
                        ],
                      }
                    ],
                  ))),
        ));
  }

  Widget _iconWidget() {
    return Icon(icon, color: Colors.white);
  }

  Widget _textWidget() {
    return Text(
      text ?? "",
      textAlign: TextAlign.center,
      style: textStyleSecondary.copyWith(
          fontFamily: FontFamilyNames.cairoFont,
          fontSize: fontSize,
          color: Colors.white),
    );
  }
}

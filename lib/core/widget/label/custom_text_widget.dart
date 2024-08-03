import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import '../../utils/theme/color_app.dart';
import '../../utils/theme/font_manager.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget(this.text,
      {super.key,
      this.maxLines = 1,
      this.textStyle,
      this.border,
      this.color = AppColors.grayOneColor,
      this.textAlign});
  final String text;
  final Border? border;
  final Color color;
  final int? maxLines;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: border ?? null
          ),
              padding: const EdgeInsets.symmetric(vertical:15,horizontal: 10),
              child:Text(text,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  textAlign:textAlign ?? TextAlign.justify,
                  maxLines: maxLines,
                  style: textStyle ?? AppTextStyles.getTitleStyle(color: AppColor.titleTextColor,
                      fontSize: 18),
        ),
          ),
      );
  }
}

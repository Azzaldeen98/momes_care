

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/color_app.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import '../../utils/style/border_text_filed.dart';
import '../label/text_widget.dart';

class TextFieldWidget extends StatelessWidget {


  const TextFieldWidget({
    Key? key,
    required this.name,
    required this.multiLines,
    required this.controller,
    this.password = false,
    this.outline = true,
    this.textInputType = TextInputType.number,
    this.hintText,
    this.validator,
    this.radius = 12,
    this.padding = 20,
    this.showStar = true,
    this.readOnly = false,
    this.maxLength = 1000,
  }) : super(key: key);
  final String name;
  final String? hintText;
  final bool multiLines;
  final bool outline;
  final bool password;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool showStar;
  final TextEditingController controller;
  final double radius;
  final double padding;
  final bool readOnly;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: multiLines ? null : 56,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 0),
      child: TextFormField(
        controller: controller,
        maxLines: multiLines ? 6 : 1,
        minLines: multiLines ? 3 : 1,
        obscureText: password,
        keyboardType: textInputType,
        validator: validator,
        readOnly: readOnly,
        style: AppTextStyles.getRegularStyle(),

        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          label: TextWidget(name, fontSize: 14, color: AppColor.primaryDarkColor),
          errorStyle: BorderTextFiled.errorStyle,
          labelStyle: AppTextStyles.getRegularStyle(),
          // labelText: ,
          hintText: hintText??"",
          enabledBorder: BorderTextFiled.enabledBorder(outline, radius),
          focusedBorder: BorderTextFiled.focusedBorder(outline, radius),
          border: BorderTextFiled.border(outline, radius),
          errorBorder: BorderTextFiled.errorBorder(outline, radius),
        ),
      ),
    );
  }
}

import '../../utils/theme/text_style.dart';

import '../../utils/style/border_text_filed.dart';
import '../../utils/theme/color_app.dart';
import 'package:flutter/material.dart';
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
    this.validator,
    this.radius = 12,
    this.padding = 20,
    this.showStar = true,
    this.readOnly = false,
  }) : super(key: key);
  final String name;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: multiLines ? null : 56,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 0),
      child: TextFormField(
        controller: controller,
        maxLines: multiLines ? 3 : 1,
        minLines: multiLines ? 3 : 1,
        obscureText: password,
        keyboardType: textInputType,
        validator: validator,
        readOnly: readOnly,
        style: AppTextStyles.getRegularStyle(),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          label: TextWidget(name, fontSize: 14, color: AppColors.grayTwoColor),
          errorStyle: BorderTextFiled.errorStyle,
          labelStyle: AppTextStyles.getRegularStyle(),
          enabledBorder: BorderTextFiled.enabledBorder(outline, radius),
          focusedBorder: BorderTextFiled.focusedBorder(outline, radius),
          border: BorderTextFiled.border(outline, radius),
          errorBorder: BorderTextFiled.errorBorder(outline, radius),
        ),
      ),
    );
  }
}

import '../../utils/theme/images.dart';
import 'package:flutter/material.dart';
import '../../utils/style/border_text_filed.dart';
import '../../utils/theme/text_style.dart';
import 'package:intl/intl.dart';
import '../../utils/theme/color_app.dart';
import '../label/text_widget.dart';

class DatePickerFieldWidget extends StatelessWidget {
  const DatePickerFieldWidget({
    super.key,
    required this.name,
    this.outline = true,
    this.validator,
    required this.controller,
    this.radius = 20,
    this.padding = 20,
  });
  final String name;
  final bool outline;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final double radius;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        readOnly: true,
        style: AppTextStyles.getRegularStyle(),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          suffix: Image.asset(AppImage.CALENDER_GREY, height: 15),
          label: TextWidget(name, fontSize: 14, color: AppColors.grayTwoColor),
          errorStyle: BorderTextFiled.errorStyle,
          labelStyle: AppTextStyles.getRegularStyle(),
          enabledBorder: BorderTextFiled.enabledBorder(outline, radius),
          focusedBorder: BorderTextFiled.focusedBorder(outline, radius),
          border: BorderTextFiled.border(outline, radius),
          errorBorder: BorderTextFiled.errorBorder(outline, radius),
        ),
        onTap: () => _onChoseDateTime(context, controller.text),
      ),
    );
  }

  void _onChoseDateTime(BuildContext context, String date) async {
    DateTime dateTime = DateTime.tryParse(date) ?? DateTime.now();
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      controller.text = formattedDate;
    } else {}
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../utils/style/border_text_filed.dart';
import '../../utils/theme/color_app.dart';
import '../../utils/theme/text_style.dart';
import '../label/text_widget.dart';

class TextFieldSearchWidget extends StatelessWidget {
  const TextFieldSearchWidget(
      {super.key,
      required this.lable,
      required this.searchController,
      this.onChange,
      this.keyboardType});
  final String lable;
  final TextEditingController searchController;
  final VoidCallback? onChange;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              cursorColor: AppColors.mainOneColor,
              keyboardType: keyboardType,
              // validator: validator,
              style: AppTextStyles.getRegularStyle(),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                label: TextWidget(lable,
                    fontSize: 14, color: AppColors.grayTwoColor),
                errorStyle: BorderTextFiled.errorStyle,
                labelStyle: AppTextStyles.getRegularStyle(),
                enabledBorder: BorderTextFiled.enabledBorder(true, 8),
                focusedBorder: BorderTextFiled.focusedBorder(true, 8),
                border: BorderTextFiled.border(true, 8),
                errorBorder: BorderTextFiled.errorBorder(true, 8),
              ),
            ),
          ),
          const SizedBox(width: 5),
          SizedBox(
              width: 60,
              height: 50,
              child: _ButtonGrIconWidget(
                onTap: onChange ?? () {},
                color: Colors.black,
                icon: IconlyLight.search,
                radius: 8,
              )),
        ],
      ),
    );
  }
}

class _ButtonGrIconWidget extends StatelessWidget {
  const _ButtonGrIconWidget(
      {required this.onTap, required this.icon, this.radius = 20, this.color});

  final VoidCallback onTap;
  final double radius;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
                gradient: null,
                color: color,
                borderRadius: BorderRadius.circular(radius)),
            child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: getValueForScreenType<double>(
                    context: context, mobile: 56, tablet: 66),
                child: Icon(icon, color: Colors.white))));
  }
}

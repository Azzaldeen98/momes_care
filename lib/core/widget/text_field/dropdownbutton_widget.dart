import 'package:flutter/material.dart';
import '../../utils/theme/color_app.dart';
import '../../utils/theme/images.dart';
import '../../utils/style/border_text_filed.dart';
import '../label/text_widget.dart';

class DropDownButtonWidget<T> extends StatelessWidget {
  const DropDownButtonWidget({
    Key? key,
    required this.name,
    this.items,
    this.values,
    this.value,
    this.radius = 20,
    this.padding = 20,
    this.validator,
    this.onChange,
    this.outline = true,
    this.iconSize = 28,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
  }) : super(key: key);
  final String name;
  final List? items;
  final List<T>? values;
  final T? value;
  final bool outline;
  final double radius;
  final double padding;
  final double iconSize;
  final EdgeInsetsGeometry contentPadding;
  final void Function(dynamic)? onChange;
  final String? Function(dynamic)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 0),
      child: DropdownButtonFormField(
        items: _getDropdownMenuItems(),
        value: value,
        icon: Image.asset(AppImage.ARROW_DOWN_P),
        iconSize: iconSize,
        borderRadius: BorderRadius.circular(20),
        menuMaxHeight: 300,
        onChanged: onChange,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          label: TextWidget(name, fontSize: 14, color: AppColors.grayTwoColor),
          errorStyle: BorderTextFiled.errorStyle,
          enabledBorder: BorderTextFiled.enabledBorder(outline, radius),
          focusedBorder: BorderTextFiled.focusedBorder(outline, radius),
          border: BorderTextFiled.border(outline, radius),
          errorBorder: BorderTextFiled.errorBorder(outline, radius),
        ),
      ),
    );
  }

  List<DropdownMenuItem<T>>? _getDropdownMenuItems() {
    return items == null
        ? null
        : [
            for (int i = 0; i < items!.length; i++)
              DropdownMenuItem(
                value: values![i],
                child: TextWidget(items![i].toString()),
              )
          ];
  }
}

import '../../utils/theme/color_app.dart';
import 'package:flutter/material.dart';
import '../../utils/theme/text_style.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
      required this.onTap,
      required this.nameButton,
      this.colorInversion = false,
      this.height = 45})
      : super(key: key);
  final double height;
  final VoidCallback onTap;
  final String nameButton;
  final bool colorInversion;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: height,
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                colorInversion ? Colors.white : AppColors.mainOneColor,
            foregroundColor:
                colorInversion ? AppColors.mainOneColor : Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side:
                    const BorderSide(color: AppColors.mainOneColor, width: 1)),
          ),
          child: Text(
            nameButton,
            style: AppTextStyles.getShamelBookStyle(),
          ),
        ));
  }
}

class ButtonIconWidget extends StatelessWidget {
  const ButtonIconWidget(
      {Key? key,
      required this.onTap,
      required this.iconButton,
      this.colorInversion = false,
      this.height = 45})
      : super(key: key);
  final double height;
  final VoidCallback onTap;
  final IconData iconButton;
  final bool colorInversion;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: height,
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                colorInversion ? Colors.white : AppColors.mainOneColor,
            foregroundColor:
                colorInversion ? AppColors.mainOneColor : Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side:
                    const BorderSide(color: AppColors.mainOneColor, width: 1)),
          ),
          child: Icon(iconButton),
        ));
  }
}

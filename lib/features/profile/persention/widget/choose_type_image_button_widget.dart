import 'package:flutter/material.dart';

import 'package:moms_care/core/utils/theme/color_app.dart';
import 'package:moms_care/core/widget/label/text_widget.dart';

class ChooseTypeImageButtomWiget extends StatelessWidget {
  const ChooseTypeImageButtomWiget({
    super.key,
    required this.onTap,
    required this.icon,
    required this.name,
  });
  final IconData icon;
  final VoidCallback onTap;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            elevation: 2,
            backgroundColor: Colors.grey.shade100,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.mainOneColor),
              const SizedBox(width: 14),
              TextWidget(
                name,
                fontSize: 16,
                color: AppColors.grayTwoColor,
                fontWeight: FontWeight.bold,
                // style: const TextStyle(fontSize: 18, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}

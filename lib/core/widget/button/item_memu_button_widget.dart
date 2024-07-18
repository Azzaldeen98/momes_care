


import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';

import '../../utils/theme/images.dart';
class ItemMenuButtonWidget extends StatelessWidget {


  const ItemMenuButtonWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var tPrimaryColor=AppColor.primaryLightIconColor;
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var tAccentColor=AppColor.primaryLightIconColor;
    var iconColor = isDark ? tPrimaryColor : tAccentColor;

    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      child: ListTile(
        onTap: onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: iconColor.withOpacity(0.1),
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title, style: Theme.of(context).textTheme.bodyMedium?.apply(color: textColor)),
        trailing: endIcon? Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.withOpacity(0.1),
            ),
            child: const Icon(LineAwesomeIcons.angle_right_solid, size: 18.0, color: Colors.grey)) : null,
      ),
    );
  }
}

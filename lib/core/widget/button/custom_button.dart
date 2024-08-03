

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/helpers/cache_helper.dart';
import '../../utils/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';



class CustomButton extends StatelessWidget {

  final String? labelText;
  final Icon? icon;
  final Function()? onPressed;
  final Color? bgColor;
  final double? widthPercent,height;
  final double raduis;
  final TextStyle? textStyle;
  final Border? border;


  CustomButton({super.key,
    required this.labelText,
    required this.icon,
    required this.onPressed,
    this.bgColor=Colors.transparent,
    this.raduis=12,
    this.textStyle,
    this.border,
    this.widthPercent,
    this.height,
  });

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    final buttonWidth = widthPercent==null? null : screenSize.width * widthPercent! / 100;

    return  Container(
      width:buttonWidth,
      height: height,
      // alignment: Alignment.center,
      // margin: EdgeInsets.only(right: 20,left:50),
      // padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(color:bgColor,
      border: border ?? null,
      borderRadius: BorderRadius.circular(raduis)),
      child: FloatingActionButton.extended(
        onPressed:onPressed!,
        heroTag: labelText!,
        backgroundColor: this.bgColor,
        elevation: 0,
        label:  Text( labelText!,style:this.textStyle!=null? this.textStyle: AppTextStyles.getButtonTextStyle()),
        icon: (icon!=null)?icon!: Icon(null!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),/*side: BorderSide(width:0,color: Colors.brown),*/ ),
      ),
    );
  }

}
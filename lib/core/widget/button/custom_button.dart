

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../helpers/cache_helper.dart';
import '../../../config/theme/app_color.dart';
import '../../../config/theme/text_style.dart';



class CustomButton extends StatelessWidget {

  final String? labelText;
  final Icon? icon;
  final Function()? onPressed;
  final Color? bgColor;
  final double widthPercent;
  final double raduis;
  final TextStyle? textStyle;


  CustomButton({super.key,
    required this.labelText,
    required this.icon,
    required this.onPressed,
    this.bgColor=AppColor.primaryColor,
    this.raduis=12,
    this.textStyle,
    this.widthPercent=double.maxFinite,});

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    final buttonWidth = screenSize.width * widthPercent / 100;

    return  Container(
      width:buttonWidth,
      // alignment: Alignment.center,
      // margin: EdgeInsets.only(right: 20,left:50),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(color:this.bgColor,
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
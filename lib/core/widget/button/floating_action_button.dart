import 'package:flutter/material.dart';
import 'package:moms_care/config/theme/app_color.dart';

class FloatingActionButtonWidget extends StatelessWidget{
  final Function() onPressed;
    final IconData icon;
    final Color? bgColor,iconColor;
    final bool isView;
    final double? top,left,bottom,right;

 const FloatingActionButtonWidget({
      required this.onPressed,
      required this.icon,
      this.bgColor=AppColor.primaryDarkColor,
      this.iconColor=AppColor.primaryIconColor,
      this.top,
      this.left,
      this.bottom,
      this.right,
      this.isView=true
 });


  @override
  Widget build(BuildContext context) {
   return (!isView)? const SizedBox() : Positioned(
       top: top, left: left, bottom: bottom, right: right,
       child: FloatingActionButton(
           onPressed:onPressed,
           backgroundColor: bgColor,
           child:  Icon(icon!,color: iconColor,),
    ));
  }

}

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/config/theme/app_color.dart';

class BackButtonWidget extends StatelessWidget {

  BackButtonWidget({required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
      return Row(
        children: [
        const  SizedBox(width: 30,),
          IconButton(
              onPressed:onPressed,
               icon: Icon(Icons.arrow_forward,color:AppColor.primaryIconColor,)
          ),
        ],
      );
  }}
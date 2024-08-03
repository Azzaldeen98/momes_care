

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/font_manager.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';

Widget buildBackButtonWidget({Function()? onPressed,double? width=30}){
  return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 20,),
      CustomButton(
        widthPercent: width ??90,
        raduis: 10,
        labelText:"Back".tr,
        icon: Icon(Icons.arrow_back_ios_new,color: AppColor.secondaryIconColor,) ,
        bgColor:Colors.transparent,// AppColor.opacitybgCololr,
        // border: Border.all(color: AppColor.opacitybgCololr ),
        textStyle: AppTextStyles.getBoldStyle(color: Colors.black26,
            fontSize:FontSizeManager.s18),
        onPressed:onPressed,
      ),
      Divider()
    ],
  );
}
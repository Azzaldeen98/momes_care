import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/features/auth/persention/page/auth_view.dart';

import '../../../../config/theme/font_manager.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/theme/images.dart';
import '../../../../core/widget/button/button_gr_widget.dart';
import '../../../../core/widget/button/custom_button.dart';

class ThridPageView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Container(
        color: AppColor.whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Third Page View",style: AppTextStyles.getBoldStyle(fontSize: FontSizeManager.s28,)),
            SizedBox(height: 30,),
            Image.asset(TypeImage.WALK_THEME_IMG1, height: 250),
            SizedBox(height: 50,),


            CustomButton(
                widthPercent: 80,
                raduis: 10,
                labelText:"Start".tr,
                icon: Icon(Icons.start,color: AppColor.primaryIconColor,) ,
                bgColor: AppColor.PrimaryButtonLightColor,
              onPressed: (){
                  Get.offAll(AuthView());
              },),

             // TextButton.icon(onPressed: (){}, label: Text("Start".tr),
             //  icon: Icon(Icons.start),)
          ],
        )
      // child: SizedBox(
      //   height: 200,
      //   width: 300,
      //   child: Container(
      //     padding: EdgeInsets.all(10),
      //     decoration: BoxDecoration(
      //       color: Colors.green,
      //         borderRadius: BorderRadius.circular(10),
      //     border: Border.all(width: 3,style: BorderStyle.solid,color: Colors.white)),
      //
      //   ),
      // ),
    );
  }

}
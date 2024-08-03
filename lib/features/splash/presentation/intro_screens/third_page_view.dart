import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/features/auth/persention/page/auth_view.dart';

import 'package:moms_care/core/utils/theme/font_manager.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/widget/button/button_gr_widget.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';

class ThridPageView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Container(
        color: AppColor.whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("About2".tr,style: AppTextStyles.getBasicStyle(fontSize: FontSizeManager.s20,)),
            SizedBox(height: 20,),
            SizedBox(
              width: 250,
              height: 250,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(width: 0),
                  borderRadius: BorderRadius.circular(20),),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:  Image.asset(AppImage.SPLASH3_IMG, height: 250,width: 250,)),
              ),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(30),
            //         // right: Radius.circular(20),
            //         // left: Radius.circular(20))
            //   ),
            //     child: Image.asset(AppImage.SPLASH3_IMG, height: 250,width: 250,)),
            SizedBox(height: 40,),
            CustomButton(
                widthPercent: 80,
                raduis: 10,
                labelText:"Start".tr,
                icon: Icon(Icons.start,color: AppColor.primaryIconColor,) ,
                bgColor: AppColor.PrimaryButtonLightColor,
              onPressed: (){
                  Get.offAll(AuthView());
              },),

          ],
        )

    );
  }

}
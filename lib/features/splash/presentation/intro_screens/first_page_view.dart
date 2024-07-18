import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import '../../../../config/theme/color_app.dart';
import '../../../../config/theme/font_manager.dart';
import '../../../../config/theme/text_style.dart';

class FirstPageView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Container(
        color: AppColor.whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   padding: EdgeInsets.all(10),
            //     child: Text("First Page View".tr,
            //         style: AppTextStyles.getBoldStyle(
            //           fontSize: FontSizeManager.s28)),
            //
            // ),
            Image.asset(AppImage.LOGO2, height: 250),
            SizedBox(height: 30,),
            Container(
                padding: EdgeInsets.all(20),
                child: Text("AppDescribe".tr,
                  style: AppTextStyles.getBasicStyle(fontSize: FontSizeManager.s16,)?.copyWith(
                    overflow: TextOverflow.fade,
                  )
                  ,)),


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
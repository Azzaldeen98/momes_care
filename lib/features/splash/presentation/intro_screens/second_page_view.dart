import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/utils/theme/font_manager.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';

import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/images.dart';

class SecondPageView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Container(
        color: AppColor.whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            Image.asset(AppImage.LOGO1, height: 250),
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.all(20),
                child: Text("Aboute App".tr,
                  style: AppTextStyles.getBasicStyle(fontSize: FontSizeManager.s14,)
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
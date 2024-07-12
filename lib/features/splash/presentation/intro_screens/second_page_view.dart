import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/config/theme/font_manager.dart';
import 'package:moms_care/config/theme/text_style.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../core/utils/theme/images.dart';

class SecondPageView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Container(
        color: AppColor.whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Second Page View",style: AppTextStyles.getBoldStyle(fontSize: FontSizeManager.s28,),),
            SizedBox(height: 30,),
            Image.asset(TypeImage.WALK_THEME_IMG1, height: 250),
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
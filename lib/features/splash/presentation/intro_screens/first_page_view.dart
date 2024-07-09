import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/app_color.dart';

import '../../../../config/theme/color_app.dart';
import '../../../../config/theme/font_manager.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/utils/theme/images.dart';

class FirstPageView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
                child: Text("First Page View".tr,
                    style: AppTextStyles.getRegularStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.titleLarge!.color!,
                    )),

            ),
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
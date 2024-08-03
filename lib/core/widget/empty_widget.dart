
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/theme/app_color.dart';
import '../../core/utils/theme/text_style.dart';

class EmptyWidget extends StatelessWidget{

  const EmptyWidget({this.explanatoryText=""});

  final String explanatoryText;

  @override
  Widget build(BuildContext context) {


   return  Center(
            child: Container(
         padding: EdgeInsets.all(20),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Icon(Icons.hourglass_empty,size: 30,),
             SizedBox(height: 30,),
             Text(explanatoryText.isEmpty ?"Empty".tr : explanatoryText,
                 style: AppTextStyles.getTitleStyle(color: AppColor.primaryTextColor),
                 ),
           ],
         ),
         )
       );
  }

}




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';

import '../../../../config/theme/text_style.dart';
import 'package:moms_care/core/utils/theme/images.dart';

class ProfileUserStatisticsWidget extends StatelessWidget{

 const ProfileUserStatisticsWidget({required this.profile});

 final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildItemWidget(name:"Posts".tr,icon:  Icons.post_add, value:profile?.posts??0 ),
        _buildItemWidget(name:"Comments".tr,icon:  Icons.comment, value:profile?.comments??0 ),
        _buildItemWidget(name:"Likes Given".tr,icon:  Icons.favorite , value:profile?.likesGiven??0  ),
        _buildItemWidget(name:"Likes Received".tr,icon:  Icons.favorite , value:profile?.likesReceived??0  ),
      ],
    );
  }
 Widget _buildItemWidget({String? name,IconData? icon,int? value=0}){
   return Container(
     padding:EdgeInsets.all(10) ,
     decoration: BoxDecoration(
         border: Border.all(
             color: const Color.fromARGB(227, 225, 224, 224), width: 1),
         borderRadius: BorderRadius.circular(10)
     ),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Icon(icon),
         SizedBox(height: 5,),
         Text(value!.toString(),style: AppTextStyles.getBoldStyle(fontSize: 20), textAlign: TextAlign.center,),
         SizedBox(height: 5,),
         Text(name!,style: AppTextStyles.getLabelStyle(fontSize:14), textAlign: TextAlign.justify),
       ],
     ),
   );
 }


}
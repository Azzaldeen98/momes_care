


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/core/utils/function/more_options_methods.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/widget/button/change_language_button_widget.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';

import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/widget/button/item_memu_button_widget.dart';
import 'package:moms_care/features/profile/persention/pages/edit_profile_page.dart';

class ProfileSettingsWidget extends StatelessWidget{

 const ProfileSettingsWidget({super.key,  this.profile});

  final Profile? profile;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            const SizedBox(height: 20),
            // ItemMenuButtonWidget(title: "Language".tr , onPress: () {}),
            // const Divider(),
            // ItemMenuButtonWidget(title:"Edit person data".tr, icon:Icons.person_outline ,
            //   onPress:(){
            //   if(profile!=null) {
            //     Get.to(EditProfilePage(profile:profile!));
            //   }},endIcon: true,),
            // const Divider(),
            ItemMenuButtonWidget(title: "LogOut".tr,icon: LineAwesomeIcons.sign_out_alt_solid,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
                  Get.defaultDialog(
                    title: "LogOut".tr,
                    titleStyle: const TextStyle(fontSize: 20),
                    content:  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text("Are you sure, you want to Logout?".tr),
                    ),
                    confirm: Expanded(
                      child: ElevatedButton(
                        onPressed: () => onLogOut(),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, side: BorderSide.none),
                        child:  Text("Yes".tr),
                      ),
                    ),
                    cancel: OutlinedButton(onPressed: () => Get.back(), child:  Text("No".tr)),
                  );
                }),
            const Divider(),
          ],
        ),
      ),
    ) ;

  }



}
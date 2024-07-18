


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';

import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/widget/button/item_memu_button_widget.dart';

class ProfileSettingsWidget extends StatelessWidget{

 const ProfileSettingsWidget({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        height: 500,
        child: Column(
          children: [
            ItemMenuButtonWidget(title: "Settings", icon: LineAwesomeIcons.cog_solid, onPress: () {}),
            ItemMenuButtonWidget(title: "Billing Details", icon: LineAwesomeIcons.wallet_solid, onPress: () {}),
            ItemMenuButtonWidget(title: "User Management", icon: LineAwesomeIcons.user_check_solid, onPress: () {}),
            const Divider(),
            // const SizedBox(height: 10),
            ItemMenuButtonWidget(title: "Information", icon: LineAwesomeIcons.info_solid, onPress: () {}),
            ItemMenuButtonWidget(title: "Logout",icon: LineAwesomeIcons.sign_out_alt_solid,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
                  Get.defaultDialog(
                    title: "LOGOUT",
                    titleStyle: const TextStyle(fontSize: 20),
                    content: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text("Are you sure, you want to Logout?"),
                    ),
                    confirm: Expanded(
                      child: ElevatedButton(
                        onPressed: () =>(),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, side: BorderSide.none),
                        child: const Text("Yes"),
                      ),
                    ),
                    cancel: OutlinedButton(onPressed: () => Get.back(), child: const Text("No")),
                  );
                })
          ],
        ),
      ),
    ) ;

  }

}



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/utils/function/set_remove_auth.dart';
import '../../../features/auth/persention/page/auth_view.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import '../../widget/bottom_sheets/DemoCWActionSheetScreen.dart';

void onClickMoreOptions(BuildContext context) async{
    showCupertinoModalPopup(context: context, builder: (BuildContext context) =>
    DemoCWActionMoreOptionSheetScreen(onLogOut:()async => await onLogOut()));
}

Future<void> onLogOut() async{
      try {
        if (FirebaseAuth.instance != null && FirebaseAuth.instance.currentUser != null) {
          await FirebaseAuth.instance.signOut();
        }
      } finally{
        if(Helper.isAuth) {
          await removeAuth();
        }
        Get.offAll(const AuthView());
      }
    }


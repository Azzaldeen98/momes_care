
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void ShowAwesomeDialogBox({

  required BuildContext context,
  required String message,
  required Function() onAccept}){

   AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    title: 'Warning'.tr,
    desc: message,
    btnCancelText: 'Cancel'.tr,
    btnOkText: 'Yes'.tr,
    btnCancelOnPress: () {},
    btnOkOnPress: () {
      Get.back();
      onAccept();
    },
  )..show();
}


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void ShowAwesomeDialogBox({
  required BuildContext context,
  required String message,
  required Function() onAccept,
   DialogType? dialogType=DialogType.noHeader,
  String? title="",}){

   AwesomeDialog(
    context: context,
    dialogType: dialogType!,
    title: title,
    desc: message,
    btnCancelText: 'No'.tr,
    btnOkText: 'Yes'.tr,
    btnCancelOnPress: () {},
    btnOkOnPress: () {
      Get.back();
      onAccept();
    },
  )..show();
}

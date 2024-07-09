import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../theme/color_app.dart';

class ToastBox {
  static void show({required String message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColors.redOneColor,
        textColor: Colors.white,
        fontSize: 14.0);

  }
}

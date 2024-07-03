import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../style/border_radius.dart';

class BottomSheetWidget {
  static void show(Widget bottomsheet) {
    Get.bottomSheet(bottomsheet,
        isScrollControlled: false,
        backgroundColor: const Color.fromRGBO(252, 252, 252, 1),
        shape: BorderRadiusAttributes.onlyTopRounded(30));
  }

  static void showIsScroll(Widget bottomsheet) {
    Get.bottomSheet(bottomsheet,
        isScrollControlled: true,
        backgroundColor: const Color.fromRGBO(252, 252, 252, 1),
        shape: BorderRadiusAttributes.onlyTopRounded(30));
  }
}

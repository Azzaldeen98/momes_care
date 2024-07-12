import 'package:flutter/material.dart';
import 'package:get/get.dart';



void showCustomBottomSheet({BuildContext? context, final Widget? child }) {

  showModalBottomSheet<void>(
    context: context!,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return child!;
    },
  );
}

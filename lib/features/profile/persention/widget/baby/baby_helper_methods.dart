

import 'package:flutter/cupertino.dart';
import 'package:moms_care/core/constants/enam/gender.dart';
import 'package:moms_care/core/utils/theme/images.dart';

getBabyIconByGender(Gender? gender) {
  return gender==Gender.male?AppImage.BABY_COLOR:AppImage.BABY_GIRL_COLOR;
}

Widget buildRowLabelWithValueWidget({String? label,String? value}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("${label!.trim()} : "),
      Text(value??""),
    ],
  );
}

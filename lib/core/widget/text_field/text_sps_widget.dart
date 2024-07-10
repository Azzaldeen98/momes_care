import 'package:moms_care/core/utils/validator/validator.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../utils/function/choose_name_langauge.dart';
import 'text_field_widget.dart';

class TextFieldMomsCareWidget extends StatelessWidget {
  const TextFieldMomsCareWidget(
      {super.key,
      required this.controller,
      required this.name,
      required this.validator,
      this.textInputType = TextInputType.text,
      this.readOnly = false,
      this.multiLines = false});
  final TextEditingController controller;
  final String name;
  final bool validator;
  final bool multiLines;
  final bool readOnly;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
        name: name,
        multiLines: multiLines,
        textInputType: textInputType,
        radius: 12,
        readOnly: readOnly,
        validator: validator == false
            ? null
            : chooseLableLanguage(
                arabicLable: "${"Enter".tr} $name",
                englishLable: "$name is required",
              ).validator(),
        controller: controller);
  }
}

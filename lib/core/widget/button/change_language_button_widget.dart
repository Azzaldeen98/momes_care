import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/local/locale_controller.dart';
import 'package:moms_care/core/utils/theme/color_app.dart';
import 'package:moms_care/core/utils/theme/images.dart';

import '../../utils/theme/theme_app.dart';

class LanguageButtonWidget extends StatefulWidget{
  const LanguageButtonWidget({super.key});

  @override
  State<StatefulWidget> createState() => _LanguageButtonWidgetState();

}
class _LanguageButtonWidgetState extends State<LanguageButtonWidget>{

  final LocaleController localeController = Get.find();

  @override
  Widget build(BuildContext context) {
 return  InkWell(
   onTap: () async {
       if (localeController.languageCode == "en") {
         Get.changeTheme(Themes.themeArabic);
         localeController.chingeLanguage(languageCode: "ar");
         setState(() {});
       } else {
         Get.changeTheme(Themes.themeEnglish);
         localeController.chingeLanguage(languageCode: "en");
         setState(() {});
       }
   },
   child: SizedBox(
     height: 25,
     width: 25,
     child: Image.asset(AppImage.LANGUAGE,
         color: AppColors.secondaryOneColor, height: 30),
     ),
   );
  }

}
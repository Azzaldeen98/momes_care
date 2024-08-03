
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';

import 'package:moms_care/core/helpers/cache_helper.dart';
import '../../constants/cached/cached_name.dart';
import '../../constants/enam/gender.dart';
import '../../local/locale_controller.dart';

class ChangeLanguageBtnWidget extends StatefulWidget {

  @override
  ChangeLanguageBtnWidgetState createState() => ChangeLanguageBtnWidgetState();
}

class ChangeLanguageBtnWidgetState extends State<ChangeLanguageBtnWidget>{

   String? languageCode;
   IconData? icon;
  @override
  void initState() {
     languageCode=LocaleController.getCurrentLanguageCode();
     _updateIcon();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: _toggleLanguage,
      label:Text(languageCode!.toUpperCase(),style: AppTextStyles.getBasicStyle(
          fontSize:18,
          color: Colors.white),),
      icon:  Icon(icon),);
  }


  void _toggleLanguage() {
    setState(() {
      languageCode = (languageCode == LanguageCode.EN.code)
          ? LanguageCode.AR.code : LanguageCode.EN.code;
    });
    LocaleController().chingeLanguage(languageCode: languageCode!);
    _updateIcon();
  }

   void _updateIcon(){
     setState(() {
       icon=(languageCode==LanguageCode.EN.code ? Icons.language : Icons.translate);
     });

   }

}

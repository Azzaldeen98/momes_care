import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/cached/cached_name.dart';

import 'package:moms_care/core/helpers/cache_helper.dart';
import '../constants/enam/gender.dart';




class LocaleController extends GetxController {
  String languageCode = "";

  LocaleController() {
    initLocale = init();
  }
  late Locale initLocale;
  Locale init() {

    if (CacheHelper.getString(LANGUAGE_TYPE_CACHED) == null) {
      languageCode = "ar";
      CacheHelper.setString(LANGUAGE_TYPE_CACHED, languageCode);
      //Get.deviceLocale!
    } else {
      languageCode = CacheHelper.getString(LANGUAGE_TYPE_CACHED) ?? "ar";
    }

    return  Locale(languageCode);
  }

  void chingeLanguage({required String languageCode}) {
    // print("object:"+languageCode);
    Locale locale = Locale(languageCode);
    this.languageCode = languageCode;
    CacheHelper.setString(LANGUAGE_TYPE_CACHED, languageCode);
    Get.updateLocale(locale);
  }

 static String getCurrentLanguageCode(){
    return CacheHelper.getString(LANGUAGE_TYPE_CACHED)??LanguageCode.AR.code;
  }
}

import '../../constants/cached/cached_name.dart';

import 'package:moms_care/core/helpers/cache_helper.dart';

String chooseLableLanguage(
    {String? arabicLable, String? englishLable, String? error}) {
  if (CacheHelper.getString(LANGUAGE_TYPE_CACHED) == null) {
    CacheHelper.setString(LANGUAGE_TYPE_CACHED, "ar".trim());
    return arabicLable ?? englishLable ?? error ?? "";
  } else if (CacheHelper.getString(LANGUAGE_TYPE_CACHED) == "ar") {
    return arabicLable ?? englishLable ?? error ?? "".trim();
  } else {
    return englishLable ?? arabicLable ?? error ?? "".trim();
  }
}

Type chooseLanguage<Type>({required Type arabic, required Type english}) {
  if (CacheHelper.getString(LANGUAGE_TYPE_CACHED) == null) {
    CacheHelper.setString(LANGUAGE_TYPE_CACHED, "ar");
    return arabic ?? english;
  } else if (CacheHelper.getString(LANGUAGE_TYPE_CACHED) == "ar") {
    return arabic ?? english;
  } else {
    return english ?? arabic;
  }
}

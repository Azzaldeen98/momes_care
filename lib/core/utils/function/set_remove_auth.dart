import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:moms_care/core/constants/enam/user_roles.dart';
import '../../../features/auth/domain/entities/auth.dart';
import 'package:moms_care/core/helpers/cache_helper.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import '../../constants/cached/cached_name.dart';

void setAuth(Auth auth) {

  CacheHelper.setString(INFO_ACCOUNT_CACHED, jsonEncode(auth.userInfo!.toJson()) ?? "");
  CacheHelper.setString(AUTH_TOKEN_CACHED, auth.userInfo?.token ?? "");
  CacheHelper.setString(AUTH_USERID_CACHED, auth.userInfo?.uId ?? "");
  CacheHelper.setInt(AUTH_ROLE_CACHED, auth.userInfo?.role?.index ?? 0);
  CacheHelper.setBool(IS_AUTH, true);
}


Future<void> removeAuth() async {
  try {
    await CacheHelper.removeAt(IS_AUTH);
    await CacheHelper.removeAt(AUTH_TOKEN_CACHED);
    await CacheHelper.removeAt(AUTH_USERID_CACHED);
    await CacheHelper.removeAt(AUTH_ROLE_CACHED);
    await CacheHelper.removeAt(INFO_ACCOUNT_CACHED);

  }catch(e){
    print(e);
  }
}

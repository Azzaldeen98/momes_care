import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:moms_care/core/constants/enam/user_roles.dart';
import '../../../features/auth/domain/entities/auth.dart';
import '../../../helpers/cache_helper.dart';
import '../../../helpers/public_infromation.dart';
import '../../constants/cached/cached_name.dart';

void setAuth(Auth auth) {

  CacheHelper.setString(INFO_ACCOUNT_CACHED, jsonEncode(auth.userInfo!.toJson()) ?? "");
  CacheHelper.setString(AUTH_TOKEN_CACHED, auth.userInfo?.token ?? "");
  CacheHelper.setString(AUTH_USERID_CACHED, auth.userInfo?.uId ?? "");
  CacheHelper.setInt(AUTH_ROLE_CACHED, auth.userInfo?.role?.index ?? 0);
  CacheHelper.setBool(IS_AUTH, true);
}

// ({String,String,bool}) getAuth() {
//
//   // CacheHelper.getString(INFO_ACCOUNT_CACHED);
//   var token = CacheHelper.getString(AUTH_TOKEN_CACHED);
//   var uId   = CacheHelper.getString(AUTH_USERID_CACHED);
//   var role  = CacheHelper.getInt(AUTH_ROLE_CACHED);
//   var isAuth= CacheHelper.getBool(IS_AUTH);
//
//   return  (token, uI,isAuth);
//
// }

Future<void> removeAuthAsync() async {
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

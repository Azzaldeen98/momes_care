import 'package:flutter/widgets.dart';
import '../../../features/auth/domain/entities/auth.dart';
import '../../../helpers/cache_helper.dart';
import '../../../helpers/public_infromation.dart';
import '../../constants/cached/cached_name.dart';

void setAuth(Auth auth) {
  debugPrint(auth.userInfo?.token);
  CacheHelper.setString(AUTH_TOKEN_CACHED, auth.userInfo?.token ?? "");
  CacheHelper.setBool(IS_AUTH, true);
}

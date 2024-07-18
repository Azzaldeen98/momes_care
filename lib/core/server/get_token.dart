import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';

import 'package:moms_care/core/helpers/cache_helper.dart';
import '../constants/cached/cached_name.dart';

Future<String> getfcbToken() async {
  try {
    return await FirebaseMessaging.instance.getToken() ?? "";
  } catch (e) {
    return "";
  }
}

Future<Map> getfcbTokenNotification() async {
  int? userId;
  if (Helper.isAuth) {
    userId = CacheHelper.getInt(USER_ID);
  }
  try {
    return {
      "type": Platform.isIOS ? 'ios' : 'android',
      "customerId": userId,
      "token": await FirebaseMessaging.instance.getToken(),
    };
  } catch (e) {
    return {
      "type": Platform.isIOS ? 'ios' : 'android',
      "customerId": userId,
      "token": "",
    };
  }
}

import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import '../../helpers/public_infromation.dart';

import '../../helpers/cache_helper.dart';
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

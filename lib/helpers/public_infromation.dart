import 'package:firebase_auth/firebase_auth.dart';

import '../core/constants/cached/cached_name.dart';
import '../features/auth/domain/entities/auth.dart';
import 'cache_helper.dart';
import '../core/firebase/firebase_message.dart';
import '../core/widget/button/button_navigation_widget.dart';

//final sl = GetIt.instance;
class Helper {
  static List<dynamic> settings = [];
  static bool isAuth = false;
  static bool notification = false;
  static ButtonNavigationWidget? buttonNavigation;
  static FirebaseMessageGoogleMapImp? firebaseMessage;
  static Auth?  auth;
  static bool isStore = false;
  static void init() {
    notification = CacheHelper.getBool(ORDER_CACHED) ?? false;
  }
}





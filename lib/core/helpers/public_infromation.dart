import 'package:firebase_auth/firebase_auth.dart';
import 'package:moms_care/core/constants/cached/cached_name.dart';
import 'package:moms_care/core/firebase/firebase_message.dart';
import 'package:moms_care/core/helpers/cache_helper.dart';
import 'package:moms_care/core/widget/button/button_navigation_widget.dart';
import 'package:moms_care/core/widget/navigation_bar/bottom_navigation_bar.dart';
import 'package:moms_care/features/auth/domain/entities/auth.dart';



//final sl = GetIt.instance;
class Helper {
  static List<dynamic> settings = [];
  static bool isAuth = false;
  static String Auth_UId = FirebaseAuth.instance.currentUser!.uid ?? "";
  static bool notification = false;
  static ButtonNavigationWidget? buttonNavigation;
  static BottomNavigationWidget? bottomNavigation;
  static FirebaseMessageGoogleMapImp? firebaseMessage;
  static Auth?  auth;
  static bool isAdmin = false;
  static void init() {
    notification = CacheHelper.getBool(ORDER_CACHED) ?? false;
  }

  // (String,String) getDateAndTime(DateTime date){
  //   return ("","");
  //  }
}





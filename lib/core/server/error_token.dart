import '../../features/auth/persention/page/auth_view.dart';
import 'package:get/get.dart';
import '../../helpers/cache_helper.dart';
import '../constants/cached/cached_name.dart';

class ErrorTokenAuth {
  static bool scanTokenAuth(String resonseBody) {
    if (resonseBody == '"Not authorized, token failed"' ||
        resonseBody == '"Not authorized, no token"' ||
        resonseBody == "NOT AUTHORIZED, YOU DON'T HAVE PERMISSION TO LOG IN") {
      exitApp();
      return true;
    }
    return false;
  }

  static void exitApp() {
    CacheHelper.removeAt(AUTH_TOKEN_CACHED);
    CacheHelper.removeAt(INFO_ACCOUNT_CACHED);
    CacheHelper.removeAt(IS_AUTH);
    CacheHelper.removeAt(USER_ID);
    Get.offAll(() => const AuthView());
  }
}

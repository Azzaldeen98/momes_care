import '../../helpers/cache_helper.dart';
import '../constants/cached/cached_name.dart';
import 'dart:io' show Platform;

class HeaderServer {
  static Map<String, String> get header {
    return {
      'Content-Type': 'application/json',
      'User-Agent': Platform.isIOS ? 'ios' : 'android',
    };
  }

  static Map<String, String> get headerWithToken {
    return {
      'Authorization': CacheHelper.getString(AUTH_TOKEN_CACHED) ?? "",
      'Content-Type': 'application/json',
      'User-Agent': Platform.isIOS ? 'ios' : 'android',
    };
  }

  static Map<String, String> get headerWithCloudflare {
    return {
      'authority': 'api.cloudflare.com',
      'Authorization': 'Bearer -VvHgj2ssJyBfinWoTqjRFKVJz-QhC2qy83GSiR_'
    };
  }
}

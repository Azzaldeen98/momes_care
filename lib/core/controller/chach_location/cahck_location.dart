import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../utils/dailog/message/message_box.dart';

class LocationUtils {
  static Future<bool> locationServiceEnabled(BuildContext context) async {
    LocationPermission locationPermission;
    bool services;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      // ignore: use_build_context_synchronously
      MessageBox.showError(context, "Please enable the website.".tr);

      return false;
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      locationPermission = await Geolocator.requestPermission();
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
// رسالة البرميشن في حالة عدم منح المستخدم للوصول إلى الموقع من قبل
      // ignore: use_build_context_synchronously
      // MessageBox.showWarning(
      //   context,
      //   "Access to the website must be granted to use this feature.".tr,
      // );
      return false;
    }
    if (locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse) {
      return true;
    }
    return false;
  }

  static Future<Position?> getLatLog() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return null;
    }
  }
}

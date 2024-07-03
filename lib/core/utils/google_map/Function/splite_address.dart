import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class SplitAddress {
  static String descriptionAddress(List<Placemark>? placemarks) {
    if ((placemarks ?? []).isEmpty) {
      return "";
    } else {
      String address = "";
      for (int i = 0; i < (placemarks ?? []).length; i++) {
        if ((placemarks?[i].locality ?? "").trim() != "") {
          address += "${placemarks?[i].locality?.trim()} , ";
          break;
        }
      }
      for (int i = 0; i < (placemarks ?? []).length; i++) {
        if ((placemarks?[i].subLocality ?? "").trim() != "") {
          address += "${(placemarks?[i].subLocality ?? "").trim()} , ";
          break;
        }
      }
      for (int i = 0; i < (placemarks ?? []).length; i++) {
        if ((placemarks?[i].street ?? "").trim() != "") {
          address += "${(placemarks?[i].street ?? "").trim()} , ";
          break;
        }
      }
      for (int i = 0; i < (placemarks ?? []).length; i++) {
        if ((placemarks?[i].postalCode ?? "").trim() != "") {
          address += "${placemarks?[i].postalCode!.trim()} , ";
          break;
        }
      }
      try {
        return address.substring(0, address.length - 2);
      } catch (e) {
        return address;
      }
    }
  }

  static String showAddress(List<Placemark>? placemarks) {
    if ((placemarks ?? []).isEmpty) {
      return "";
    } else {
      String address = "";
      for (int i = 0; i < (placemarks ?? []).length; i++) {
        if ((placemarks?[i].locality ?? "").trim() != "") {
          address += "${"locality".tr} : ${placemarks?[i].locality!.trim()} , ";
          break;
        }
      }
      for (int i = 0; i < (placemarks ?? []).length; i++) {
        if ((placemarks?[i].subLocality ?? "").trim() != "") {
          address +=
              "${"subLocality".tr} : ${placemarks?[i].subLocality!.trim()} , ";
          break;
        }
      }
      for (int i = 0; i < (placemarks ?? []).length; i++) {
        if ((placemarks?[i].street ?? "").trim() != "") {
          address += "${"street".tr} : ${placemarks?[i].street!.trim()} , ";
          break;
        }
      }
      for (int i = 0; i < (placemarks ?? []).length; i++) {
        if ((placemarks?[i].postalCode ?? "").trim() != "") {
          address +=
              "${"postalCode".tr} : ${placemarks?[i].postalCode!.trim()} , ";
          break;
        }
      }
      return address.substring(0, address.length - 2);
    }
  }
}

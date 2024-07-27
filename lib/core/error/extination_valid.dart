import 'dart:io';
import 'package:moms_care/core/constants/constants.dart';
import 'package:moms_care/core/constants/data.dart';
import 'package:moms_care/core/constants/enam/file_types.dart';
import 'package:moms_care/core/utils/validator/validator.dart';
import 'package:path/path.dart' as p;

extension ExtString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidURL{
    final urlPattern = RegExp(
      r'^(https?:\/\/)?([a-zA-Z0-9_-]+)\.([a-zA-Z0-9_-]+)(\/[a-zA-Z0-9_-]+)*\/?([a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+)?$',
      caseSensitive: false,
    );
    return urlPattern.hasMatch(this);
  }
  bool get isValidFirebaseStorageURL{
    return this!.startsWith(AppFirebaseStorageBaseURL);
  }

  bool get isValidImageWebURL {
    RegExp regExp = RegExp(r'^(https?:\/\/.*\.(?:png|jpg|jpeg|gif|bmp|webp))$',
      caseSensitive: false,);
    return regExp.hasMatch(this);
  }

  bool get isValidAllowedImageFile  {
    final extension = p.extension(this).toLowerCase();
    for(var ext in ImageExtensions){
      if(extension.contains(ext)) {
        return true;
      }
    }
    return false;
    // return ImageExtensions.contains(extension);
  }


  bool get isValidAllowedVideoFile {
    final extension = p.extension(this).toLowerCase();
    for(var ext in VideoExtensions){
      if(extension.contains(ext)) {
        return true;
      }
    }
    return false;
    // return VideoExtensions.contains(extension);
  }

  bool get isValidAllowedFile {
    return this!=null  && (this!.isValidAllowedImageFile || this!.isValidAllowedVideoFile);
  }

  Future<bool> get isValidLocalPath async{
   return   await File(this).exists();
  }
  bool get isValidImageLocalURL {
    RegExp regExp = RegExp(r'^(?!https?:\/\/)(.*\.(?:png|jpg|jpeg|gif|bmp|webp))$',
      caseSensitive: false,);
    return regExp.hasMatch(this);
  }


  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}

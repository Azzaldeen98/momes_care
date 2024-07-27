

import 'package:flutter/cupertino.dart';
import 'package:moms_care/core/constants/data.dart';
import 'package:moms_care/core/constants/enam/file_types.dart';
import 'package:moms_care/core/constants/enam/media_type.dart';
import 'package:moms_care/core/error/extination_valid.dart';
import 'package:path/path.dart' as p;
class Helpers{

 static double  getWidthPercent(BuildContext context,double width) {
    final screenSize = MediaQuery.of(context).size;
    return screenSize.width * width / 100;
  }

 static double  getHeightPercent(BuildContext context,double height) {
    final screenSize = MediaQuery.of(context).size;
    return screenSize.height * height / 100;
  }

 static double  getPercentValue(double parentSize,double value) {
   return parentSize * value / 100;
 }

 static bool  isTextContainsAnyArray(String text,List<String> list) {

   if(text!=null){
     for(var ext in list){
       if(text!.contains(ext)) {
         return true;
       }
     }
   }
   return false;
 }

 static MediaTypes  detectFileType(String? path) {

   if(path==null || path!.isEmpty) {
     return MediaTypes.None;
   }else {

     path = path!.toLowerCase();

     if (path!.contains("https://youtube/") || path!.contains("https://youtu.be/")) {
       return MediaTypes.Youtube;
     } else if (isTextContainsAnyArray(path!, VideoExtensions)) {
       return MediaTypes.Video;
     } else if (isTextContainsAnyArray(path!, ImageExtensions)) {
       return MediaTypes.Image;
     } else if (path!.contains("https://")) {
       return MediaTypes.WebUrl;
     } else {
       return MediaTypes.None;
     }
   }

   //final extension = p.extension(path!).toLowerCase();


    // else if (path!.isValidURL && !path!.isValidAllowedFile) {
    //   return MediaTypes.Image;
    // }

  }
}
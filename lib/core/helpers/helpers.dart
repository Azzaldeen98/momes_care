

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moms_care/core/constants/data.dart';
import 'package:moms_care/core/constants/enam/file_types.dart';
import 'package:moms_care/core/constants/enam/media_type.dart';
import 'package:moms_care/core/error/extination_valid.dart';
import 'package:path/path.dart' as p;
class Helpers{
static   String convertTo12HourFormat(String time) {
  DateFormat inputFormat = DateFormat('HH:mm:ss');
  DateFormat outputFormat = DateFormat('hh:mm a');
  DateTime dateTime = inputFormat.parse(time);
  return outputFormat.format(dateTime);
}
 static double  getWidthPercent(BuildContext context,double width) {
    final screenSize = MediaQuery.of(context).size;
    return screenSize.width * width / 100;
  }

 static String formatTime(String time) {

   DateFormat inputFormat = DateFormat('h:m a');
   DateFormat outputFormat = DateFormat('hh:mm:ss a');

   // تحويل النص إلى كائن DateTime
   DateTime dateTime = inputFormat.parse(time);

   // إعادة تنسيق الوقت إلى الصيغة المطلوبة
   String formattedTime = outputFormat.format(dateTime);
    print("formattedTime:${formattedTime}");
   return formattedTime;
 }

 static Duration convertToDuration(String time) {
   // استخدم مكتبة intl لتحليل الوقت
   DateFormat inputFormat = DateFormat('hh:mm a');

   // تحويل النص إلى كائن DateTime
   DateTime dateTime = inputFormat.parse(time);

   // حساب المدة الزمنية من بداية اليوم (midnight)
   Duration duration = Duration(hours: dateTime.hour, minutes: dateTime.minute);

   return duration;
 }
 static Duration parseDuration(String timeString) {
   final parts = timeString.split(':');
   final hours = int.parse(parts[0]);
   final minutes = int.parse(parts[1]);
   final seconds = int.parse(parts[2]);
   // TimeOfDay.hoursPerPeriod()
   return Duration(hours: hours, minutes: minutes, seconds: seconds);
 }
 static TimeOfDay parseTimeOfDay(String timeString) {
   final parts = timeString.split(':');
   final hours = int.parse(parts[0]);
   final minutes = int.parse(parts[1]);
   return TimeOfDay(hour: hours,minute: minutes);
 }
 static String addLeadingZero(int number) {
   return  number < 10 ? '0$number' : number.toString();
 }

 static String timeOfDayToString(TimeOfDay timeOfDay) {
   var hour=timeOfDay.hour==0 ?12:(timeOfDay.hour>12)?timeOfDay.hour-12:timeOfDay.hour;
   return "${addLeadingZero(hour)}:${addLeadingZero(timeOfDay.minute)} ${Helpers.getPeriod(timeOfDay)}";
 }
 static String getPeriod(TimeOfDay timeOfDay) {
   return timeOfDay.period == DayPeriod.am ? "AM" : "PM";
 }

 static String durationToString(Duration duration) {
   final hours = duration.inHours.toString().padLeft(2, '0');
   final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
   final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
   return '$hours:$minutes:$seconds';
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
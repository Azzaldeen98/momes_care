

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/constants/enam/NotificationType.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';

import '../data/models/baby_care_notify_model.dart';
import '../helpers/helpers.dart';
import '../helpers/public_infromation.dart';

class FirebaseNotifyFCM{

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message: ${message.messageId}');
  }
  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }



  Future<void> _showCustomNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel', // معرف القناة
      'High Importance Notifications', // اسم القناة
      channelDescription:   'This channel is used for important notifications.', // وصف القناة
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  Future<void> _showBabyCareNotification(RemoteMessage message,BabyCareNotificationModel model) async {
     AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_BabyCare_channel', // معرف القناة
      'High Importance BabyCare Notifications', // اسم القناة
      channelDescription:   'This channel is used for important Baby Care notifications.', // وصف القناة
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      // icon: AppImage.NOTIFICATION_GREY,
      actions:<AndroidNotificationAction>[
           AndroidNotificationAction("${model.babyId}",model.message ),
      ]

    );
     NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      model.babyName,
      model.message,
      // message.notification?.title,
      // message.notification?.body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
  Future<void> initializeFCM() async{
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await  _initializeLocalNotifications();
    FirebaseMessaging.instance.getToken().then(onReceiveToken);
    FirebaseMessaging.onMessage.listen(onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
  }



  void onReceiveToken(String? token) {
    assert(token != null);
    print("FCM Token: $token");
    // يمكنك تخزين الرمز في قاعدة البيانات هنا إذا لزم الأمر
  }
  void onMessage(RemoteMessage message) {

      print('Got a message whilst in the foreground!');
      print('Message data:  ${message.data['topic']} - ${message.data['tag']}');

      if (message.notification != null) {
        // print('Notification title: ${message.notification?.title}');
        // print('Notification body: ${message.notification?.body}');
        // عرض الإشعار محليًا باستخدام flutter_local_notifications
        print(jsonEncode(message.notification?.toMap()));

        if(message.data['tag'].toString().trim()==NotificationType.CareBaby.text) {
          print('CareBaby body: ${message.notification?.body}');
            _handleBabyCareNotification(message);
        } else {
          _showCustomNotification(message);
        }
      }


  }
  void _handleBabyCareNotification(RemoteMessage message) {
    if(message.data['topic'].toString()==Helper.userId && message.notification?.body!=""){

      var jsonData = jsonDecode(message.notification?.body??"");

      if(jsonData!=null){
        var model=BabyCareNotificationModel.fromJson(jsonData);
        _showBabyCareNotification(message,model);
      }
    }
  }
  void onMessageOpenedApp(RemoteMessage message) {

      print('Message clicked!');
      // يمكنك توجيه المستخدم إلى شاشة معينة هنا بناءً على محتوى الإشعار
      if(message.data['tag']==NotificationType.BroadcastLive){
        Get.offAll(HomePage(numberScreen: AppPages.BROADCASTLIVE.index,));
      }

  }
}



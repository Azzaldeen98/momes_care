import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../../helpers/cache_helper.dart';
import '../../helpers/public_infromation.dart';
import '../constants/cached/cached_name.dart';
import 'local_notification.dart';
import 'package:http/http.dart' as http;
//import 'package:firebase_messaging/firebase_messaging.dart';

abstract class FirebaseMessageGoogleMap {}

class FirebaseMessageGoogleMapImp extends FirebaseMessageGoogleMap {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  final String serverToken =
      "BDWq1eRj_gvke2r5AWNj8DuTSEHeSqqCLQXz4JLCcMwUNJGB7vkhGqdCqZzPCsggRsXJnIAezw0yZXnRjblPDV0";
  VoidCallback eventDelegate = () {};
  VoidCallback eventBackgroudAndIerninatedApp = () {};

  ///! =============================================><==
  ///?  it operates the following function
  ///*  -  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  ///*   -  FirebaseMessaging.onMessage.listen(showFlutterNotification);
  ///*   -  FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
  ///*   -  initalMessage();
  ///! =============================================><==
  NotificationServices notificationServices = NotificationServices();
  FirebaseMessageGoogleMapImp() {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
    notificationServices.initialisedNotifications();
    initalMessage();
  }

  ///! =============================================><==
  ///? Send Notification by API.
  ///* key [serverToken]
  ///! =============================================><==

  Future<void> sendPushMessage(String title, String body) async {
    String? token = "await getToken()";

    // ignore: unnecessary_null_comparison
    if (token == null) {
      return;
    }
    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization':'key=$serverToken'
        },
        body: constructFCMPayload(token, title, body),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String constructFCMPayload(String? token, String title, String body) {
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': 1,
      },
      'priority': 'high',
      'notification': {
        'title': title,
        'body': body,
      },
    });
  }

  ///! =============================================><==
  ///? g et Tocken
  ///* FirebaseMessaging.instance.getToken();
  ///! =============================================><==
  Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  ///! =============================================><==
  ///? is state background when click in Notification
  ///* FirebaseMessaging.instance.getInitialMessage();
  ///! =============================================><==
  onMessageOpenedApp(RemoteMessage message) {
    showNotification(message);
    eventBackgroudAndIerninatedApp();
  }

  ///! =============================================><==
  ///?  if is  Appliction  opened form a Ierninated state
  ///*  FirebaseMessaging.instance.getInitialMessage();
  ///! =============================================><==
  initalMessage() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      showNotification(message);
      eventBackgroudAndIerninatedApp();
    }
  }

  ///! =============================================><==
  ///? Resave Notification in close (background or Ierninated) Aplication.
  ///* FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  ///! =============================================><==

  Future onBackgroundMessage(RemoteMessage message) async {
    showNotification(message);
  }

  ///! =============================================><==
  ///? Resave Notification in Open (foregroun ) Aplication.
  ///* FirebaseMessaging.onMessage.listen(showFlutterNotification);
  ///! =============================================><==

  void showFlutterNotification(RemoteMessage message) {
    showNotification(message);
  }

  ///! =============================================><==
  ///? Show method use disply Notification.
  ///* All back mehtod use this method
  ///! =============================================><==

  void showNotification(RemoteMessage message) async {
    debugPrint(message.data.toString());
    debugPrint(message.notification.toString());
    await saveNoitfcation();
    notificationServices.sendNotifications(
      id: 0,
      title:
          message.notification?.title ?? message.data["title"] ?? "not title",
      body: message.notification?.body ?? message.data["body"] ?? "not body",
    );
  }

  Future<void> saveNoitfcation() async {
    Helper.notification = true;
    CacheHelper.setBool(ORDER_CACHED, true);
  }
}

//
//
// import 'dart:convert';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// // class Application extends StatefulWidget {
// //   @override
// //   State<StatefulWidget> createState() => _Application();
// // }
// //
// // class _Application extends State<Application> {
// //   // It is assumed that all messages contain a data field with the key 'type'
// //   Future<void> setupInteractedMessage() async {
// //     // Get any messages which caused the application to open from
// //     // a terminated state.
// //     RemoteMessage? initialMessage =
// //     await FirebaseMessaging.instance.getInitialMessage();
// //
// //     // If the message also contains a data property with a "type" of "chat",
// //     // navigate to a chat screen
// //     if (initialMessage != null) {
// //       _handleMessage(initialMessage);
// //     }
// //
// //     // Also handle any interaction when the app is in the background via a
// //     // Stream listener
// //     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
// //   }
// //
// //   void _handleMessage(RemoteMessage message) {
// //
// //     print("FirebaseMessaging : ${jsonEncode(message.data)}");
// //     // if (message.data['type'] == 'chat') {
// //     //
// //     //
// //     // }
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     // Run code required to handle interacted messages in an async function
// //     // as initState() must not be async
// //     setupInteractedMessage();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Text("...");
// //   }
// // }
//
//
//
// // class NotificationHandler extends StatefulWidget {
// //   @override
// //   _NotificationHandlerState createState() => _NotificationHandlerState();
// // }
// //
// // class _NotificationHandlerState extends State<NotificationHandler> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializeFCM();
// //   }
// //
// //   Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //     await Firebase.initializeApp();
// //     print('Handling a background message: ${message.messageId}');
// //     // هنا يمكنك تنفيذ أي منطق تريد تنفيذه عند استقبال رسالة في الخلفية
// //   }
// //   void _initializeFCM() {
// //     // الحصول على رمز FCM
// //     FirebaseMessaging.instance.getToken().then((String? token) {
// //       assert(token != null);
// //       print("FCM Token: $token");
// //       // يمكنك تخزين الرمز في قاعدة البيانات هنا إذا لزم الأمر
// //     });
// //
// //     // الاستماع للإشعارات المستلمة أثناء وجود التطبيق في المقدمة
// //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// //       print('Got a message whilst in the foreground!');
// //       print('Message data: ${jsonEncode(message.data)}');
// //
// //       if (message.notification != null) {
// //         print('Notification title: ${message.notification?.title}');
// //         print('Notification body: ${message.notification?.body}');
// //         // يمكنك عرض الإشعار هنا باستخدام مكتبة مثل flutter_local_notifications
// //       }
// //     });
// //
// //     // الاستماع عند فتح التطبيق من الإشعار
// //     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
// //       print('Message clicked!');
// //       // يمكنك توجيه المستخدم إلى شاشة معينة هنا بناءً على محتوى الإشعار
// //     });
// //
// //     // الاستماع للإشعارات المستلمة أثناء وجود التطبيق في الخلفية
// //     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //    return Scaffold(
// //      backgroundColor: Colors.white,
// //      body: Container(),
// //    );
// //   }
// // }
//
// class NotificationHandler extends StatefulWidget {
//   @override
//   _NotificationHandlerState createState() => _NotificationHandlerState();
// }
//
// class _NotificationHandlerState extends State<NotificationHandler> {
//   // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeFCM();
//   }
//
//   void _initializeFCM() {
//     FirebaseMessaging.instance.getToken().then((String? token) {
//       assert(token != null);
//       print("FCM Token: $token");
//       // يمكنك تخزين الرمز في قاعدة البيانات هنا إذا لزم الأمر
//     });
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${jsonEncode(message.data)}');
//
//       if (message.notification != null) {
//         print('Notification title: ${message.notification?.title}');
//         print('Notification body: ${message.notification?.body}');
//         // عرض الإشعار محليًا باستخدام flutter_local_notifications
//         _showNotification(message);
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Message clicked!');
//       // يمكنك توجيه المستخدم إلى شاشة معينة هنا بناءً على محتوى الإشعار
//     });
//   }
//
//   Future<void> _showNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'high_importance_channel', // معرف القناة
//       'High Importance Notifications', // اسم القناة
//       channelDescription:   'This channel is used for important notifications.', // وصف القناة
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       message.notification?.title,
//       message.notification?.body,
//       platformChannelSpecifics,
//       payload: 'item x',
//     );
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Center(
//         child: Text('Waiting for messages...'),
//       ),
//     );
//   }
// }

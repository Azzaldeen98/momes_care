import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../utils/theme/color_app.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings("logo2");

  final DarwinInitializationSettings _iosInitializationSettings =
      const DarwinInitializationSettings();

  void initialisedNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
        android: _androidInitializationSettings,
        iOS: _iosInitializationSettings);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotifications(
      {int id = 0, String? title, String? body, String? payload}) async {
    _flutterLocalNotificationsPlugin
        .show(id, title, body, _getNotificationDetails(), payload: payload);
  }

  void secheduleNotifications(
      {int id = 0, String? title, String? body, String? payload}) async {
    _flutterLocalNotificationsPlugin.periodicallyShow(
        id, title, body, RepeatInterval.everyMinute, _getNotificationDetails(),
        payload: payload);
  }

  NotificationDetails _getNotificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id', 'channel name',
          channelDescription: 'channel description',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          // icon: "@mipmap/ic_launcher",
          color: AppColors.mainOneColor,
        ),
        iOS: DarwinNotificationDetails());
  }

  void stopNotifications() {
    _flutterLocalNotificationsPlugin.cancelAll();
    // _flutterLocalNotificationsPlugin.cancel(0);
  }
}

import 'dart:convert';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:moms_care/features/auth/persention/bloc/auth_bloc/auth_bloc.dart';
import 'package:moms_care/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:moms_care/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_bloc.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_bloc.dart';
import 'package:moms_care/features/speech/persention/bloc/gemini/gemini_bloc.dart';
import 'package:moms_care/features/splash/presentation/splash_view.dart';
import 'package:moms_care/injection_container.dart' as di;
import 'core/constants/cached/cached_name.dart';
import 'core/local/data_locale_translation.dart';
import 'core/local/locale_controller.dart';
import 'config/routes/routes.dart';
import 'config/theme/app_themes.dart';
import 'features/forum/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'features/forum/presentation/bloc/comments/comment_bloc.dart';
import 'features/forum/presentation/bloc/posts/post_bloc.dart';
import 'package:moms_care/core/helpers/cache_helper.dart';
import 'package:moms_care/core/helpers/my_bloc_observer.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> _initializeLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
Future<void> _showNotification(RemoteMessage message) async {
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
void _initializeFCM() {
  FirebaseMessaging.instance.getToken().then((String? token) {
    assert(token != null);
    print("FCM Token: $token");
    // يمكنك تخزين الرمز في قاعدة البيانات هنا إذا لزم الأمر
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data:  ${message.data['topic']} - ${message.data['tag']}');

    if (message.notification != null) {
      print('Notification title: ${message.notification?.title}');
      print('Notification body: ${message.notification?.body}');
      // عرض الإشعار محليًا باستخدام flutter_local_notifications
      print(jsonEncode(message.notification?.toMap()));
      _showNotification(message);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Message clicked!');
    // يمكنك توجيه المستخدم إلى شاشة معينة هنا بناءً على محتوى الإشعار
  });
}

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Helper.isAuth = CacheHelper.getString(AUTH_TOKEN_CACHED) != null;
  await di.init();
  Bloc.observer = MyBlocObserver();
  Helper.init();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await  _initializeLocalNotifications();
  _initializeFCM();

  // LocaleController().chingeLanguage(languageCode:"ar");
  // await FirebaseAppCheck.instance.activate(
    //   androidProvider: AndroidProvider.debug,
    //   appleProvider: AppleProvider.debug,
    // );
  // You may set the permission requests to "provisional" which allows the user to choose what type
// of notifications they would like to receive once the user receives a notification.
//   final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);
//
// // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
//   final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
//   if (apnsToken != null) {
//     // APNS token is available, make FCM plugin API requests...
//   }
//
//   await FirebaseMessaging.instance.setAutoInitEnabled(true);
//
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//
//   print('User granted permission: ${settings.authorizationStatus}');
//
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print('Got a message whilst in the foreground!');
//     print('Message data: ${message.data}');
//
//     if (message.notification != null) {
//       print('Message also contained a notification: ${message.notification}');
//     }
//   });
  FirebaseAuth.instance.setLanguageCode("en");
  // FirebaseAuth.instance.setLanguageCode(LocaleController.getCurrentLanguageCode());
  // final GetIt sl = GetIt.instance;
  // di.sl.registerLazySingleton(() => AddCommentUseCase(di.sl()));
  runApp(const MyApp());
}



class MyApp extends StatelessWidget with WidgetsBindingObserver {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)  {


    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MultiBlocProvider(providers: [
    // BlocProvider<RemoteArticlesBloc>(create: (context) => di.sl()..add(const GetArticles())),

    BlocProvider(create: (context) => di.sl<BroadcastLiveBloc>()),
    BlocProvider(create: (context) => di.sl<ProfileBloc>()),
    BlocProvider(create: (context) => di.sl<GeminiBloc>()),
    BlocProvider(create: (context) => di.sl<ProfilePostBloc>()),
    BlocProvider(create: (context) => di.sl<PostBloc>()),
    BlocProvider<CommentBloc>(create: (_) => di.sl<CommentBloc>()),
    BlocProvider(create: (context) => di.sl<AddDeleteUpdatePostBloc>()),
    // BlocProvider<AddDeleteUpdateCommentBloc>(create: (_) => di.sl<AddDeleteUpdateCommentBloc>()),
    ], child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Get.put(LocaleController()).initLocale,
      translations: DataLoacleTranslations(),
      title: "Mom's Care".tr,
      theme: theme(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      //   onGenerateRoute: (settings) => Routes.generateRoute(context, settings),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      // initialRoute: RoutesName.dailyNews,
      home: const SplashView()
    ),);
    //BlocProvider<RemoteArticlesBloc>(
    // create: (context) => sl()..add(const GetArticles()),
    // child:
    // );
  }
}




















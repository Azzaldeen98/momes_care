

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessageActions{

 static Future<String> getFCMToken() async => await FirebaseMessaging.instance.getToken() ?? "";


   static void listenFCMToken({required Function(String) onRefreshFcmToken}){
     FirebaseMessaging.instance.onTokenRefresh
         .listen((fcmToken) async{
       await onRefreshFcmToken(fcmToken);
       // Note: This callback is fired at each app startup and whenever a new
       // token is generated.
     })
         .onError((err) {
       // Error getting token.
     });
   }

}
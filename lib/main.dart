
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/firebase/firebase_notification.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_bloc.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_bloc.dart';
import 'package:moms_care/features/speech/persention/bloc/gemini/gemini_bloc.dart';
import 'package:moms_care/features/splash/presentation/splash_view.dart';
import 'package:moms_care/injection_container.dart' as di;
import 'core/constants/cached/cached_name.dart';
import 'core/local/data_locale_translation.dart';
import 'core/local/locale_controller.dart';
import 'config/routes/routes.dart';
import 'core/utils/theme/app_themes.dart';
import 'features/forum/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'features/forum/presentation/bloc/comments/comment_bloc.dart';
import 'features/forum/presentation/bloc/posts/post_bloc.dart';
import 'package:moms_care/core/helpers/cache_helper.dart';
import 'package:moms_care/core/helpers/my_bloc_observer.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Helper.isAuth =  CacheHelper.getString(AUTH_TOKEN_CACHED) != null;
  await di.init();
  Bloc.observer = MyBlocObserver();
  Helper.init();

  await FirebaseNotifyFCM().initializeFCM();
  // FirebaseAuth.instance.setLanguageCode("en");
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




















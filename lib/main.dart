import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/features/daily_news/presentation/pages/splash/splash.dart';
import 'package:moms_care/features/forum/presentation/bloc/add_delete_update_comment/add_delete_update_comment_bloc.dart';
import 'package:moms_care/features/forum/presentation/pages/post/posts_page.dart';
import 'package:moms_care/features/splash/presentation/splash_view.dart';
import 'package:moms_care/injection_container.dart' as di;
import 'core/constants/cached/cached_name.dart';
import 'core/local/data_locale_translation.dart';
import 'core/local/locale_controller.dart';
import 'config/routes/routes.dart';
import 'config/routes/routes_name.dart';
import 'config/theme/app_themes.dart';
import 'features/auth/persention/bloc/auth_bloc/auth_bloc.dart';
import 'features/auth/persention/page/sigin_page.dart';
import 'features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'features/daily_news/presentation/pages/home/daily_news.dart';
import 'features/forum/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'features/forum/presentation/bloc/comments/comment_bloc.dart';
import 'features/forum/presentation/bloc/posts/post_bloc.dart';
import 'features/home/persention/pages/home_page.dart';
import 'helpers/cache_helper.dart';
import 'helpers/my_bloc_observer.dart';
import 'helpers/public_infromation.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Helper.isAuth = CacheHelper.getString(AUTH_TOKEN_CACHED) != null;
  await Firebase.initializeApp();
  await di.init();
  Bloc.observer = MyBlocObserver();
  // Helper.init();
  LocaleController().chingeLanguage(languageCode:"ar");

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
    BlocProvider<RemoteArticlesBloc>(create: (context) => di.sl()..add(const GetArticles())),
    BlocProvider(create: (context) => di.sl<PostBloc>()),
    BlocProvider(create: (context) => di.sl<AddDeleteUpdatePostBloc>()),
    BlocProvider(create: (context) => di.sl<CommentBloc>()),
    BlocProvider(create: (context) => di.sl<AddDeleteUpdateCommentBloc>()),

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


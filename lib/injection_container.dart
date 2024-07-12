import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:moms_care/core/constants/constants.dart';
import 'package:moms_care/features/auth/data/repositories/firebase/firebase_auth_repo_imp.dart';
import 'package:moms_care/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:moms_care/features/daily_news/domain/repository/article_repository.dart';
import 'package:moms_care/features/daily_news/domain/usecases/get_article.dart';
import 'package:moms_care/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:moms_care/features/forum/data/dataSource/remote/posts_remote_data_source.dart';
import 'package:moms_care/features/forum/domain/repository/post_repository.dart';
import 'package:moms_care/features/forum/domain/usecases/post/add_post_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/get_all_posts_use_case.dart';
import 'package:moms_care/features/forum/presentation/bloc/post/post_bloc.dart';
import 'package:moms_care/features/forum/presentation/bloc/post/post_event.dart';
import 'package:moms_care/features/home/data/data_sourse/moms_care_datasourse.dart';
import 'package:moms_care/features/home/domain/repositories/moms_care_repository.dart';
import 'package:moms_care/features/home/domain/usecases/get_moms_care_items_usecase.dart';
import 'package:moms_care/features/home/persention/bloc/moms_care/moms_care_bloc.dart';
import 'package:moms_care/features/speech/data/dataSourse/remote/speech_remote_datasourse.dart';
import 'package:moms_care/features/speech/domain/usecases/getsparepart_usecases.dart';
import 'package:moms_care/features/speech/persention/bloc/speech/speech_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/api_servers.dart';
import 'core/controller/work_on_servers/network/network_info.dart';
import 'core/local/locale_controller.dart';
import 'core/remote/api_service.dart';
import 'features/auth/data/dataSourse/auth_remote_data_source.dart';
import 'features/auth/data/dataSourse/remote/auth_api_service.dart';
import 'features/auth/data/dataSourse/remote/firebase_auth_api_service.dart';
import 'features/auth/data/repositories/auth_repotitorises_imp.dart';
import 'features/auth/domain/repositories/auth_repostitorise.dart';
import 'features/auth/domain/repositories/firebase/firebase_auth_repo.dart';
import 'features/auth/domain/usecases/firebase_sigin_usescases.dart';
import 'features/auth/domain/usecases/firebase_sigup_usescases.dart';
import 'features/auth/domain/usecases/register_usescases.dart';
import 'features/auth/domain/usecases/sigin_usescases.dart';
import 'features/auth/persention/bloc/auth_bloc/auth_bloc.dart';
import 'features/daily_news/data/data_sources/local/app_database.dart';
import 'features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'features/daily_news/domain/usecases/get_saved_article.dart';
import 'features/daily_news/domain/usecases/remove_article.dart';
import 'features/daily_news/domain/usecases/save_article.dart';
import 'features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'features/forum/data/repository/post_repository_impl.dart';
import 'features/forum/domain/usecases/post/delete_post_use_case.dart';
import 'features/forum/domain/usecases/post/like_unlike_post_use_case.dart';
import 'features/forum/domain/usecases/post/update_post_use_case.dart';
import 'package:http/http.dart' as http;
import 'package:moms_care/features/forum/presentation/bloc/post/post_state.dart';

import 'features/home/data/repositories/moms_care_repository_imp.dart';
import 'features/speech/data/repositories/speech_repostitorese_imp.dart';
import 'features/speech/domain/repositories/speech_repozitorese.dart';

final sl = GetIt.instance;

Future<void> init() async {

  //! External
  //? sharedPreferences
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  //? Client
  sl.registerLazySingleton(() => http.Client());
  //? InternetConnectionChecker
  sl.registerLazySingleton(() => InternetConnectionChecker());
  //? Dio
  sl.registerSingleton<Dio>(Dio());
  //?ApiService
  sl.registerSingleton<RemoteDioService>(RemoteDioService(sl()));

  //? Database
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // LocaleController
  // sl.registerSingleton<LocaleController>(LocaleController(sl()));

  //=============================
  //! Core
  sl.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImp(connectionChecker: sl()));


//? Repository

  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteRestApiDataSource: sl(),remoteFirebaseDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<FirebaseAuthApiService>(() => FirebaseAuthApiServiceImp(firebaseAuth: FirebaseAuth?.instance));

  sl.registerLazySingleton<FirebaseAuthRepository>(() => FirebaseAuthRepositoryImp(networkInfo: sl(),remoteDataSource: sl()));
  sl.registerLazySingleton<SpeechRepository>(() => SpeechRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<MomsCareRepository>(() => MomsCareRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));



  //? BLOC

  //AUTH
  sl.registerFactory(() => AuthBloc(
    siginUseCases: sl(),
    registerUseCases: sl(),
    registerDoctorUseCases: sl(),
    firebaseSignInUseCases: sl(),
    firebaseSignUpUseCases: sl(),
  ));

  // POST
  sl.registerFactory(() => PostBloc(
    getAllPostsUseCase: sl(),
    addPostUseCase: sl(),
    updatePostUseCase: sl(),
    likeUnLikePostUseCase: sl(),
    deletePostUseCase: sl(),
  ));

  // MomsCare
  sl.registerFactory(() => MomsCareBloc(getMomsCareItemsUseCase: sl()));

  // SpeechBloc
  sl.registerFactory(() => SpeechBloc(askAiUseCases: sl()));



  //? UseCase

  //Auth
  sl.registerLazySingleton(() => RegisterUseCases(sl()));
  sl.registerLazySingleton(() => SiginUseCases(sl()));
  sl.registerLazySingleton(() => RegisterDoctorUseCases(sl()));
  sl.registerLazySingleton(() => FirebaseSignInUseCases(sl()));
  sl.registerLazySingleton(() => FirebaseSignUpUseCases(sl()));

  // Post
  sl.registerLazySingleton(() => LikeUnLikePostUseCase(sl()));
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

// MomsCare
  sl.registerLazySingleton(() => GetMomsCareItemsUseCase(sl()));

  // Speech
  sl.registerLazySingleton(() => AskAiUseCases(sl()));



  //? Datasources
  //login
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(remoteDioService: sl(),baseUrl: BASE_URL));
  //Post
  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(remoteDioService: sl(),baseUrl:BASE_URL));

  //MomsCare
  sl.registerLazySingleton<MomsCareRemoteDataSource>(() => MomsCareRemoteDataSourceImpl(remoteDioService: sl(),baseUrl:BASE_URL));
  //Speech
  sl.registerLazySingleton<SpeechRemoteDataSource>(() => SpeechRemoteDataSourceImpl(remoteDioService: sl(),baseUrl:BASE_URL));

  // Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(
    ArticleRepositoryImpl(sl(),sl())
  );
  
  //UseCases
  sl.registerSingleton<GetArticleUseCase>(
    GetArticleUseCase(sl())
  );

  sl.registerSingleton<GetSavedArticleUseCase>(
    GetSavedArticleUseCase(sl())
  );

  sl.registerSingleton<SaveArticleUseCase>(
    SaveArticleUseCase(sl())
  );
  
  sl.registerSingleton<RemoveArticleUseCase>(
    RemoveArticleUseCase(sl())
  );

  //Blocs
  sl.registerFactory<RemoteArticlesBloc>(
    ()=> RemoteArticlesBloc(sl())
  );

  sl.registerFactory<LocalArticleBloc>(
    ()=> LocalArticleBloc(sl(),sl(),sl())
  );





}
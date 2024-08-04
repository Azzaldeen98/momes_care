import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:moms_care/core/constants/constants.dart';
import 'package:moms_care/features/auth/data/repositories/firebase/firebase_auth_repo_imp.dart';
import 'package:moms_care/features/auth/domain/usecases/refresh_fcm_token_use_case.dart';
import 'package:moms_care/features/broadcast_live/domain/usecases/stop_broadcast_live_use_case.dart';
import 'package:moms_care/features/courses/data/data_sourse/remote/courses_datasourse.dart';
import 'package:moms_care/features/courses/data/repositories/courses_repository_imp.dart';
import 'package:moms_care/features/courses/domain/repositories/courses_repository.dart';
import 'package:moms_care/features/courses/domain/usecases/add_course_item_usecase.dart';
import 'package:moms_care/features/courses/domain/usecases/add_course_usecase.dart';
import 'package:moms_care/features/courses/domain/usecases/delete_course_item_usecase.dart';
import 'package:moms_care/features/courses/domain/usecases/get_all_course_items_usecase.dart';
import 'package:moms_care/features/courses/domain/usecases/get_all_courses_usecase.dart';
import 'package:moms_care/features/courses/domain/usecases/update_course_item_usecase.dart';
import 'package:moms_care/features/courses/domain/usecases/upload_file_course_usecase.dart';
import 'package:moms_care/features/courses/persention/bloc/course_bloc.dart';
import 'package:moms_care/features/broadcast_live/data/data_sourse/remote/broadcast_live_datasourse.dart';
import 'package:moms_care/features/broadcast_live/data/repositories/broadcast_live_repository_imp.dart';
import 'package:moms_care/features/broadcast_live/domain/UseCases/get_my_broadcast_live_UseCase.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/broadcast_live.dart';
import 'package:moms_care/features/broadcast_live/domain/repositories/broadcast_live_repository.dart';
import 'package:moms_care/features/broadcast_live/domain/usecases/add_broadcast_live_usecase.dart';
import 'package:moms_care/features/broadcast_live/domain/usecases/delete_broadcast_live_use_case.dart';
import 'package:moms_care/features/broadcast_live/domain/usecases/update_broadcast_live_usecase.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_bloc.dart';
import 'package:moms_care/features/dashboard/data/dataSourse/remote/age_group_remote_datasourse.dart';
import 'package:moms_care/features/dashboard/data/dataSourse/remote/care_type_remote_datasourse.dart';
import 'package:moms_care/features/dashboard/data/dataSourse/remote/daily_care_times_remote_datasourse.dart';
import 'package:moms_care/features/dashboard/data/repositories/age_group_repostitorese_imp.dart';
import 'package:moms_care/features/dashboard/data/repositories/care_schedules_repository_impl.dart';
import 'package:moms_care/features/dashboard/data/repositories/care_type_repostitorese_imp.dart';
import 'package:moms_care/features/dashboard/data/repositories/daily_care_items_repostitorese_imp.dart';
import 'package:moms_care/features/dashboard/domain/repositories/age_group_repozitorese.dart';
import 'package:moms_care/features/dashboard/domain/repositories/care_schedules_repository.dart';
import 'package:moms_care/features/dashboard/domain/repositories/care_type_repozitorese.dart';
import 'package:moms_care/features/dashboard/domain/repositories/daily_care_times_repozitorese.dart';
import 'package:moms_care/features/dashboard/domain/usecases/age_group/create_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/age_group/delete_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/age_group/get_all_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/age_group/get_all_with_items_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/age_group/update_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/care_type/create_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/care_type/delete_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/care_type/get_all_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/care_type/get_all_with_items_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/care_type/update_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/daily_care_items/create_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/daily_care_items/delete_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/daily_care_items/get_all_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/daily_care_items/update_use_case.dart';
import 'package:moms_care/features/dashboard/domain/usecases/get_all_ageGroups_careTypes_use_case.dart';
import 'package:moms_care/features/dashboard/persention/bloc/dashboard/dashboard_bloc.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/add_update_delete_care_schedules_bloc.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/care_schedules_bloc.dart';

import 'package:moms_care/features/dashboard/persention/bloc/statistics/statistics_bloc.dart';
import 'package:moms_care/features/forum/data/dataSource/remote/post/posts_remote_data_source.dart';
import 'package:moms_care/features/forum/domain/repository/post_repository.dart';
import 'package:moms_care/features/forum/domain/usecases/Comment/like_unlike_Comment_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/add_post_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/details_post_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/get_all_posts_use_case.dart';
import 'package:moms_care/features/forum/presentation/bloc/posts/post_bloc.dart';
import 'package:moms_care/features/forum/presentation/bloc/posts/post_event.dart';
import 'package:moms_care/features/home/data/data_sourse/moms_care_datasourse.dart';
import 'package:moms_care/features/home/domain/repositories/moms_care_repository.dart';
import 'package:moms_care/features/home/domain/usecases/get_moms_care_items_usecase.dart';
import 'package:moms_care/features/home/persention/bloc/moms_care/moms_care_bloc.dart';
import 'package:moms_care/features/profile/data/dataSource/remote/babies/profile_babies_remote_data_source.dart';
import 'package:moms_care/features/profile/data/dataSource/remote/profile_remote_data_source.dart';
import 'package:moms_care/features/profile/data/repository/profile_babies_repository_impl.dart';
import 'package:moms_care/features/profile/data/repository/profile_repository_impl.dart';
import 'package:moms_care/features/profile/domain/repository/profile_babies_repository.dart';
import 'package:moms_care/features/profile/domain/repository/profile_repository.dart';
import 'package:moms_care/features/profile/domain/usecases/baby/add_baby_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/baby/delete_baby_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/baby/get_baby_daily_care_times_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/baby/update_baby_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/get_my_posts_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/get_author_info_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/get_profile_info_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/refresh_profile_info_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/update_user_email_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/update_user_name_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/update_user_password_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/upload_profile_image_use_case.dart';
import 'package:moms_care/features/profile/persention/bloc/baby/baby_bloc.dart';
import 'package:moms_care/features/speech/data/dataSourse/remote/speech_remote_datasourse.dart';
import 'package:moms_care/features/speech/domain/usecases/ask_gemini_ai_use_case.dart';
import 'package:moms_care/features/speech/persention/bloc/gemini/gemini_bloc.dart';
import 'package:moms_care/features/speech/persention/bloc/speech/speech_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/api_servers.dart';
import 'core/controller/work_on_servers/network/network_info.dart';
import 'core/local/locale_controller.dart';
import 'core/remote/api_service.dart';
import 'core/remote/gemini_ai_server/gemini_api_client.dart';
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
import 'features/courses/domain/usecases/delete_course_usecase.dart';
import 'features/courses/domain/usecases/update_course_usecase.dart';
import 'features/broadcast_live/domain/usecases/get_active_broadcast_live_usecase.dart';
import 'features/forum/data/dataSource/remote/comment/comments_remote_data_source.dart';
import 'features/forum/data/repository/comment_repository_impl.dart';
import 'features/forum/data/repository/post_repository_impl.dart';
import 'features/forum/domain/repository/Comment_repository.dart';
import 'features/forum/domain/usecases/Comment/add_Comment_use_case.dart';
import 'features/forum/domain/usecases/Comment/delete_Comment_use_case.dart';
import 'features/forum/domain/usecases/Comment/update_Comment_use_case.dart';
import 'features/forum/domain/usecases/comment/get_all_comments_use_case.dart';
import 'features/forum/domain/usecases/post/delete_post_use_case.dart';
import 'features/forum/domain/usecases/post/get_post_use_case.dart';
import 'features/forum/domain/usecases/post/like_unlike_post_use_case.dart';
import 'features/forum/domain/usecases/post/update_post_use_case.dart';
import 'package:http/http.dart' as http;
import 'package:moms_care/features/forum/presentation/bloc/posts/post_state.dart';

import 'features/forum/presentation/bloc/add_delete_update_comment/add_delete_update_comment_bloc.dart';
import 'features/forum/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'features/forum/presentation/bloc/comments/comment_bloc.dart';
import 'features/home/data/repositories/moms_care_repository_imp.dart';
import 'features/profile/persention/bloc/profile_bloc.dart';
import 'features/speech/data/repositories/speech_repostitorese_imp.dart';
import 'features/speech/domain/repositories/speech_repozitorese.dart';

final sl = GetIt.instance;

Future<void> init() async {

  //? *********************************
  //! External
  //? *********************************
  //? GeminiApiClient
  sl.registerLazySingleton(() => GeminiApiClient());

  //? sharedPreferences
   final sharedPreferences = await SharedPreferences.getInstance();
   sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  //? Client
  sl.registerLazySingleton(() => http.Client());
  //? InternetConnectionChecker
  sl.registerLazySingleton(() => InternetConnectionChecker());
  //? Dio
  sl.registerSingleton<Dio>(Dio());
  //?ApiService
  sl.registerSingleton<RemoteDioService>(RemoteDioService(sl()));
  // //?  Database
  // final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  // sl.registerSingleton<AppDatabase>(database);

//? *********************************
//!  --------- Core  ------------------
//? *********************************

  //? NetworkInfo
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(connectionChecker: sl()));
  //? FirebaseAuthApiService
  sl.registerLazySingleton<FirebaseAuthApiService>(() => FirebaseAuthApiServiceImp(firebaseAuth: FirebaseAuth?.instance));

//? *********************************
//? Repository
//? *********************************

  //? AuthRepository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteRestApiDataSource: sl(),remoteFirebaseDataSource: sl(), networkInfo: sl()));
  //? FirebaseAuthRepository
  sl.registerLazySingleton<FirebaseAuthRepository>(() => FirebaseAuthRepositoryImp(networkInfo: sl(),remoteDataSource: sl()));
  //? ProfileRepository
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  //? PostRepository
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  //? BabyRepository
  sl.registerLazySingleton<BabiesRepository>(() => BabiesRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  //? CommentRepository
  sl.registerLazySingleton<CommentRepository>(() => CommentRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  //? SpeechRepository
  sl.registerLazySingleton<SpeechRepository>(() => SpeechRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  //? MomsCareRepository
  sl.registerLazySingleton<CoursesRepository>(() => CoursesRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  //? BroadcastLiveRepository
  sl.registerLazySingleton<BroadcastLivesRepository>(() => BroadcastLivesRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  //? AgeGroupRepository
  sl.registerLazySingleton<AgeGroupRepository>(() => AgeGroupRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
//? CareTypeRepository
  sl.registerLazySingleton<CareTypeRepository>(() => CareTypeRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
//? DailyCareTimesRepository
  sl.registerLazySingleton<DailyCareTimesRepository>(() => DailyCareTimesRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
//? CareSchedulesRepository
  sl.registerLazySingleton<CareSchedulesRepository>(() => CareSchedulesRepositoryImpl(dailyCareTimesRemoteDataSource: sl(),
      ageGroupRemoteDataSource: sl(), careTypeRemoteDataSource: sl(), networkInfo: sl()));



//? *********************************
//? BLOCS
//? *********************************

  //AUTH
  sl.registerFactory(() => AuthBloc(
    siginUseCases: sl(),
    registerUseCases: sl(),
    registerDoctorUseCases: sl(),
    firebaseSignInUseCases: sl(),
    firebaseSignUpUseCases: sl(),
    refreshFcmTokenUseCase: sl()
  ));
  //Admin
  sl.registerFactory(() => DashboardBloc(
    getAllCoursesUseCase: sl(),
  ));
  sl.registerFactory(() => StatisticsBloc());

  sl.registerFactory(() => CareSchedulesBloc(
    getAllAgeGroupsUseCase: sl(),
    getAllCareTypesUseCase: sl(),
    getAllDailyCareTimesUseCase: sl(),
  ));

  sl.registerFactory(() => AddUpdateDeleteCareScheduleBloc(
    getAllAgeGroupsAndCareTypesUseCase: sl(),
    deleteDailyCareTimesUseCase: sl(),
    deleteCareTypeUseCase: sl(),
    deleteAgeGroupUseCase: sl(),
    createAgeGroupUseCase: sl(),
    createCareTypeUseCase: sl(),
    createDailyCareTimesUseCase: sl(),
    updateAgeGroupUseCase: sl(),
    updateCareTypeUseCase: sl(),
    updateDailyCareTimesUseCase: sl(),
  ));


  //Profile
  sl.registerFactory(() => ProfileBloc(
    getProfileInfoUseCase: sl(),
    getAuthorInfoUseCase: sl(),
    refreshProfileInfoUseCase: sl(),
    updateUserEmailUseCase: sl(),
    updateUserNameUseCase: sl(),
    updateUserPasswordUseCase: sl(),
      uploadProfileImageUseCase: sl(),
    // getMyPostsUseCase: sl(),
  ));

  //Baby
  sl.registerFactory(() => BabyBloc(
    addBabyUseCase: sl(),
    updateBabyUseCase: sl(),
    deleteBabyUseCase: sl(),
    getBabyDailyCareTimesUseCase: sl(),
  ));
  //ProfilePostBloc
  sl.registerFactory(() => ProfilePostBloc(
    getMyPostsUseCase: sl(),
  ));
  //POST
  sl.registerFactory(() => PostBloc(
    getAllPostsUseCase: sl(),
    likeUnLikePostUseCase: sl(),
    likeUnLikeCommentUseCase:  sl(),
    getPostUseCase:  sl(),
  ));
  //Comment
  sl.registerFactory(() => CommentBloc(
    getAllCommentsUseCase: sl(),
    likeUnLikeCommentUseCase: sl(),
  ));
  //AddDeleteUpdatePost
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
    addPostUseCase: sl(),
    updatePostUseCase: sl(),
    deletePostUseCase: sl(),
    addCommentUseCase: sl(),
    updateCommentUseCase: sl(),
    deleteCommentUseCase: sl(),
  ));
  //AddDeleteUpdateComment
  sl.registerFactory(() => AddDeleteUpdateCommentBloc(
    addCommentUseCase: sl(),
    updateCommentUseCase: sl(),
    deleteCommentUseCase: sl(),
  ));
  //MomsCare
  sl.registerFactory(() => MomsCareBloc(getMomsCareItemsUseCase: sl()));
  //Speech
  sl.registerFactory(() => SpeechBloc());
  sl.registerFactory(() => GeminiBloc( askGeminiAiUseCase: sl()));
  //Course
  sl.registerFactory(() => CourseBloc(
          getAllCoursesUseCase: sl(),
          getAllCourseItemsUseCase: sl(),
          uploadFileCourseUseCase: sl(),
          addCourseUsecase: sl(),
          updateCourseUsecase: sl(),
          deleteCourseUsecase: sl(),
          addCourseItemUseCase: sl(),
          deleteCourseItemUseSase: sl(),
          updateCourseItemUseCase: sl(),

  ));
  //BroadcastLives
  sl.registerFactory(() => BroadcastLiveBloc(
          getMyBroadcastLiveUseCase: sl(),
          stopBroadcastLiveUseCase: sl(),
          getActivesBroadcastLiveUseCase: sl(),
          addBroadcastLiveUseCase: sl(),
          updateBroadcastLiveUseCase: sl(),
          deleteBroadcastLiveUseCase: sl(),
  ));

//? *********************************
//? UseCase
//? *********************************

  //-----------------
  //Auth
  //-----------------
  sl.registerLazySingleton(() => RegisterUseCases(sl()));
  sl.registerLazySingleton(() => SiginUseCases(sl()));
  sl.registerLazySingleton(() => RegisterDoctorUseCases(sl()));
  sl.registerLazySingleton(() => FirebaseSignInUseCases(sl()));
  sl.registerLazySingleton(() => FirebaseSignUpUseCases(sl()));
  sl.registerLazySingleton(() => RefreshFcmTokenUseCase(sl()));
  //-----------------
  //Profile
  //-----------------
  sl.registerLazySingleton(() => GetMyPostsUseCase(sl()));
  sl.registerLazySingleton(() => RefreshProfileInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetProfileInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetAuthorInfoUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserNameUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserEmailUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserPasswordUseCase(sl()));
  sl.registerLazySingleton(() => UploadProfileImageUseCase(sl()));
  //-----------------
  //Baby
  //-----------------

  sl.registerLazySingleton(() => AddBabyUseCase(sl()));
  sl.registerLazySingleton(() => UpdateBabyUseCase(sl()));
  sl.registerLazySingleton(() => DeleteBabyUseCase(sl()));
  sl.registerLazySingleton(() => GetBabyDailyCareTimesUseCase(sl()));

  //-----------------
  // Post
  //-----------------
  sl.registerLazySingleton(() => LikeUnLikePostUseCase(sl()));
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => GetPostUseCase(sl()));
  sl.registerLazySingleton(() => AddPostCommentUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DetailsPostUseCase());
  //-----------------
  // Comment
  //-----------------
  sl.registerLazySingleton(() => AddNewCommentUseCase(sl()));
  sl.registerLazySingleton(() => LikeUnLikeCommentUseCase(sl()));
  sl.registerLazySingleton(() => GetAllCommentsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCommentUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCommentUseCase(sl()));
  //-----------------
  // MomsCare
  //-----------------
  sl.registerLazySingleton(() => GetMomsCareItemsUseCase(sl()));
  //-----------------
  // Speech
  //-----------------
  sl.registerLazySingleton(() => AskGeminiAiUseCase(sl()));

  //-----------------
  // Courses
  //-----------------
  sl.registerLazySingleton(() => GetAllCoursesUseCase(sl()));
  sl.registerLazySingleton(() => GetAllCourseItemsUseCase(sl()));
  sl.registerLazySingleton(() => UploadFileCourseUseCase(sl()));
  sl.registerLazySingleton(() => AddCourseUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCourseUsecase(sl()));
  sl.registerLazySingleton(() => DeleteCourseUsecase(sl()));
  sl.registerLazySingleton(() => AddCourseItemUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCourseItemUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCourseItemUseSase(sl()));
  //-----------------
  // BroadcastLives
  //-----------------
  sl.registerLazySingleton(() => GetMyBroadcastLiveUseCase(sl()));
  sl.registerLazySingleton(() => GetActivesBroadcastLiveUseCase(sl()));
  sl.registerLazySingleton(() => AddBroadcastLiveUseCase(sl()));
  sl.registerLazySingleton(() => UpdateBroadcastLiveUseCase(sl()));
  sl.registerLazySingleton(() => DeleteBroadcastLiveUseCase(sl()));
  sl.registerLazySingleton(() => StopBroadcastLiveUseCase(sl()));
  //-----------------
  // AgeGroup
  //-----------------
  sl.registerLazySingleton(() => UpdateAgeGroupUseCase(sl()));
  sl.registerLazySingleton(() => CreateAgeGroupUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAgeGroupUseCase(sl()));
  sl.registerLazySingleton(() => GetAllAgeGroupsUseCase(sl()));
  sl.registerLazySingleton(() => GetAllAgeGroupsWithItemsUseCase(sl()));
  //-----------------
  // CareType
  //-----------------
  sl.registerLazySingleton(() => UpdateCareTypeUseCase(sl()));
  sl.registerLazySingleton(() => CreateCareTypeUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCareTypeUseCase(sl()));
  sl.registerLazySingleton(() => GetAllCareTypesUseCase(sl()));
  sl.registerLazySingleton(() => GetAllCareTypesWithItemsUseCase(sl()));
  //-----------------
  // DailyCareTimes
  //-----------------
  sl.registerLazySingleton(() => UpdateDailyCareTimesUseCase(sl()));
  sl.registerLazySingleton(() => CreateDailyCareTimesUseCase(sl()));
  sl.registerLazySingleton(() => DeleteDailyCareTimesUseCase(sl()));
  sl.registerLazySingleton(() => GetAllDailyCareTimesUseCase(sl()));
  //-----------------
  // CareSchedules
  //-----------------
  sl.registerLazySingleton(() => GetAllAgeGroupsAndCareTypesUseCase(sl()));


  //? DataSources

  //Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(remoteDioService: sl(),baseUrl: BASE_URL));
  //Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(remoteDioService: sl(),baseUrl:BASE_URL));
  //Baby
  sl.registerLazySingleton<BabiesRemoteDataSource>(() => BabiesRemoteDataSourceImpl(remoteDioService: sl(),baseUrl:BASE_URL));
  //Post
  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(remoteDioService: sl(),baseUrl:BASE_URL));
  //Comment
  sl.registerLazySingleton<CommentRemoteDataSource>(() => CommentRemoteDataSourceImpl(remoteDioService: sl(),baseUrl:BASE_URL));
  //MomsCare
  sl.registerLazySingleton<MomsCareRemoteDataSource>(() => MomsCareRemoteDataSourceImpl(remoteDioService: sl(),baseUrl:BASE_URL));
  //Speech
  sl.registerLazySingleton<SpeechRemoteDataSource>(() => SpeechRemoteDataSourceImpl(geminiApiClient:sl()));
  //Course
  sl.registerLazySingleton<CourseRemoteDataSource>(() => CourseRemoteDataSourceImpl(remoteDioService:sl(),baseUrl:BASE_URL));
  //BroadcastLive
  sl.registerLazySingleton<BroadcastLiveRemoteDataSource>(() => BroadcastLiveRemoteDataSourceImpl(remoteDioService:sl(),baseUrl:BASE_URL));
  //DailyCareTimes
  sl.registerLazySingleton<DailyCareTimesRemoteDataSource>(() => DailyCareTimesRemoteDataSourceImpl(remoteDioService:sl(),baseUrl:BASE_URL));
  //CareTypes
  sl.registerLazySingleton<CareTypeRemoteDataSource>(() => CareTypeRemoteDataSourceImpl(remoteDioService:sl(),baseUrl:BASE_URL));
  //AgeGroups
  sl.registerLazySingleton<AgeGroupRemoteDataSource>(() => AgeGroupRemoteDataSourceImpl(remoteDioService:sl(),baseUrl:BASE_URL));









}
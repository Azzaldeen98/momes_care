

import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/constants/api_servers.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/features/profile/domain/usecases/get_profile_info_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/refresh_profile_info_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/update_user_name_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/update_user_password_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/upload_profile_image_use_case.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_event.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_state.dart';

import 'package:moms_care/core/error/message_failure_message.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import '../../domain/usecases/get_my_posts_use_case.dart';
import '../../domain/usecases/update_user_email_use_case.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{

  final UploadProfileImageUseCase uploadProfileImageUseCase;
  final GetProfileInfoUseCase getProfileInfoUseCase;
  final RefreshProfileInfoUseCase refreshProfileInfoUseCase;
  final UpdateUserNameUseCase updateUserNameUseCase;
  final UpdateUserEmailUseCase updateUserEmailUseCase;
  final UpdateUserPasswordUseCase updateUserPasswordUseCase;


  ProfileBloc({
    required this.getProfileInfoUseCase,
    required this.refreshProfileInfoUseCase,
    required this.updateUserNameUseCase,
    required this.updateUserEmailUseCase,
    required this.updateUserPasswordUseCase,
    required this.uploadProfileImageUseCase,
    }):super(ProfileInitialState()){

    on<RefreshProfileInfoEvent>(_refreshProfileInfo);
    on<GetProfileInfoEvent>(_getProfileInfo);
    on<UpdateUserNameEvent>(_updateUserName);
    on<UpdateUserEmailEvent>(_updateEmailName);
    on<UpdateUserPasswordEvent>(_updatePasswordName);
    on<UploadProfileImageEvent>(_uploadProfileImage);
    on<GoToProfilePageEvent>(_goToPageEvent);
  }

  FutureOr<void> _refreshProfileInfo(RefreshProfileInfoEvent event, Emitter<ProfileState> emit) async{

    emit(const LoadingProfileState());
    final failureOrProfileInfo=await refreshProfileInfoUseCase();
    failureOrProfileInfo.fold(
        (failure){
          emit(ErrorProfileState(message: mapFailureToMessage(failure)));
        },
        (info){
          emit(LoadedProfileState(profile: info));
        });
  }
  FutureOr<void> _getProfileInfo(GetProfileInfoEvent event, Emitter<ProfileState> emit) async{

    emit(const LoadingProfileState());
    final failureOrProfileInfo=await getProfileInfoUseCase();
    failureOrProfileInfo.fold(
        (failure){
          // Get.back();
          emit(ErrorProfileState(message: mapFailureToMessage(failure)));
        },
        (info){
              emit(LoadedProfileState(profile: info));
            });
  }
  FutureOr<void> _updateUserName(UpdateUserNameEvent event, Emitter<ProfileState> emit) async {
    emit(const LoadingProfileUpdateState());
    final failureOrSuccess=await updateUserNameUseCase(event.name);
    failureOrSuccess.fold(
          (failure){
          emit(ErrorProfileState(message: mapFailureToMessage(failure)));
        }, (_){
          emit(UpdateProfileUserInfoSuccessState(message: UPDATE_SUCCESS_MESSAGE));
        });
  }
  FutureOr<void> _updateEmailName(UpdateUserEmailEvent event, Emitter<ProfileState> emit) async{

    emit(const LoadingProfileUpdateState());

    final failureOrSuccess=await updateUserEmailUseCase(pass: event.currentPass,email:event.email);
    failureOrSuccess.fold(
            (failure){

          emit(ErrorProfileState(message: mapFailureToMessage(failure)));
        }, (_){
          emit(UpdateProfileUserInfoSuccessState(message: UPDATE_SUCCESS_MESSAGE,requiredSignOut: true));
        });

  }
  FutureOr<void> _updatePasswordName(UpdateUserPasswordEvent event, Emitter<ProfileState> emit) async{

    emit(const LoadingProfileUpdateState());
    final failureOrSuccess=await updateUserPasswordUseCase(event.currentPassword,event.newPassword);
    failureOrSuccess.fold(
            (failure){
          // Get.back();
          emit(ErrorProfileState(message: mapFailureToMessage(failure)));
        },
            (_){
          emit(UpdateProfileUserInfoSuccessState(message: UPDATE_SUCCESS_MESSAGE,requiredSignOut: true));
        });
  }

  Future<void> uploadFile(File file) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String fileName = Path.basename(file.path);
      Reference ref = storage.ref().child('uploads/$fileName');
      UploadTask uploadTask = ref.putFile(file);

      await uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        print('File uploaded. Download URL: $downloadURL');
      });
    } on FirebaseException catch (e) {
      print('Error occurred: $e');
    }
  }

  FutureOr<void> _uploadProfileImage(UploadProfileImageEvent event, Emitter<ProfileState> emit) async{

    emit(const LoadingProfileUpdateState());

    final failureOrSuccess=await uploadProfileImageUseCase(event.image,event.oldUrl);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorUpdateProfileState(message: mapFailureToMessage(failure)));
        }, (urlImage){

          emit(UploadImageSuccessfulState( urlImage: urlImage));
        });
  }

  // Future<void> uploadImage(File image, String? oldUrl) async {
  //
  //   try {
  //     Reference ref;
  //     String dynamicImage = DateTime.now().toIso8601String();
  //     String email = Helper.auth?.userInfo?.email ?? "";
  //     var imagename = '$ID_IMAGE_PROFILE${email}_$dynamicImage';
  //     ref = FirebaseStorage.instance.ref("images").child(imagename);
  //     await ref.putFile(image);
  //     var urlImage = await ref.getDownloadURL();
  //     emit(UploadImageSuccessfulState(urlImage: urlImage));
  //   } catch (e) {
  //     emit(ErrorUpdateProfileState(message: "The image was not uploaded".tr));
  //   }
  //
  // }
  FutureOr<void> _goToPageEvent(GoToProfilePageEvent event, Emitter<ProfileState> emit) {
    emit(LoadingProfileState());
    emit(GoToProfilePageState(page:event.page));
  }



}

class ProfilePostBloc extends Bloc<ProfilePostEvent,ProfilePostState>{

  final GetMyPostsUseCase getMyPostsUseCase;

  ProfilePostBloc({
    required this.getMyPostsUseCase,
  }):super(ProfilePostInitial()){

    on<GetMyPostsEvent>(_getMyPosts);
  }

  FutureOr<void> _getMyPosts(GetMyPostsEvent event, Emitter<ProfilePostState> emit) async {

    print("Loading my posts");
    emit(LoadingProfilePostState());
    final failureOrPosts=await getMyPostsUseCase();
    failureOrPosts.fold( (failure){
      Get.back();
      emit(ErrorProfilePostState(message: mapFailureToMessage(failure)));
    }, (posts){
          print("Loaded my posts: ${posts!.length}");
          emit(LoadedMyPostsState(posts: posts));
        });
  }

}
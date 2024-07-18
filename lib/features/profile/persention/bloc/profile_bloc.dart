

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
import 'package:moms_care/features/profile/domain/usecases/update_user_name_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/update_user_password_use_case.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_event.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_state.dart';

import 'package:moms_care/core/error/message_failure_message.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import '../../domain/usecases/get_my_posts_use_case.dart';
import '../../domain/usecases/update_user_email_use_case.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{

  // final GetMyPostsUseCase getMyPostsUseCase;
  final GetProfileInfoUseCase getProfileInfoUseCase;
  final UpdateUserNameUseCase updateUserNameUseCase;
  final UpdateUserEmailUseCase updateUserEmailUseCase;
  final UpdateUserPasswordUseCase updateUserPasswordUseCase;

  ProfileBloc({
    required this.getProfileInfoUseCase,
    required this.updateUserNameUseCase,
    required this.updateUserEmailUseCase,
    required this.updateUserPasswordUseCase,
    }):super(ProfileInitialState()){

    // on<GetMyPostsEvent>(_getMyPosts);
    on<GetProfileInfoEvent>(_getProfileInfo);
    on<UpdateUserNameEvent>(_updateUserName);
    on<UpdateUserEmailEvent>(_updateEmailName);
    on<UpdateUserPasswordEvent>(_updatePasswordName);
    on<GoToProfilePageEvent>(_goToPageEvent);
  }

  // FutureOr<void> _getMyPosts(GetMyPostsEvent event, Emitter<ProfileState> emit) async {
  //
  //   // emit(LoadingProfileState());
  //   // final failureOrPosts=await getMyPostsUseCase();
  //   // failureOrPosts.fold( (failure){
  //   //   Get.back();
  //   //   emit(ErrorProfileState(message: mapFailureToMessage(failure)));
  //   // },
  //   // (posts){
  //   //       emit(LoadedMyPostsState(posts: posts));
  //   //   });
  // }
  FutureOr<void> _getProfileInfo(GetProfileInfoEvent event, Emitter<ProfileState> emit) async{

    emit(LoadingProfileState());
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
    emit(LoadingProfileUpdateState());
    final failureOrSuccess=await updateUserNameUseCase(event.name);
    failureOrSuccess.fold(
            (failure){
          // Get.back();
          emit(ErrorProfileState(message: mapFailureToMessage(failure)));
        },
            (info){
          emit(UpdateProfileUserInfoSuccessState(message: UPDATE_SUCCESS_MESSAGE));
        });
  }

  FutureOr<void> _updateEmailName(UpdateUserEmailEvent event, Emitter<ProfileState> emit) async{
    emit(LoadingProfileUpdateState());
    final failureOrSuccess=await updateUserEmailUseCase(event.email);
    failureOrSuccess.fold(
            (failure){
          // Get.back();
          emit(ErrorProfileState(message: mapFailureToMessage(failure)));
        },
            (info){
          emit(UpdateProfileUserInfoSuccessState(message: UPDATE_SUCCESS_MESSAGE));
        });

  }

  FutureOr<void> _updatePasswordName(UpdateUserPasswordEvent event, Emitter<ProfileState> emit) async{

    emit(LoadingProfileUpdateState());
    final failureOrSuccess=await updateUserPasswordUseCase(event.currentPassword,event.newPassword);
    failureOrSuccess.fold(
            (failure){
          // Get.back();
          emit(ErrorProfileState(message: mapFailureToMessage(failure)));
        },
            (info){
          emit(UpdateProfileUserInfoSuccessState(message: UPDATE_SUCCESS_MESSAGE));
        });
  }

  Future<void> uploadImage(File image, String? oldUrl) async {
    emit(LoadingProfileUpdateState());
    try {
      Reference ref;
      String dynamicImage = DateTime.now().toIso8601String();
      String email = Helper.auth?.userInfo?.email ?? "";
      var imagename = '$ID_IMAGE_PROFILE${email}_$dynamicImage';
      ref = FirebaseStorage.instance.ref("images").child(imagename);
      await ref.putFile(image);
      var urlImage = await ref.getDownloadURL();
      emit(UploadImageSuccessfulState(urlImage: urlImage));
    } catch (e) {
      emit(ErrorUpdateProfileState(message: "The image was not uploaded".tr));
    }

  }
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
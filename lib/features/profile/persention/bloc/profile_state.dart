
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:moms_care/core/constants/enam/profile_pages.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';

import '../../../forum/domain/entities/Post.dart';
import '../../domain/entities/baby_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}
class ProfileInitialState extends ProfileState{
  const ProfileInitialState();
}
class LoadingProfileState extends ProfileState{
  const LoadingProfileState();
}
class LoadingProfileUpdateState extends ProfileState{
  const LoadingProfileUpdateState();
}

class UploadImageSuccessfulState extends ProfileState{
  final String urlImage;
  const UploadImageSuccessfulState({required this.urlImage});
}

class UpdateProfileSuccessfulState extends ProfileState {
  const UpdateProfileSuccessfulState({required this.profileInfo});
  final Profile profileInfo;
}

class GoToProfilePageState extends ProfileState{
  const GoToProfilePageState( {required this.page});
  final ProfilePage page;
  @override
  List<Object> get props => [page];
}
class LoadedProfileState extends ProfileState{
  const LoadedProfileState( {required this.profile});
  final Profile profile;
  @override
  List<Object> get props => [profile];
}
class LoadedBabiesState extends ProfileState{
  const LoadedBabiesState({required this.babies});
  final List<Baby> babies;

  @override
  List<Object> get props => [babies];
}

class UpdateProfileUserInfoSuccessState extends ProfileState{
  const UpdateProfileUserInfoSuccessState( {required this.message,this.requiredSignOut=false});
  final String message;
  final bool requiredSignOut;
  @override
  List<Object> get props => [message];
}
class AddUpdateDeleteProfileSuccessState extends ProfileState{
  const AddUpdateDeleteProfileSuccessState( {required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
class ErrorUpdateProfileState extends ProfileState {
  final String message;
  const ErrorUpdateProfileState({required this.message});
  @override
  List<Object> get props => [message];
}


class ErrorProfileState extends ProfileState {
  final String message;
  const ErrorProfileState({required this.message});
  @override
  List<Object> get props => [message];
}

//*************************************************************************************

abstract class ProfilePostState extends Equatable {
  const ProfilePostState();
  @override
  List<Object> get props => [];
}
class ProfilePostInitial extends ProfilePostState{
  const ProfilePostInitial();
}
class LoadedMyPostsState extends ProfilePostState{
  const LoadedMyPostsState({required this.posts});
  final List<Post> posts;

  @override
  List<Object> get props => [posts];
}
class LoadingProfilePostState extends ProfilePostState{
  const LoadingProfilePostState();
}
class ErrorProfilePostState extends ProfilePostState {
  final String message;
  const ErrorProfilePostState({required this.message});
  @override
  List<Object> get props => [message];
}

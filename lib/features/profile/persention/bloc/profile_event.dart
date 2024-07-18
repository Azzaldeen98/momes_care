


import 'package:equatable/equatable.dart';

import 'package:moms_care/core/constants/enam/profile_pages.dart';


abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}
class GetProfileInfoEvent extends ProfileEvent{
   const GetProfileInfoEvent();
 }
class UpdateUserNameEvent extends ProfileEvent{
  final String name;
  const UpdateUserNameEvent({required this.name});
}
class UpdateUserEmailEvent extends ProfileEvent{
  final String email;
  const UpdateUserEmailEvent({required this.email});
}
class UpdateUserPasswordEvent extends ProfileEvent{
  final String currentPassword;
  final String newPassword;

  const UpdateUserPasswordEvent({
    required this.currentPassword,
    required this.newPassword});
}


class GoToProfilePageEvent extends ProfileEvent{
  final ProfilePage page;
  const GoToProfilePageEvent({required this.page,});
}




abstract class ProfilePostEvent extends Equatable {
  const ProfilePostEvent();
  @override
  List<Object> get props => [];
}
class GetMyPostsEvent extends ProfilePostEvent{
  const GetMyPostsEvent();
}





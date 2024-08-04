





import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/cached/cached_name.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/constants/enam/profile_pages.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/helpers/cache_helper.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/utils/function/set_remove_auth.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/state/loading_widget.dart';
import 'package:moms_care/features/auth/persention/page/auth_view.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_bloc.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_event.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_state.dart';
import 'package:moms_care/features/profile/persention/pages/edit_profile_page.dart';
import 'package:moms_care/features/profile/persention/pages/profile_page.dart';
import 'package:moms_care/features/profile/persention/widget/form_edit_user_email_widget.dart';
import 'package:moms_care/features/profile/persention/widget/form_EDIT_USER_PASSWORD_widget.dart';

import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/widget/button/item_memu_button_widget.dart';
import 'package:moms_care/core/widget/text_field/text_entry_field.dart';
import 'package:moms_care/core/widget/text_field/text_field_widget.dart';
import '../widget/form_edit_user_name_widget.dart';

class ProfileView extends StatefulWidget{
  const ProfileView({super.key, this.profilePage=ProfilePage.EDIT_PROFILE,this.profile});

   final ProfilePage? profilePage;
   final Profile? profile;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState  extends State<ProfileView>{

  ProfilePage? profilePage;
  bool _isLoading=true;
  BuildContext? _blocContext;
  @override
  void initState() {
    profilePage=widget.profilePage;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBarPageWidget(pageName: "Edit profile".tr,) ,
      body:BlocConsumer<ProfileBloc,ProfileState>(
        builder: _builderPageProfileBloc,
        listener: _listenerPageProfileBloc,),
    );
  }

  Widget _builderPageProfileBloc(BuildContext context, ProfileState state) {
    _blocContext=context;
    if(state is ProfileInitialState){
      return _goToProfilePage(profilePage=ProfilePage.EDIT_PROFILE);
    }
    if(state is GoToProfilePageState){
      Get.back();
       return _goToProfilePage(profilePage=state.page!);
    } else{
      Get.back();
      return _goToProfilePage(profilePage=ProfilePage.EDIT_PROFILE);
    }
  }

  void _listenerPageProfileBloc(BuildContext context, ProfileState state) {
    _blocContext=context;
    if (state is LoadingProfileUpdateState) {
      setState(() =>_isLoading=true);
      // LoadingScreen.show(context, WAIT_MESSAGE);
      // AwesomeDialog(context: context,dialogType: DialogType.);
      // SnackBarBuilder.ShowError(context: context,message:"Start");
      MessageBox.showProgress(context,WAIT_MESSAGE);
    }
    if (state is ErrorProfileState) {
      setState(() =>_isLoading=false);
       Get.back();
       SnackBarBuilder.ShowError(context: context,message:state.message);
      // setState(() {});
    }else  if(state is UpdateProfileUserInfoSuccessState){
      setState(() =>_isLoading=false);
      Get.back();
      CacheHelper.removeAt(PROFILE_INFO_CACHED);
      SnackBarBuilder.ShowSuccess(context: context ,message:state.message);
      if(state.requiredSignOut){
        removeAuth();
        Get.off(const AuthView());
      }
      else{
        Get.off(HomePage(numberScreen: AppPages.PROFILE.index,));
      }
      // setState(() {
      //   profilePage=ProfilePage.EDIT_PROFILE;
      // });
    }else {
      setState(() =>_isLoading=false);
      Get.back();
    }

  }

  Widget _goToProfilePage(ProfilePage profilePage) {

    if (profilePage == ProfilePage.EDIT_USER_NAME) {
      return  FormEditUserNameWidget(name: widget.profile!.displayName!, onUpdate: onUpdateName,);
    } else if (profilePage == ProfilePage.EDIT_USER_EMAIL) {
      return  FormEditUserEmailWidget(email: widget.profile!.email!,onUpdate:onUpdateEmail ,);
    }   else if (profilePage == ProfilePage.EDIT_USER_PASSWORD) {
      return  FormEditUserPasswordWidget(onUpdate: (cPass,nPass)=>
          onChangedPassword(currentPass: cPass,newPass: nPass));
    }  else if (profilePage == ProfilePage.EDIT_PROFILE) {
      return  EditProfilePage(profile: widget.profile);
    } else{
      return const SizedBox();
    }

  }

  void onUpdateName(String name) async{
    Get.back();
    BlocProvider.of<ProfileBloc>(_blocContext!).add(UpdateUserNameEvent(name:name));
  }

  void onUpdateEmail(String email,String pass) async{
    BlocProvider.of<ProfileBloc>(_blocContext!).add(UpdateUserEmailEvent(currentPass: pass,email: email));
  }

  void onChangedPassword({String? currentPass,String? newPass}) async{
    BlocProvider.of<ProfileBloc>(_blocContext!).add(UpdateUserPasswordEvent(currentPassword: currentPass!,newPassword: newPass!));
  }
}


// class LoadingScreen {
//   LoadingScreen._();
//
//   static show(BuildContext context, String text) {
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return Dialog(
//             elevation: 0,
//             backgroundColor: Colors.transparent,
//             child: _customDialog(context, text),
//           );
//         });
//   }
//
//   static hide(BuildContext context) {
//     Navigator.pop(context);
//   }
//
//   static _customDialog(BuildContext context, String text) {
//     return Container(
//       child: Center(
//         child: Container(
//           decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.5),
//               shape: BoxShape.rectangle,
//               borderRadius: BorderRadius.circular(10)),
//           child: Padding(
//             padding: EdgeInsets.all(30),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 CircularProgressIndicator(
//                   strokeWidth: 10,
//                   valueColor: AlwaysStoppedAnimation(Colors.black),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 20),
//                 ),
//                 Text(
//                   text,
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.w600),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
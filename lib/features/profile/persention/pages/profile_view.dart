





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/enam/profile_pages.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_bloc.dart';
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
  const ProfileView({this.profilePage=ProfilePage.EDIT_PROFILE,this.profile});

   final ProfilePage? profilePage;
   final Profile? profile;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState  extends State<ProfileView>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBarPageWidget(pageName: "Edit profile".tr,) ,
      body:BlocConsumer<ProfileBloc,ProfileState>(
        builder: _builderPageProfileBloc,
        listener: _listenerPageProfileBloc,),
    );
  }

  Widget _buildBodyWidget() {

    return Container(
      child: Column(
        children: [
          ItemMenuButtonWidget(title: "Edit name".tr, icon:Icons.edit ,
            onPress: () {},endIcon: true,),
          ItemMenuButtonWidget(title: "Edit email".tr, icon:Icons.edit ,
            onPress: () {},endIcon: true,),
          ItemMenuButtonWidget(title: "Edit password".tr, icon:Icons.edit ,
            onPress: () {},endIcon: true,),
        ],
      ),
    );
  }

  void _onEditName() async{
    // Get.put();
  }
  void _onEditEmail() async{}
  void _onEditPassword() async{}

  Widget _builderPageProfileBloc(BuildContext context, ProfileState state) {
    if(state is ProfileInitialState){
      return _goToProfilePage(ProfilePage.EDIT_PROFILE);
    }
    if(state is GoToProfilePageState){
      Get.back();
       return _goToProfilePage(state.page!);
    }
    else{
      return SizedBox(); //_goToProfilePage(ProfilePage.EDIT_PROFILE);
    }
  }

  void _listenerPageProfileBloc(BuildContext context, ProfileState state) {
    if (state is ErrorProfileState) {
      Get.back();
      MessageBox.showError(context, state.message);
    }else  if(state is GoToProfilePageState){
      Get.back();
    }

  }

Widget _goToProfilePage(ProfilePage profilePage) {

    if (profilePage == ProfilePage.EDIT_USER_NAME) {
      return  FormEditUserNameWidget(name: widget.profile!.displayName!,);
    } else if (profilePage == ProfilePage.EDIT_USER_EMAIL) {
      return  FormEditUserEmailWidget(email: widget.profile!.email!,);
    }   else if (profilePage == ProfilePage.EDIT_USER_PASSWORD) {
      return  FormEditUserPasswordWidget();
    }  else if (profilePage == ProfilePage.EDIT_PROFILE) {
      return  EditProfilePage(profile: widget.profile);
    } else{
      return SizedBox();
    }

  }
}
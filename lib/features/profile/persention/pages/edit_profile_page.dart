

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';
import 'package:moms_care/features/profile/persention/widget/form_edit_user_email_widget.dart';
import 'package:moms_care/features/profile/persention/widget/form_edit_user_name_widget.dart';
import 'package:moms_care/features/profile/persention/widget/form_EDIT_USER_PASSWORD_widget.dart';
import 'package:moms_care/core/constants/enam/profile_pages.dart';
import 'package:moms_care/core/widget/button/item_memu_button_widget.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import '../widget/back_button_widget.dart';

class EditProfilePage extends StatefulWidget{
  const EditProfilePage({Key? key,this.profile}) : super(key: key);

   final Profile? profile;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState  extends State<EditProfilePage>{

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  ProfilePage profilePage=ProfilePage.EDIT_PROFILE;
  @override
  Widget build(BuildContext context) {
   return KeyboardVisibilityBuilder(
       builder: (context, isKeyboardVisible) {
           return Scaffold(
             appBar: AppBarPageWidget(pageName: "Edit profile".tr,),
             // bottomNavigationBar: Helper.buttonNavigation,
             body: SingleChildScrollView(
                 padding: EdgeInsets.only(bottom: isKeyboardVisible ? MediaQuery.of(context).viewInsets.bottom : 0,),
                 child: _buildBodyPageWidget()),
           );
   });
  }

  Widget _buildBodyPageWidget() {

    return Container(
      padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.only(top: 0),
      child: Column(
        children: [
          _buildProfileEditWidget(),
          _buildProfileEditViewWidget(ProfilePage.EDIT_USER_NAME,
              FormEditUserNameWidget(name: widget.profile!.displayName!,)),
          _buildProfileEditViewWidget(ProfilePage.EDIT_USER_EMAIL,
              FormEditUserEmailWidget(email: widget.profile!.email!,)),
          _buildProfileEditViewWidget(ProfilePage.EDIT_USER_PASSWORD,
              FormEditUserPasswordWidget()),
        ],
      ),
    );
  }

  
  Widget _buildProfileEditWidget(){
   return Visibility(
      visible: profilePage ==ProfilePage.EDIT_PROFILE,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBackButtonWidget(onPressed: ()=> Get.offAll(HomePage(numberScreen: 3,)),width: 30),
          SizedBox(height: 100,),
          ItemMenuButtonWidget(title: "Edit name".tr, icon:Icons.person_outline ,
            onPress: onEditName,endIcon: true,),
          Divider(),
          ItemMenuButtonWidget(title: "Edit email".tr, icon:Icons.email_outlined ,
            onPress:onEditEmail,endIcon: true,),
          Divider(),
          ItemMenuButtonWidget(title: "Edit password".tr, icon:Icons.password_outlined ,
            onPress: onEditPassword,endIcon: true,),
          Divider(),


        ],
      ),
    );
  }
  Widget _buildProfileEditViewWidget(ProfilePage comparePage,Widget page){
    return Visibility(
        visible: this.profilePage == comparePage,
        child:Align(
          alignment: Alignment.topCenter,
          // color: Colors.green,
          // height: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 0,),
              buildBackButtonWidget(onPressed:(){
          setState(()=>profilePage=ProfilePage.EDIT_PROFILE);
        } ,width:30),
              SizedBox(height: 100,),
              page,
            ],
          ),
        ));
  }



  void onEditName() async{
    setState(()=>profilePage=ProfilePage.EDIT_USER_NAME);
    // BlocProvider.of<ProfileBloc>(context).add(GoToProfilePageEvent(page:ProfilePage.EDIT_USER_NAME));
  }
  void onEditEmail() async{
    setState(()=>profilePage=ProfilePage.EDIT_USER_EMAIL);
    // BlocProvider.of<ProfileBloc>(context).add(GoToProfilePageEvent(page:ProfilePage.EDIT_USER_EMAIL));
  }
  void onEditPassword() async{
    setState(()=>profilePage=ProfilePage.EDIT_USER_PASSWORD);
    // BlocProvider.of<ProfileBloc>(context).add(GoToProfilePageEvent(page:ProfilePage.EDIT_USER_PASSWORD));
  }
}
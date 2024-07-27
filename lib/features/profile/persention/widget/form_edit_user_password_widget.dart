


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/features/auth/persention/widget/password_filde_widget.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_bloc.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_event.dart';

import '../../../../config/theme/app_color.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import 'package:moms_care/core/widget/text_field/text_field_widget.dart';

class FormEditUserPasswordWidget extends StatefulWidget{

  const FormEditUserPasswordWidget({required this.onUpdate});
  final Function(String currentPass,String newPass) onUpdate;

  @override
  State<FormEditUserPasswordWidget> createState() => _FormEditUserPasswordWidgetState();
}

class _FormEditUserPasswordWidgetState  extends State<FormEditUserPasswordWidget>{

  final _formKey= GlobalKey<FormState>();
  TextEditingController currentPassController=TextEditingController();
  TextEditingController newPassController=TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyPageWidget();
  }

  Widget _buildBodyPageWidget() {

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text("Edit password".tr,style: AppTextStyles.getTitleStyle(),),
          SizedBox(height: 80),

          PasswordFieldWidget(name: "Current Password".tr,
            controller: currentPassController,
            validator: (val)=> val!.isEmpty ? INPUT_FIELD_NOT_BE_EMPTY : null ,),
          // TextFieldWidget(
          //     controller:currentPassController,
          //     multiLines:false,
          //     name:"Current Password".tr ,
          //     validator: (val)=> val!.isEmpty ? INPUT_FIELD_NOT_BE_EMPTY : null,
          //     password: true,
          //     textInputType: TextInputType.text,
          //     radius: 12,
          //     padding: 0,
          //     hintText: "Enter Current Password".tr),
          SizedBox(height: 50,),
          PasswordFieldWidget(name: "New Password".tr,
            controller: newPassController,
            validator: (val)=> val!.isEmpty ? INPUT_FIELD_NOT_BE_EMPTY : null ,),
          // TextFieldWidget(
          //     controller:newPassController,
          //     multiLines:false,
          //     name:"New Password".tr ,
          //     validator: (val)=> val!.isEmpty ? INPUT_FIELD_NOT_BE_EMPTY : null,
          //     password: true,
          //     textInputType: TextInputType.text,
          //     radius: 12,
          //     padding: 0,
          //     hintText: "Enter New Password".tr),
          SizedBox(height: 50,),
          CustomButton(
              widthPercent: 90,
              raduis: 10,
              labelText:"Update".tr,
              icon: Icon(Icons.start,color: AppColor.primaryIconColor,) ,
              bgColor: AppColor.PrimaryButtonLightColor,
              onPressed:() async{
                validateFormThenUpdateOrAddPost();
              }),
        ],
      ),
    );
  }

  void validateFormThenUpdateOrAddPost() async{
    bool isValid=_formKey.currentState!.validate();
    if(isValid){
     await widget.onUpdate!( currentPassController!.text,newPassController!.text );
        // BlocProvider.of<ProfileBloc>(context).add(
        //     UpdateUserPasswordEvent(
        //         currentPassword: currentPassController!.text,
        //         newPassword: newPassController!.text));
      }
    }

}

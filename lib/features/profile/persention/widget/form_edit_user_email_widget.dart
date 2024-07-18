


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_bloc.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_event.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../config/theme/text_style.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import 'package:moms_care/core/widget/text_field/text_field_widget.dart';

class FormEditUserEmailWidget extends StatefulWidget{
  const FormEditUserEmailWidget({required this.email,}) ;
  final String email;

  @override
  State<FormEditUserEmailWidget> createState() => _FormEditUserEmailWidgetState();
}

class _FormEditUserEmailWidgetState  extends State<FormEditUserEmailWidget>{

  final _formKey= GlobalKey<FormState>();
  TextEditingController controller=TextEditingController();

  @override
  void initState() {
    controller.text=widget.email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyPageWidget();
  }

  Widget _buildBodyPageWidget() {

    return Container(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Edit email".tr,style: AppTextStyles.getTitleStyle(),),
              SizedBox(height: 80),

              TextFieldWidget(
                  controller:controller,
                  multiLines:false,
                  name:"Email".tr ,
                  validator: (val)=> val!.isEmpty ? INPUT_FIELD_NOT_BE_EMPTY : null,
                  textInputType: TextInputType.emailAddress,
                  radius: 12,
                  padding: 0,
                  hintText: "Enter Email".tr),
              SizedBox(height: 50,),
                CustomButton(
                    widthPercent: 90,
                    raduis: 10,
                    labelText:"Upadte".tr,
                    icon: Icon(Icons.start,color: AppColor.primaryIconColor,) ,
                    bgColor: AppColor.PrimaryButtonLightColor,
                    onPressed:() async{
                      validateFormThenUpdateOrAddPost();
                    }),
            ],
          ),
        ),
      ),
    );
  }

  void validateFormThenUpdateOrAddPost() async{
    bool isValid=_formKey.currentState!.validate();
    if(isValid){
        BlocProvider.of<ProfileBloc>(context).add(UpdateUserEmailEvent(email: controller!.text));
      }
    }

}

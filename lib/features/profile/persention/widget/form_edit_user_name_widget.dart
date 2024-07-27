


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

class FormEditUserNameWidget extends StatefulWidget{
  const FormEditUserNameWidget({required this.name,required this.onUpdate}) ;
  final String name;
  final Function(String) onUpdate;

  @override
  State<FormEditUserNameWidget> createState() => _FormEditUserNameWidgetState();
}

class _FormEditUserNameWidgetState  extends State<FormEditUserNameWidget>{

  final _formKey= GlobalKey<FormState>();
  TextEditingController controller=TextEditingController();

  @override
  void initState() {
    controller.text=widget.name!;
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
          Text("Edit name".tr,style: AppTextStyles.getTitleStyle(),),
          SizedBox(height: 80),

          TextFieldWidget(
              controller:controller,
              multiLines:false,
              name:"Name".tr ,
              validator: (val)=> val!.isEmpty ? INPUT_FIELD_NOT_BE_EMPTY : null,
              textInputType: TextInputType.name,
              radius: 12,
              padding: 0,
              hintText: "Enter Name".tr),

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

    if(_formKey.currentState!.validate()){
     await widget.onUpdate!(controller!.text!);
      }
    }

}




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moms_care/core/constants/enam/gender.dart';
import 'package:moms_care/core/data/view_models/date_time_view_model.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/features/profile/persention/bloc/baby/baby_bloc.dart';
import 'package:moms_care/features/profile/persention/bloc/baby/baby_event.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/core/constants/constants.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import 'package:moms_care/core/widget/picker/date_picker_demo.dart';
import 'package:moms_care/core/widget/text_field/dropdownbutton_widget.dart';
import 'package:moms_care/core/widget/text_field/text_field_widget.dart';
import 'package:moms_care/features/profile/domain/entities/baby_entity.dart';

class FormAddUpdateBabyWidget extends StatefulWidget{

  const FormAddUpdateBabyWidget({this.isUpdate=false, this.baby});
  final bool isUpdate;
  final Baby? baby;

  @override
  State<FormAddUpdateBabyWidget> createState() => _FormAddUpdateBabyWidgetState();
}

class _FormAddUpdateBabyWidgetState  extends State<FormAddUpdateBabyWidget>{

  final _formKey= GlobalKey<FormState>();

  TextEditingController nameController=TextEditingController();
  TextEditingController birthDayController=TextEditingController();
  TextEditingController heightController=TextEditingController();
  TextEditingController weightController=TextEditingController();
  TextEditingController numberOfResponsibleDoctorController=TextEditingController();
  Gender? _gender;
  Baby? _baby;

  @override
  void initState() {


    if(widget.baby!=null && widget.isUpdate){
      _baby=widget.baby!;
      nameController.text=_baby!.name!=null ? _baby!.name! :"";
      heightController.text=_baby!.height!=null ?_baby!.height!.toString():"";
      weightController.text=_baby!.weight==null? "":_baby!.weight!.toString();
      numberOfResponsibleDoctorController.text=_baby!.numberOfResponsibleDoctor!=null
          ? _baby!.numberOfResponsibleDoctor! :"";
      birthDayController.text=_baby!.birthDay==null ?"":"${DateFormat('yyyy-MM-dd').format(_baby!.birthDay!)}";
      _gender=_baby!.gender==null? Gender.male:_baby!.gender!;
    }
    super.initState();
  }
  void validateFormThenUpdateOrAddPost(BuildContext context) async{
    bool isValid=_formKey.currentState!.validate();
    if(isValid){

      var  baby = Baby(name: nameController.text,
            weight:double.parse(weightController.text),
            height: double.parse(heightController.text) ,
            birthDay: DateTime.parse(birthDayController.text),
            numberOfResponsibleDoctor: numberOfResponsibleDoctorController.text,
            gender: _gender,
          );

      if(widget.isUpdate && _baby !=null){
        baby=baby.copyWith(id:_baby!.id);
        BlocProvider.of<BabyBloc>(context).add(UpdateBabyEvent(baby:baby));
      }else{
        // context.read<BabyBloc>().add(AddBabyEvent(baby:baby));
         BlocProvider.of<BabyBloc>(context).add(AddBabyEvent(baby:baby));
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _buildBodyPageWidget(),
    );
  }

  Widget _buildTextFieldWidget({TextEditingController? controll, String? name,
    String? hintText,
    TextInputType? type}) {

    return TextFieldWidget(
        controller:controll!,
        multiLines:false,
        name:name!,
        validator: (val)=> val!.isEmpty ? INPUT_FIELD_NOT_BE_EMPTY : null,
        textInputType:type!,
        radius: 12,
        padding: 0,
        hintText: hintText!);
  }

  Widget _buildBodyPageWidget() {

    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextFieldWidget(controll:nameController,name:"Name".tr ,hintText:"Enter baby name".tr ,
            type:TextInputType.name),
          const SizedBox(height: 10),
          _buildTextFieldWidget(controll:heightController,name:"Height".tr ,hintText:"Enter height (cm)".tr ,
            type:TextInputType.number),
          const SizedBox(height: 10),
          _buildTextFieldWidget(controll:weightController,name:"Weight".tr ,hintText:"Enter height (Kg)".tr ,
            type:TextInputType.number),
          const SizedBox(height: 10),
          _buildTextFieldWidget(controll:numberOfResponsibleDoctorController,name:"Number of Responsible Doctor".tr ,
            hintText:"Enter Number".tr , type:TextInputType.phone ,) ,
          const SizedBox(height: 15),
          DropDownButtonWidget(
            items: GenderTypes,
            values: Gender.values,
            value: _gender,
            onChange: (value) {
              _gender = value;
              setState(() {});
            },
            name: "Gender".tr ,
            radius: 12,
            padding: 0,
          ),
          const SizedBox(height: 15),
          DatePickerDemoWidget(
            dateControlle: birthDayController,
            initialDate: (widget.isUpdate)?_baby!.birthDay! :null,
            name:"Date of Birth".tr ,
            hintText: "Select the Date of Birth".tr,),
          const SizedBox(height: 10),

          SizedBox(height: 50,),
          CustomButton(
              widthPercent: 90,
              raduis: 10,
              labelText:widget.isUpdate! ? "Update".tr:"Add".tr,
              icon: Icon(widget.isUpdate! ? Icons.update:Icons.add,color: AppColor.primaryIconColor,) ,
              bgColor: AppColor.PrimaryButtonLightColor,
              onPressed:() async{
                validateFormThenUpdateOrAddPost(context);
              }),
        ],
      ),
    );
  }



}




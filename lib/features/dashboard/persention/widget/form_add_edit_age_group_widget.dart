


import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/api_servers.dart';
import 'package:moms_care/core/constants/constants.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/constants/enam/course_types.dart';
import 'package:moms_care/core/constants/enam/time_period_scale.dart';
import 'package:moms_care/core/error/extination_valid.dart';
import 'package:moms_care/core/remote/firebase/firebase_storage_actions.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/utils/validator/validator.dart';
import 'package:moms_care/core/widget/image/image_widget.dart';
import 'package:moms_care/core/widget/picker/file_picker_demo.dart';
import 'package:moms_care/core/widget/text_field/dropdownbutton_widget.dart';
import 'package:moms_care/features/courses/data/models/course_model.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/persention/bloc/course_bloc.dart';
import 'package:moms_care/features/courses/persention/bloc/course_event.dart';
import 'package:moms_care/features/courses/persention/bloc/course_state.dart';
import 'package:moms_care/features/dashboard/data/models/age_group_model.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/add_update_delete_care_schedules_bloc.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/events/add_update_delete_age_group_event.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/care_schedules_bloc.dart';
import 'package:moms_care/features/dashboard/persention/pages/care_schedules/age_group_page.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_bloc.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_event.dart';
import 'package:moms_care/features/profile/persention/widget/image_profile_widget.dart';

import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import 'package:moms_care/core/widget/text_field/text_field_widget.dart';

class FormAddEditAgeGroupWidget extends StatefulWidget{

  final AgeGroup? ageGroup;
  final bool isUpdate;
  final Function(AgeGroup)? onSubmitAdd,onSubmitUpdate;
  final Function()? onSubmit;

  const FormAddEditAgeGroupWidget({super.key, 
    this.isUpdate=false,
    this.ageGroup,
    this.onSubmitAdd,
    this.onSubmitUpdate,
    this.onSubmit,
  }) ;

  @override
  State<FormAddEditAgeGroupWidget> createState() => _FormAddEditAgeGroupWidgetState();
}

class _FormAddEditAgeGroupWidgetState  extends State<FormAddEditAgeGroupWidget>{

  final _formKey= GlobalKey<FormState>();

  TextEditingController minController=TextEditingController();
  TextEditingController maxController=TextEditingController();
  TimePeriodScale? _timePeriodScale=TimePeriodScale.Month;
  BuildContext? _context;




  @override
  void initState() {

    if(widget.isUpdate && widget.ageGroup!=null){
      minController.text="${widget.ageGroup!.min}";
      maxController.text="${widget.ageGroup!.max}";
      _timePeriodScale=widget.ageGroup!.timePeriodScale;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // return _buildBodyPageWidget();
    return BlocConsumer<AddUpdateDeleteCareScheduleBloc,AddUpdateDeleteCareScheduleState>(
      builder:_builderBodyBlocWidget,
      listener:_listenerBodyBlocWidget ,);
  }


  Widget _builderBodyBlocWidget(BuildContext context, CareSchedulesState state) {

    return _buildBodyPageWidget();
  }

  void _listenerBodyBlocWidget(BuildContext context, AddUpdateDeleteCareScheduleState state) async{
    if(state is LoadingAddUpdateDeleteCareScheduleState ){
      MessageBox.showProgress(context, WAIT_MESSAGE);
      await Future.delayed(const Duration(seconds: 5));
    }
    if(state is ErrorAddUpdateDeleteCareScheduleState){
      Get.back();
      MessageBox.showError(context, state.message);
    }
    else if(state is AddUpdateDeleteCareScheduleSuccessfulState){
      Get.back();
      SnackBarBuilder.ShowSuccess(context: context ,message:state.message);
      Get.offAll(const AgeGroupPage());
      await Future.delayed(const Duration(seconds: 5));
    }


  }

  Widget _buildBodyPageWidget() {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Text(widget.isUpdate ? "Update Age Group".tr: "Add Age Group".tr,style: AppTextStyles.getTitleStyle(),),
            const SizedBox(height: 40),
            TextFieldWidget(
                controller:minController,
                multiLines:false,
                name:"Min".tr ,
                validator: (val)=> "".validator()!(val),
                textInputType: TextInputType.number,
                radius: 12,
                padding: 0,
                hintText: "Enter Min ".tr),
            const  SizedBox(height: 30,),
            TextFieldWidget(
                controller:maxController,
                multiLines:false,
                name:"Max".tr ,
                validator:  (val)=> "".validator()!(val),
                textInputType: TextInputType.number,
                radius: 12,
                padding: 0,
                hintText: "Enter Max".tr),
            const  SizedBox(height: 30,),
            DropDownButtonWidget(
              items: TimePeriodScale.getStringValues(),
              values: TimePeriodScale.values,
              validator:(val)=> "".validatorDropDown()!(val),
              value: _timePeriodScale,
              onChange: (value) {
                _timePeriodScale = value;
                setState(() {});
              },
              name: "Time Period Scale".tr ,
              radius: 12,
              padding: 0,
            ),
            const  SizedBox(height: 30,),
            CustomButton(
                widthPercent: 90,
                raduis: 10,
                labelText: widget.isUpdate ? "Update".tr :"Add".tr,
                icon:  Icon(widget.isUpdate?Icons.update:Icons.add,color: AppColor.primaryIconColor,) ,
                bgColor: AppColor.PrimaryButtonLightColor,
                onPressed:() async{
                  validateFormThenUpdateOrAddPost();
                }),
          ],
        ),
      ),
    );
  }



  void validateFormThenUpdateOrAddPost() async{

    if(widget.onSubmit!=null) {
      await widget.onSubmit!();
    }

    if(_formKey.currentState!.validate()){

      var item=AgeGroup(
        min: int.parse(minController.text),
        max: int.parse(maxController.text),
        timePeriodScale: _timePeriodScale!);

      if(widget.isUpdate && widget.ageGroup!=null){

        item=AgeGroupModel.fromEntity(item).copyWith(id:widget.ageGroup!.id).toEntity();
        // await widget.onSubmitUpdate!(item!);
        BlocProvider.of<AddUpdateDeleteCareScheduleBloc>(context).add(UpdateAgeGroupEvent(ageGroup: item));

      }else{
        // await widget.onSubmitAdd!(item!);
        BlocProvider.of<AddUpdateDeleteCareScheduleBloc>(context).add(AddAgeGroupEvent(ageGroup: item));
        // Get.back();
      }



      }
    }



}

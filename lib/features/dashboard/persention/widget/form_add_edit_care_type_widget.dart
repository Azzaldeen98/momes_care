


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
import 'package:moms_care/features/dashboard/data/models/care_type_model.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/add_update_delete_care_schedules_bloc.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/events/add_update_delete_age_group_event.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/events/add_update_delete_care_type_event.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/care_schedules_bloc.dart';
import 'package:moms_care/features/dashboard/persention/pages/care_schedules/age_group_page.dart';
import 'package:moms_care/features/dashboard/persention/pages/care_schedules/care_type_page.dart';
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

class FormAddEditCareTypeWidget extends StatefulWidget{

  final CareType? careType;
  final bool isUpdate;
  final Function(CareType)? onSubmitAdd,onSubmitUpdate;
  final Function()? onSubmit;

  const FormAddEditCareTypeWidget({super.key, 
    this.isUpdate=false,
    this.careType,
    this.onSubmitAdd,
    this.onSubmitUpdate,
    this.onSubmit,
  }) ;

  @override
  State<FormAddEditCareTypeWidget> createState() => _FormAddEditCareTypeWidgetState();
}

class _FormAddEditCareTypeWidgetState  extends State<FormAddEditCareTypeWidget>{

  final _formKey= GlobalKey<FormState>();

  TextEditingController nameController=TextEditingController();
  bool isActive=true;
  BuildContext? _context;




  @override
  void initState() {

    if(widget.isUpdate && widget.careType!=null){
      nameController.text="${widget.careType?.name}";
      isActive=widget.careType?.state ?? false;
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
      Get.offAll(const CareTypePage());
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
            Text(widget.isUpdate ? "Update Care Type ".tr: "Add Care Type".tr,style: AppTextStyles.getTitleStyle(),),
            const SizedBox(height: 40),
            TextFieldWidget(
                controller:nameController,
                multiLines:false,
                name:"Name".tr ,
                validator: (val)=> "".validator()!(val),
                textInputType: TextInputType.text,
                radius: 12,
                padding: 0,
                hintText: "Enter name".tr),
            const  SizedBox(height: 30,),
            Checkbox(
               semanticLabel: "Active".tr,
                value: isActive,
                onChanged: (value){
                  setState(() {
                    isActive=value ?? false;
                  });
            }),

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

      var item=CareType(
        name: nameController.text,
        state: isActive
      );

      if(widget.isUpdate && widget.careType!=null){

        item=CareTypeModel.fromEntity(item).copyWith(id:widget.careType!.id).toEntity();
        // await widget.onSubmitUpdate!(item!);
        BlocProvider.of<AddUpdateDeleteCareScheduleBloc>(context).add(UpdateCareTypeEvent(careType: item));

      }else{
        // await widget.onSubmitAdd!(item!);
        BlocProvider.of<AddUpdateDeleteCareScheduleBloc>(context).add(AddCareTypeEvent(careType: item));

      }

      }
    }



}

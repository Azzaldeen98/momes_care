



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moms_care/core/constants/enam/time_period_scale.dart';
import 'package:moms_care/core/helpers/helpers.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/utils/validator/validator.dart';
import 'package:moms_care/core/widget/picker/time_picker_demo.dart';
import 'package:moms_care/core/widget/state/error_page_widget.dart';
import 'package:moms_care/core/widget/state/loading_widget.dart';
import 'package:moms_care/core/widget/text_field/dropdownbutton_widget.dart';
import 'package:moms_care/features/dashboard/data/models/daily_care_times_model.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/add_update_delete_care_schedules_bloc.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/events/add_update_delete_daily_care_times_event.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/care_schedules_bloc.dart';
import 'package:moms_care/features/dashboard/persention/pages/care_schedules/daily_care_time_page.dart';
import 'package:moms_care/injection_container.dart' as di;
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import 'package:moms_care/core/widget/text_field/text_field_widget.dart';

class FormAddDailyCareTimeWidget extends StatefulWidget{

  final DailyCareTimes? dailyCareTime;
  final bool isUpdate;
  final Function(bool,BuildContext,DailyCareTimes) onSubmit;
  final List<AgeGroup> ageGroups;
  final List<CareType> careTypes;


  const FormAddDailyCareTimeWidget({super.key, 
    this.isUpdate=false,
    this.dailyCareTime,
    required this.ageGroups,
    required  this.careTypes,
    required this.onSubmit,
  }) ;

  @override
  State<FormAddDailyCareTimeWidget> createState() => _FormAddDailyCareTimeWidgetState();
}

class _FormAddDailyCareTimeWidgetState  extends State<FormAddDailyCareTimeWidget> {

  final _formKey= GlobalKey<FormState>();
   List<AgeGroup> ageGroups=[];
   List<CareType> careTypes=[];
  CareType?  selectedCareType;
  AgeGroup? selectedAgeGroup;

  TextEditingController descriptController=TextEditingController();
  TextEditingController timeController=TextEditingController();
  bool _isActive=true;


  @override
  void initState() {

    if(widget.ageGroups!=null){
      ageGroups=widget.ageGroups;
    }
    if(widget.careTypes!=null){
      careTypes=widget.careTypes;
    }

    if(widget.isUpdate && widget.dailyCareTime!=null){
      descriptController.text=widget.dailyCareTime!.descript;
      timeController.text=widget.dailyCareTime!.time;
      _isActive=widget.dailyCareTime!.state;
      selectedAgeGroup=widget.dailyCareTime?.ageGroup;
      selectedCareType=widget.dailyCareTime?.careType;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return _buildBodyPageWidget();
  }

  Widget _builderBodyBlocWidget(BuildContext context, CareSchedulesState state) {
    // if(state is LoadingAddUpdateDeleteCareScheduleState ){
    //   return  const LoadingVehicleWidget();
    // }
    // if(state is ErrorCareSchedulesState){
    //   Get.back();
    //   return  const ErrorPageWidget();
    // }
    // else if(state is LoadedAgeGroupsAndCareTypesState){
    //   Get.back();
    //   ageGroups=state.ageGroups;
    //   careTypes=state.careTypes;
    //   return _buildBodyPageWidget();
    // }
    return _buildBodyPageWidget();
  }

  void _listenerBodyBlocWidget(BuildContext context, AddUpdateDeleteCareScheduleState state) async{

    if(state is LoadingAddUpdateDeleteCareScheduleState ){
      MessageBox.showProgress(context, WAIT_MESSAGE);
      // await Future.delayed(const Duration(seconds: 5));
    }
    if(state is ErrorAddUpdateDeleteCareScheduleState){
      Get.back();
      // MessageBox.showError(context, state.message);
    }
    else if(state is AddUpdateDeleteCareScheduleSuccessfulState){
      Get.back();
      // SnackBarBuilder.ShowSuccess(context: context ,message:state.message);
      // Get.offAll(const DailyCareTimePage());
      // await Future.delayed(const Duration(seconds: 5));
    }
  }


  Widget _buildBodyPageWidget() {


    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [

              const SizedBox(height: 40),
              TextFieldWidget(
                  controller:descriptController,
                  multiLines:true,
                  name:"Description".tr ,
                  validator: (val)=> "".validator()!(val),
                  textInputType: TextInputType.text,
                  radius: 12,
                  padding: 0,
                  hintText: "Enter Description ".tr),
              const  SizedBox(height: 30,),
              Text("Chose Time".tr),
              if(timeController!=null)
                TimePickerDemoWidget(timeController:timeController, validator:(val)=> "".validator()!(val) ,),
              const  SizedBox(height: 30,),
              if(careTypes!=null)
                DropDownButtonWidget<CareType?>(
                    items: careTypes?.map((e)=>e.name)!.toList()??[],
                    values: careTypes,
                    validator:(val)=> "".validatorDropDown()!(val),
                    value: selectedCareType,
                    onChange: (value) {
                      selectedCareType = value;
                       setState(() {});
                    },
                    name: "Care Types".tr ,
                    radius: 12,
                    padding: 0,
              ),
              const  SizedBox(height: 30,),
              if(ageGroups!=null)
                DropDownButtonWidget<AgeGroup?>(
                  items: ageGroups?.map((e)=>"${e.min} - ${e.max} "+"Months".tr).toList()??[],
                  values: ageGroups,
                  validator:(val)=> "".validatorDropDown()!(val),
                  value: selectedAgeGroup,
                  onChange: (value) {
                    selectedAgeGroup = value;
                    setState(() {});
                  },
                  name: 'Age Group'.tr ,
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
                    }
                  ),
            ],
          ),
        ),
    );
  }



  void validateFormThenUpdateOrAddPost() async{

    // if(widget.onSubmit!=null) {
    //   await widget.onSubmit!();
    // }

    if(_formKey.currentState!.validate()){

      var item=DailyCareTimes(
        descript:descriptController.text,
        time: timeController.text!,
        state:_isActive,
        ageGroup:selectedAgeGroup ,
        careType:selectedCareType ,
        ageGroupId:selectedAgeGroup?.id,
        careTypeId:selectedCareType?.id,
      );

      if(widget.isUpdate && widget.dailyCareTime!=null){

        item=DailyCareTimesModel.fromEntity(item).copyWith(id:widget.dailyCareTime!.id).toEntity();
        // BlocProvider.of<AddUpdateDeleteCareScheduleBloc>(context).add(UpdateDailyCareTimesEvent(dailyCareTimes: item));

      }
        widget.onSubmit!(widget.isUpdate,context,item);
      }
    }



}


// class FormAddDailyCareTimeWidget extends StatefulWidget{
//
//   final DailyCareTimes? dailyCareTime;
//   final bool isUpdate;
//   final Function()? onSubmit;
//   final List<AgeGroup> ageGroups;
//   final List<CareType> careTypes;
//
//
//   const FormAddDailyCareTimeWidget({super.key,
//     this.isUpdate=false,
//     this.dailyCareTime,
//     required this.ageGroups,
//     required  this.careTypes,
//     this.onSubmit,
//   }) ;
//
//   @override
//   State<FormAddDailyCareTimeWidget> createState() => _FormAddDailyCareTimeWidgetState();
// }
//
// class _FormAddDailyCareTimeWidgetState  extends State<FormAddDailyCareTimeWidget> {
//
//   final _formKey= GlobalKey<FormState>();
//   List<AgeGroup> ageGroups=[];
//   List<CareType> careTypes=[];
//   CareType?  selectedCareType;
//   AgeGroup? selectedAgeGroup;
//
//   TextEditingController descriptController=TextEditingController(text: "");
//   TextEditingController timeController=TextEditingController(text: "");
//   bool _isActive=true;
//
//
//   @override
//   void initState() {
//
//     if(widget.ageGroups!=null){
//       ageGroups=widget.ageGroups;
//     }
//     if(widget.careTypes!=null){
//       careTypes=widget.careTypes;
//     }
//
//     if(widget.isUpdate && widget.dailyCareTime!=null){
//       descriptController.text=widget.dailyCareTime!.descript;
//       timeController.text=widget.dailyCareTime!.time;
//       _isActive=widget.dailyCareTime!.state;
//     }
//     super.initState();
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return BlocProvider(create: (context) =>
//     di.sl<AddUpdateDeleteCareScheduleBloc>()..add(const GetAllCareTypesAndAgeGroupsEvent()),
//         child:BlocConsumer<AddUpdateDeleteCareScheduleBloc,AddUpdateDeleteCareScheduleState>(
//             builder:_builderBodyBlocWidget,
//             listener:_listenerBodyBlocWidget));
//   }
//
//   Widget _builderBodyBlocWidget(BuildContext context, CareSchedulesState state) {
//     if(state is LoadingAddUpdateDeleteCareScheduleState ){
//       return  const LoadingVehicleWidget();
//     }
//     if(state is ErrorCareSchedulesState){
//       Get.back();
//       return  const ErrorPageWidget();
//     }
//     else if(state is LoadedAgeGroupsAndCareTypesState){
//       Get.back();
//       ageGroups=state.ageGroups;
//       careTypes=state.careTypes;
//       return _buildBodyPageWidget();
//     }
//     return _buildBodyPageWidget();
//   }
//
//   void _listenerBodyBlocWidget(BuildContext context, AddUpdateDeleteCareScheduleState state) async{
//
//     if(state is LoadingAddUpdateDeleteCareScheduleState ){
//       MessageBox.showProgress(context, WAIT_MESSAGE);
//       await Future.delayed(const Duration(seconds: 5));
//     }
//     if(state is ErrorAddUpdateDeleteCareScheduleState){
//       Get.back();
//       MessageBox.showError(context, state.message);
//     }
//     else if(state is AddUpdateDeleteCareScheduleSuccessfulState){
//       Get.back();
//       SnackBarBuilder.ShowSuccess(context: context ,message:state.message);
//       Get.offAll(const DailyCareTimePage());
//       await Future.delayed(const Duration(seconds: 5));
//     }
//
//
//   }
//
//
//   Widget _buildBodyPageWidget() {
//
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             // Text(widget.isUpdate ? "Update Daily Care Time".tr: "Add Daily Care Time".tr,style: AppTextStyles.getTitleStyle(),),
//             const SizedBox(height: 40),
//             TextFieldWidget(
//                 controller:descriptController,
//                 multiLines:true,
//                 name:"Description".tr ,
//                 validator: (val)=> "".validator()!(val),
//                 textInputType: TextInputType.text,
//                 radius: 12,
//                 padding: 0,
//                 hintText: "Enter Description ".tr),
//             const  SizedBox(height: 30,),
//             Text("Chose Time".tr),
//             if(timeController!=null)
//               TimePickerDemoWidget(timeController:timeController),
//             const  SizedBox(height: 30,),
//             if(careTypes!=null)
//               DropDownButtonWidget<CareType>(
//                 items: careTypes?.map((e)=>e.name).toList()??[],
//                 values: careTypes,
//                 validator:(val)=> "".validatorDropDown()!(val),
//                 value: selectedCareType,
//                 onChange: (value) {
//                   selectedCareType = value;
//                   // setState(() {});
//                 },
//                 name: "Care Types".tr ,
//                 radius: 12,
//                 padding: 0,
//               ),
//             const  SizedBox(height: 30,),
//             if(ageGroups!=null)
//               DropDownButtonWidget<AgeGroup>(
//                 items: ageGroups?.map((e)=>"${e.min} - ${e.max} "+"Months".tr).toList()??[],
//                 values: ageGroups,
//                 validator:(val)=> "".validatorDropDown()!(val),
//                 value: selectedAgeGroup,
//                 onChange: (value) {
//                   selectedAgeGroup = value;
//                   // setState(() {});
//                 },
//                 name: 'Age Group'.tr ,
//                 radius: 12,
//                 padding: 0,
//               ),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: [
//             //     Text("Active".tr),
//             //     Checkbox(
//             //         semanticLabel: "Active".tr,
//             //         value: _isActive,
//             //         onChanged: (value){
//             //           setState(() {
//             //             _isActive=value ?? false;
//             //           });
//             //         }),
//             //   ],
//             // ),
//
//             const  SizedBox(height: 30,),
//             CustomButton(
//                 widthPercent: 90,
//                 raduis: 10,
//                 labelText: widget.isUpdate ? "Update".tr :"Add".tr,
//                 icon:  Icon(widget.isUpdate?Icons.update:Icons.add,color: AppColor.primaryIconColor,) ,
//                 bgColor: AppColor.PrimaryButtonLightColor,
//                 onPressed:() async{
//                   validateFormThenUpdateOrAddPost();
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//   void validateFormThenUpdateOrAddPost() async{
//
//     // if(widget.onSubmit!=null) {
//     //   await widget.onSubmit!();
//     // }
//
//     if(_formKey.currentState!.validate()){
//
//       MessageBox.showDialog(context, textBody: timeController.text);
//       var item=DailyCareTimes(
//         descript:descriptController.text,
//         time: timeController.text!,
//         state: _isActive,
//         ageGroupId:selectedAgeGroup?.id,
//         careTypeId:selectedCareType?.id,
//       );
//
//       if(widget.isUpdate && widget.dailyCareTime!=null){
//
//         item=DailyCareTimesModel.fromEntity(item).copyWith(id:widget.dailyCareTime!.id).toEntity();
//         BlocProvider.of<AddUpdateDeleteCareScheduleBloc>(context).add(UpdateDailyCareTimesEvent(dailyCareTimes: item));
//
//       }
//       else{
//
//         BlocProvider.of<AddUpdateDeleteCareScheduleBloc>(context).add(AddDailyCareTimesEvent(dailyCareTimes: item));
//       }
//
//
//
//     }
//   }
//
//
//
// }

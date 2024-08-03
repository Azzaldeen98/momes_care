

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/constants/constants.dart';
import 'package:moms_care/core/constants/enam/CareSchedulesItems.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/state/error_page_widget.dart';
import 'package:moms_care/core/widget/state/loading_widget.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/add_update_delete_care_schedules_bloc.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/events/add_update_delete_daily_care_times_event.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/care_schedules_bloc.dart';
import 'package:moms_care/features/dashboard/persention/pages/care_schedules/age_group_page.dart';
import 'package:moms_care/features/dashboard/persention/pages/care_schedules/care_type_page.dart';
import 'package:moms_care/features/dashboard/persention/widget/form_add_daily_care_time_widget.dart';
import 'package:moms_care/features/dashboard/persention/widget/form_add_edit_age_group_widget.dart';
import 'package:moms_care/features/dashboard/persention/widget/form_add_edit_care_type_widget.dart';
import 'package:moms_care/injection_container.dart' as di;

import '../../bloc/care_schedules/add_update_delete_care_schedules/events/add_update_delete_age_group_event.dart';
import 'daily_care_time_page.dart';


class AddUpdateCareScheduleView<T> extends StatefulWidget {
  final CareType? careType;
  final AgeGroup? ageGroup;
  final bool? isDelete;
  final DailyCareTimes? dailyCareTimes;
  final T?  scheduleItem;
  final CareScheduleItems careScheduleItems;

  const AddUpdateCareScheduleView({super.key,
   required this.careScheduleItems,
    this.scheduleItem,
    this.careType,
    this.ageGroup,
    this.isDelete=false,
    this.dailyCareTimes});
  @override
  State<AddUpdateCareScheduleView> createState() => _AddUpdateCareScheduleViewState();
}

class _AddUpdateCareScheduleViewState extends State<AddUpdateCareScheduleView> {
  bool _isKeyboardVisible=false;
  bool _isViewForm=true;
  List<AgeGroup>? ageGroups;
  List<CareType>? careTypes;
  BuildContext? baseContext;

  @override
  Widget build(BuildContext context) {
  return  MultiBlocProvider(providers: [
    if(widget.careScheduleItems==CareScheduleItems.DailyCareTimes)
      BlocProvider(create: (context) => di.sl<AddUpdateDeleteCareScheduleBloc>()..add(const GetAllCareTypesAndAgeGroupsEvent()))
    else
      BlocProvider(create: (context) => di.sl<AddUpdateDeleteCareScheduleBloc>()),
  ],
    child: Scaffold(
      appBar:  AppBarPageWidget(pageName:"${((widget.scheduleItem==null)? "Add".tr :"Update".tr)} "
          "${CareScheduleTypes[widget.careScheduleItems.index].tr}",actions: [
      ],),
    body:BlocConsumer<AddUpdateDeleteCareScheduleBloc,AddUpdateDeleteCareScheduleState>(
    builder:_builderBodyBloc,
    listener:_listenerBodyBlocWidget)),

    );
  
  }


  Widget _builderBodyBloc(BuildContext context,  state) {

    baseContext=context;
    if(state is LoadingCareSchedulesItemsState){
      return  const LoadingVehicleWidget();
    }
    if(state is ErrorCareSchedulesState){
      return  const ErrorPageWidget();
    }else if(state is LoadedAgeGroupsAndCareTypesState){
      ageGroups=state.ageGroups;
      print("ageGroups&${ageGroups!.length}");
      print("careTypes&${careTypes!.length}");
      careTypes=state.careTypes;
      return   _buildBodyWidget(context,ageGroups: state.ageGroups,careTypes:state.careTypes);
    }
    return   _buildBodyWidget(context);
  }

  void _listenerBodyBlocWidget(BuildContext context,  state) async{

    if(state is LoadingCareSchedulesItemsState){

    }
    if(state is LoadingAddUpdateDeleteCareScheduleState){
      MessageBox.showProgress(baseContext!, WAIT_MESSAGE);
       await Future.delayed(const Duration(seconds: 5));
    }
    if(state is ErrorCareSchedulesState){
      Get.back();
      setState(() {_isViewForm=false;});
      MessageBox.showError(context, state.message);
    }
    if(state is ErrorAddUpdateDeleteCareScheduleState){
      Get.back();
      setState(() {_isViewForm=false;});
      MessageBox.showError(context, state.message);
    }
    else if(state is LoadedAgeGroupsAndCareTypesState){
        // Get.back();
        setState((){
          _isViewForm=false;
          ageGroups=state.ageGroups;
          careTypes=state.careTypes;
        });
    }
    else if(state is AddUpdateDeleteCareScheduleSuccessfulState){
        Get.back();
        setState(() {
          _isViewForm = true;
        });
        SnackBarBuilder.ShowSuccess(context: context ,message:state.message);
        Get.offAll(const DailyCareTimePage());
        await Future.delayed(const Duration(seconds: 5));
    }

  }
  Widget _buildBodyWidget(BuildContext context,{List<AgeGroup>? ageGroups,List<CareType>? careTypes}) {

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible){
              _isKeyboardVisible=isKeyboardVisible;
              return  SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: _isKeyboardVisible ? MediaQuery.of(context).viewInsets.bottom : 0,),
                  child: _buildAddEditForm(ageGroups:ageGroups,careTypes: careTypes));
            }),
      );
    }
  Widget _buildAddEditForm({List<AgeGroup>? ageGroups,List<CareType>? careTypes}) {
        if (widget.isDelete!) {
          return const SizedBox();
        } else {
          if (widget.careScheduleItems == CareScheduleItems.AgeGroup) {
            return FormAddEditAgeGroupWidget(
                isUpdate: widget.scheduleItem != null,
                ageGroup: widget.scheduleItem,
                onSubmit: onSubmitForm);
          } else if (widget.careScheduleItems == CareScheduleItems.CareTypes) {
            return FormAddEditCareTypeWidget(
                isUpdate: widget.scheduleItem != null,
                careType: widget.scheduleItem,
                onSubmit: onSubmitForm);
          } else
          if (widget.careScheduleItems == CareScheduleItems.DailyCareTimes) {
            return FormAddDailyCareTimeWidget(
              ageGroups: ageGroups??[],
              careTypes: careTypes??[],
              isUpdate: widget.scheduleItem != null,
              dailyCareTime: widget.scheduleItem,
              onSubmit: onSubmitDailyCareTimesForm);
          } else {
            return const SizedBox();
          }
        }
      }
  void onSubmitDailyCareTimesForm(bool isUpdate,BuildContext _context,DailyCareTimes item) async{

  // MessageBox.showDialog(baseContext!, textBody: item.descript);
    setState(() {_isKeyboardVisible=false;});
    if(isUpdate){
       BlocProvider.of<AddUpdateDeleteCareScheduleBloc>(baseContext!).add(UpdateDailyCareTimesEvent(dailyCareTimes: item));
    }else{
      BlocProvider.of<AddUpdateDeleteCareScheduleBloc>(baseContext!).add(AddDailyCareTimesEvent(dailyCareTimes: item));
    }
    }
  void onBack() {
    if(widget.careScheduleItems==CareScheduleItems.AgeGroup) {
         Get.offAll(const AgeGroupPage());
    }else if(widget.careScheduleItems==CareScheduleItems.CareTypes) {
        Get.offAll(const CareTypePage());
    }else if(widget.careScheduleItems==CareScheduleItems.DailyCareTimes) {
      Get.offAll(const DailyCareTimePage());
    }

  }





  onSubmitForm() {
  }
}
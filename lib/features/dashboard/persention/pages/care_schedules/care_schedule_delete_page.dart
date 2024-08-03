


import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/enam/CareSchedulesItems.dart';
import 'package:moms_care/core/utils/dailog/message/dssd.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/add_update_delete_care_schedules_bloc.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/events/add_update_delete_age_group_event.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/events/add_update_delete_care_type_event.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/events/add_update_delete_daily_care_times_event.dart';
import 'package:moms_care/features/dashboard/persention/pages/care_schedules/age_group_page.dart';
import 'package:moms_care/features/dashboard/persention/pages/care_schedules/care_type_page.dart';
import 'package:moms_care/features/dashboard/persention/pages/care_schedules/daily_care_time_page.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/injection_container.dart' as di;

class CareScheduleDeletePage<T>  extends StatelessWidget {
  const CareScheduleDeletePage({
    super.key,
    this.onDelete,
     this.itemId,
     this.scheduleItem,
    required this.careScheduleType,});

  final T?  scheduleItem;
  final int? itemId;
  final CareScheduleItems careScheduleType;
  final VoidCallback? onDelete;
  @override

  Widget build(BuildContext context) {
    return  BlocProvider(create: (context) => di.sl<AddUpdateDeleteCareScheduleBloc>(),
        child: Scaffold(
          body: BlocConsumer<AddUpdateDeleteCareScheduleBloc,AddUpdateDeleteCareScheduleState>(
              builder: _builderCareSchedulesWidgetBlocState,
              listener: _listenerCareSchedulesBlocState
          ) ,
        )
    );
  }


  Widget _builderCareSchedulesWidgetBlocState(BuildContext context,state) {
    if(scheduleItem==null) {
      return SizedBox();
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: const Color.fromARGB(227, 225, 224, 224), width: 0.7),
              borderRadius: BorderRadius.circular(10)),
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.opacitybgCololr),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        margin: EdgeInsets.symmetric(vertical: 200),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 50,),
                            Icon(Icons.info_outline,size: 100,color: Colors.red,),
                            const SizedBox(height: 20,),
                            Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.red),
                                ),
                                child: Text(DELETE_CONSENT_MESSAGE,
                                  style: AppTextStyles.getErrorStyle(),)
                            ),
                            const SizedBox(height: 50,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButton(
                                    widthPercent: 30,
                                    raduis: 10,
                                    labelText: "Delete".tr,
                                    icon: const Icon(Icons.delete,color: AppColor.whiteColor,) ,
                                    bgColor: AppColor.errorColor,
                                    onPressed:() async{
                                      onAccepted(context);
                                    }),
                                CustomButton(
                                    widthPercent: 30,
                                    raduis: 10,
                                    labelText: "Cancel".tr,
                                    textStyle: AppTextStyles.getBasicStyle(color: AppColor.primaryTextColor),
                                    icon: const Icon(Icons.cancel_outlined,color: AppColor.primaryLightIconColor,) ,
                                    bgColor: AppColor.opacitybgCololr,
                                    onPressed:() async{
                                      Get.back();
                                    }),
                              ],
                            ),



                          ],),
                      )
                    ],
                  ),

        ),
      ],
    );
  }

  void _listenerCareSchedulesBlocState(BuildContext context, AddUpdateDeleteCareScheduleState state) async {
    if (state is LoadingAddUpdateDeleteCareScheduleState) {
      MessageBox.showProgress(context, WAIT_MESSAGE);
      await Future.delayed(const Duration(seconds: 5));
    }
    if (state is ErrorAddUpdateDeleteCareScheduleState) {
      Get.back();
      MessageBox.showError(context, state.message);
    }
    else if (state is AddUpdateDeleteCareScheduleSuccessfulState) {
      Get.back();
      SnackBarBuilder.ShowSuccess(context: context, message: state.message);
      if (state.careScheduleItem == CareScheduleItems.DailyCareTimes) {
        Get.offAll(const DailyCareTimePage());
      } else if (state.careScheduleItem == CareScheduleItems.CareTypes) {
        Get.offAll(const CareTypePage());
      } else if (state.careScheduleItem == CareScheduleItems.AgeGroup) {
        Get.offAll(const AgeGroupPage());
      }
    }
  }

  // void onPressDelete(BuildContext context) async{
  //   ShowAwesomeDialogBox(context:context ,message: DELETE_CONSENT_MESSAGE,onAccept:() async{
  //     // Get.back();
  //       deleteItem(context);
  //   } );
  // }
  void onAccepted(BuildContext context) async{

    if(scheduleItem!=null) {
      if(careScheduleType==CareScheduleItems.AgeGroup) {
        var ageGroup=(scheduleItem as AgeGroup);
        BlocProvider.of<AddUpdateDeleteCareScheduleBloc>(context).add(DeleteAgeGroupEvent(id:ageGroup.id!) );
      }else if(careScheduleType==CareScheduleItems.CareTypes) {
        var careType=(scheduleItem as CareType);
        BlocProvider.of<AddUpdateDeleteCareScheduleBloc>(context).add(DeleteCareTypeEvent(id:careType.id!) );
      }
      else if(careScheduleType==CareScheduleItems.DailyCareTimes) {
        var dailyCareTime=(scheduleItem as DailyCareTimes);
        BlocProvider.of<AddUpdateDeleteCareScheduleBloc>(context).add(DeleteDailyCareTimesEvent(id:dailyCareTime.id!) );
      }
    }
  }






}


import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/enam/CareSchedulesItems.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/helpers/helpers.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/button/back_button_widget.dart';
import 'package:moms_care/core/widget/button/floating_action_button.dart';
import 'package:moms_care/core/widget/empty_widget.dart';
import 'package:moms_care/core/widget/state/loading_widget.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/care_schedules_bloc.dart';
import 'package:moms_care/features/dashboard/persention/pages/care_schedules/add_update_care_schedule_view.dart';
import 'package:moms_care/features/dashboard/persention/pages/care_schedules/care_schedule_delete_page.dart';
import 'package:moms_care/features/dashboard/persention/pages/dashboard_page.dart';
import 'package:moms_care/features/forum/presentation/wedgits/body_widget.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/injection_container.dart' as di;


class DailyCareTimePage extends StatefulWidget {
  const DailyCareTimePage({super.key});

  @override
  State<DailyCareTimePage> createState() => _DailyCareTimePageState();
}

class _DailyCareTimePageState extends State<DailyCareTimePage> {
  
  List<DailyCareTimes>? dailyCareTimes;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => di.sl<CareSchedulesBloc>()..add(const GetAllDailyCareTimesEvent()),
      child:Scaffold(
          appBar: AppBarPageWidget(pageName: "Daily Care Times".tr,actions: [
            BackButtonWidget(onPressed:()=>Get.offAll(HomePage(numberScreen: AppAdminPages.DASHBOARD.index))),
          ],),
          // bottomNavigationBar: Helper.buttonNavigation ,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body:  BlocConsumer<CareSchedulesBloc,CareSchedulesState>(
              builder: _builderCareSchedulesWidgetBlocState,
              listener: _listenerCareSchedulesBlocState
          )),
    );
  }


  Widget _builderCareSchedulesWidgetBlocState(BuildContext context, CareSchedulesState state) {
    if(state is LoadingCareSchedulesState){
      return  const LoadingVehicleWidget();
    }
    if(state is LoadedDailyCareTimesState){
      dailyCareTimes=state.items;
      return   _buildBodyWidget(context,state);
    }
    return _buildBodyWidget(context,state);
  }
  Widget _buildBodyWidget(BuildContext context, state) {
    // (dailyCareTimes==null) ?  EmptyWidget(explanatoryText:"Empty".tr,) :
    return   RefreshIndicator(
      key: _refreshIndicatorKey ,
      onRefresh: () async  {
        BlocProvider.of<CareSchedulesBloc>(context).add(const GetAllDailyCareTimesEvent());
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children:[
                  Center(
                  child:dailyCareTimes==null ? EmptyWidget(explanatoryText:"Empty".tr): ListView.builder(
                    itemBuilder: (context,index){
              
                      var item=dailyCareTimes![index];
                      return ListTile(
                        title: Column(
                          children: [
                           BodyWidget(content:item.descript ,title:Helpers.convertTo12HourFormat(item.time)),

                            SizedBox(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                IconButton(onPressed:()=> onEditItem(item),
                                    icon: const Icon(Icons.edit)),
                                const SizedBox(width: 10,),
                                IconButton(onPressed:()=>  onDeleteItem(item),
                                    icon: const Icon(Icons.delete))
                              ],),
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    },
                    itemCount:dailyCareTimes!.length,
                  ),
                  ),
              FloatingActionButtonWidget(
                onPressed:(){
                  Get.to(const AddUpdateCareScheduleView<DailyCareTimes>(
                      careScheduleItems: CareScheduleItems.DailyCareTimes));
                } ,
                icon:Icons.add ,
                bottom:10 ,
                left: 10,),
              
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
  void _listenerCareSchedulesBlocState(BuildContext context, CareSchedulesState state) {
  }

  onEditItem(DailyCareTimes item) {
    Get.to(AddUpdateCareScheduleView<DailyCareTimes>(scheduleItem:item,
        careScheduleItems: CareScheduleItems.DailyCareTimes));
  }

  onDeleteItem(DailyCareTimes item) {

    Get.to(CareScheduleDeletePage<DailyCareTimes>(scheduleItem:item,
        careScheduleType: CareScheduleItems.DailyCareTimes));

  }
}
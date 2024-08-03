

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/enam/CareSchedulesItems.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/button/back_button_widget.dart';
import 'package:moms_care/core/widget/button/floating_action_button.dart';
import 'package:moms_care/core/widget/empty_widget.dart';
import 'package:moms_care/core/widget/state/loading_widget.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/care_schedules_bloc.dart';
import 'package:moms_care/features/dashboard/persention/pages/care_schedules/add_update_care_schedule_view.dart';
import 'package:moms_care/features/dashboard/persention/pages/care_schedules/care_schedule_delete_page.dart';
import 'package:moms_care/features/dashboard/persention/pages/dashboard_page.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/injection_container.dart' as di;


class AgeGroupPage extends StatefulWidget {
  const AgeGroupPage({super.key});

  @override
  State<AgeGroupPage> createState() => _AgeGroupPageState();
}

class _AgeGroupPageState extends State<AgeGroupPage> {
  
  List<AgeGroup>? ageGroups;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => di.sl<CareSchedulesBloc>()..add(const GetAllAgeGroupsEvent()),
      child:Scaffold(
          appBar: AppBarPageWidget(pageName: "Age Groups".tr,actions: [
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
    if(state is LoadedAgeGroupState){
        ageGroups=state.items;
      return   _buildBodyWidget(context,state);
    }
    return _buildBodyWidget(context,state);
  }
  Widget _buildBodyWidget(BuildContext context, state) {

    return (ageGroups==null) ?  EmptyWidget(explanatoryText:"Empty".tr,)
        :  RefreshIndicator(
      key: _refreshIndicatorKey ,
      onRefresh: () async  {
        BlocProvider.of<CareSchedulesBloc>(context).add(const GetAllAgeGroupsEvent());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(onPressed:()=>Get.offAll(HomePage(numberScreen: AppPages.HOME.index,)),),
            const Divider(),
            Expanded(
              child: Stack(
                children:[
                  Center(
                  child: ListView.builder(
                    itemBuilder: (context,index){
                      var item=ageGroups![index];
                      return ListTile(
                        title: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(item.min.toString()),
                                      const SizedBox(width: 20,),
                                      Text("-".tr),
                                      const SizedBox(width: 20,),
                                      Text(item.max.toString()),
                                      const SizedBox(width: 20,),
                                      Text("Months".tr),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(onPressed:()=> onEditItem(item),
                                          icon: const Icon(Icons.edit)),
                                      const SizedBox(width: 20,),
                                      IconButton(onPressed:()=>  onDeleteItem(item),
                                          icon: const Icon(Icons.delete))
                                    ],
                                  ),
              
                                ],
                              ),
                            ),
                            const Divider()
                          ],
                        ),
                      );
                    },
                    itemCount:ageGroups!.length,
                  ),
                  ),
                  FloatingActionButtonWidget(
                onPressed:(){
                  Get.to(const AddUpdateCareScheduleView<AgeGroup>(careScheduleItems: CareScheduleItems.AgeGroup));
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

  onEditItem(AgeGroup item) async{

    Get.to(AddUpdateCareScheduleView<AgeGroup>(scheduleItem:item, careScheduleItems: CareScheduleItems.AgeGroup));
  }

  onDeleteItem(AgeGroup item) {
    Get.to(CareScheduleDeletePage<AgeGroup>(scheduleItem:item, careScheduleType: CareScheduleItems.AgeGroup));
  }
}
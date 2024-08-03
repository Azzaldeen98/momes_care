

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:moms_care/core/constants/enam/CareSchedulesItems.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/button/floating_action_button.dart';
import 'package:moms_care/core/widget/button/item_memu_button_widget.dart';
import 'package:moms_care/core/widget/empty_widget.dart';
import 'package:moms_care/core/widget/state/loading_widget.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/events/add_update_delete_age_group_event.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/events/add_update_delete_care_type_event.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/care_schedules_bloc.dart';
import 'package:moms_care/features/dashboard/persention/pages/care_schedules/add_update_care_schedule_view.dart';
import 'package:moms_care/features/dashboard/persention/pages/care_schedules/care_schedule_delete_page.dart';
import 'package:moms_care/features/dashboard/persention/pages/dashboard_page.dart';
import 'package:moms_care/features/forum/presentation/wedgits/pages/delete_page.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/injection_container.dart' as di;

import '../../../../../core/widget/button/back_button_widget.dart';


class CareTypePage extends StatefulWidget {
  const CareTypePage({super.key});

  @override
  State<CareTypePage> createState() => _CareTypePageState();
}

class _CareTypePageState extends State<CareTypePage> {
  
  List<CareType>? careTypes;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => di.sl<CareSchedulesBloc>()..add(const GetAllCareTypesEvent()),
      child:Scaffold(
          appBar: AppBarPageWidget(pageName: "Care Types".tr,actions: [
            BackButtonWidget(onPressed:()=>Get.offAll(HomePage(numberScreen: AppAdminPages.DASHBOARD.index,)),),
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
    if(state is LoadedCareTypeState){
        careTypes=state.items;
      return   _buildBodyWidget(context,state);
    }
    return _buildBodyWidget(context,state);
  }
  Widget _buildBodyWidget(BuildContext context, state) {

    return (careTypes==null) ?  EmptyWidget(explanatoryText:"Empty".tr,)
        :  RefreshIndicator(
      key: _refreshIndicatorKey ,
      onRefresh: () async  {
        BlocProvider.of<CareSchedulesBloc>(context).add(const GetAllCareTypesEvent());
      },
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Expanded(
              flex: 10,
              child: Stack(
                children:[
                  Center(
                  child: ListView.builder(
                    itemBuilder: (context,index){
                      var item=careTypes![index];
                      return ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ItemMenuButtonWidget(title:item.name,
                                      onPress: () =>onSelectedItem(item),
                                  endIcon:false,),
                                ),
                              IconButton(onPressed:()=> onEditItem(item),
                                  icon: const Icon(Icons.edit)),
                              const SizedBox(width: 10,),
                              IconButton(onPressed:()=>  onDeleteItem(item),
                                  icon: const Icon(Icons.delete))
                              ],
                            ),
                            const Divider(),
                            // Text(careTypes![index].state.toString()),
                          ],
              
                        ),
                      );
              
                    },
                    itemCount:careTypes!.length,
                  ),
                  ),
              FloatingActionButtonWidget(
                onPressed:(){
                  Get.to(const AddUpdateCareScheduleView<CareType>(careScheduleItems: CareScheduleItems.CareTypes));
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

  void onSelectedItem(CareType item) {
  }

  onEditItem(CareType item) async{

    Get.to(AddUpdateCareScheduleView<CareType>(scheduleItem:item, careScheduleItems: CareScheduleItems.CareTypes));
  }

  onDeleteItem(CareType item) {
    Get.to(CareScheduleDeletePage<CareType>(scheduleItem:item, careScheduleType: CareScheduleItems.CareTypes));
  }
    // BlocProvider.of<AddUpdateDeleteCareScheduleBloc>(context).add(DeleteCareTypeEvent(id: item.id));

}
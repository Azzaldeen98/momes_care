

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/widget/state/error_page_widget.dart';
import 'package:moms_care/core/widget/state/loading_widget.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/care_schedules_bloc.dart';
import 'package:moms_care/injection_container.dart' as di;


class CareSchedulesView extends StatefulWidget {
  const CareSchedulesView({super.key});

  @override
  State<CareSchedulesView> createState() => _CareSchedulesViewState();
}

class _CareSchedulesViewState extends State<CareSchedulesView> {
  @override
  Widget build(BuildContext context) {
  return  BlocProvider(create: (context) => di.sl<CareSchedulesBloc>(),
    child: Scaffold(
      body: BlocConsumer<CareSchedulesBloc,CareSchedulesState>(
          builder: _builderCareSchedulesWidgetBlocState,
          listener: _listenerCareSchedulesBlocState
      ) ,
    )
    );
  
  }


  Widget _builderCareSchedulesWidgetBlocState(BuildContext context, state) {
    if(state is LoadingCareSchedulesState ){
      return const  LoadingVehicleWidget();
    }
    if(state is ErrorCareSchedulesState){
      return const ErrorPageWidget();//Center(child: Text(state.message,style: AppTextStyles.getErrorStyle(),),);
    }
    else if(state is LoadedCareSchedulesState){
      Get.back();
 
      return _buildBodyWidget(context);
    }
    return _buildBodyWidget(context);
  }

  void _listenerCareSchedulesBlocState(BuildContext context, state) {
  }

  Widget _buildBodyWidget(BuildContext context) {


    return SizedBox();
  }
}
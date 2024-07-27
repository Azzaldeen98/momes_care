

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/button/back_button_widget.dart';
import 'package:moms_care/core/widget/state/error_page_widget.dart';
import 'package:moms_care/core/widget/state/loading_widget.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/broadcast_live.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_bloc.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_event.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_state.dart';
import 'package:moms_care/features/broadcast_live/persention/widget/form_add_edit_course_widget.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/injection_container.dart' as di;
class AddUpdateBroadcastLivePage extends StatefulWidget{

  AddUpdateBroadcastLivePage({this.broadcastLive});
  final BroadcastLive? broadcastLive;
  @override
  State<AddUpdateBroadcastLivePage> createState() => _AddUpdateBroadcastLivePageState();
}
class _AddUpdateBroadcastLivePageState extends State<AddUpdateBroadcastLivePage>{

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create:(context)=> di.sl<BroadcastLiveBloc>(),
    child:Scaffold(
      appBar: AppBarPageWidget(pageName: "Broadcast Live".tr,actions: [

        BackButtonWidget(onPressed:
          ()=>Get.offAll(HomePage(numberScreen: AppPages.BROADCASTLIVE.index,))),
      ],),
        // bottomNavigationBar: Helper.buttonNavigation,
         body:  _buildBodyWidget(context),
        // body: BlocConsumer<BroadcastLiveBloc,BroadcastLiveState>(
        //   builder:_builderBodyBlocWidget,
        //   listener:_listenerBodyBlocWidget ,)
    ),
    );
  }

  void _listenerBodyBlocWidget(BuildContext context,BroadcastLiveState state){
    this.context=context;
    if(state is LoadingBroadcastLiveState ){
      MessageBox.showProgress(context, WAIT_MESSAGE);
    }
    if(state is ErrorBroadcastLiveState){
      Get.back();
      MessageBox.showError(context, state.message);
      //Center(child: Text(state.message,style: AppTextStyles.getErrorStyle(),),);
    }
    else if(state is AddUpdateDeleteBroadcastLiveSuccessState){
      Get.back();
      SnackBarBuilder.ShowSuccess(context: context ,message:UPLOAD_IMAGE_SUCCESS_MESSAGE);
       Get.offAll(HomePage(numberScreen: AppPages.BROADCASTLIVE.index,));
    }

  }
  Widget _builderBodyBlocWidget(BuildContext context,BroadcastLiveState state){
    this.context=context;
    if(state is LoadingBroadcastLiveState ){
      return const  LoadingVehicleWidget();
    }
    if(state is ErrorBroadcastLiveState){
      return const ErrorPageWidget();//Center(child: Text(state.message,style: AppTextStyles.getErrorStyle(),),);
    }
    else if(state is LoadedBroadcastLivesState){
      setState(() {});
      return _buildBodyWidget(context);
    }
    return _buildBodyWidget(context);
  }
  Widget _buildBodyWidget(BuildContext contex){
  return
    Padding(
      padding: EdgeInsets.all(8.0),
      child: KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible){
            return  SingleChildScrollView(
                padding: EdgeInsets.only(bottom: isKeyboardVisible ? MediaQuery.of(context).viewInsets.bottom : 0,),
                child: FormAddEditBroadcastLiveWidget(
                  isUpdate: widget.broadcastLive!=null,
                  onSubmitAdd:onSubmitAddBroadcastLive,
                  broadcastLive:widget.broadcastLive,)
            );
          }),
    );
  }

  onSubmitAddBroadcastLive(BroadcastLive broadcastLive) async{
          Get.back();
        if(broadcastLive!=null){
          BlocProvider.of<BroadcastLiveBloc>(context).add(AddBroadcastLiveEvent(broadcastLive: broadcastLive));
        }

  }

  onSubmitUpdateBroadcastLive(BroadcastLive broadcastLive) async{

    BlocProvider.of<BroadcastLiveBloc>(context).add(UpdateBroadcastLiveEvent( broadcastLive: broadcastLive));
  }
}
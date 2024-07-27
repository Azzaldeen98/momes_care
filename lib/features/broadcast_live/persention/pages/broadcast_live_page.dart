import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';

import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/button/avater_glow_broadcast_live_btn_widget.dart';
import 'package:moms_care/core/widget/button/floating_action_button.dart';
import 'package:moms_care/core/widget/empty_widget.dart';
import 'package:moms_care/core/widget/state/error_page_widget.dart';
import 'package:moms_care/core/widget/state/loading_widget.dart';
import 'package:moms_care/core/widget/video/youtube_player_widget.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/broadcast_live.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_bloc.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_event.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_state.dart';
import 'package:moms_care/features/broadcast_live/persention/pages/add_update_broadcast_live_page.dart';
import 'package:moms_care/features/broadcast_live/persention/pages/broadcast_live_details.dart';
import 'package:moms_care/features/broadcast_live/persention/widget/broadcast_live_widget.dart';
import 'package:moms_care/features/home/persention/pages/home_paga1.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/injection_container.dart' as di;



class BroadcastLivePage extends StatefulWidget {
  const BroadcastLivePage({super.key});
  @override
  State<BroadcastLivePage> createState() => _BroadcastLivePageState();
}

class _BroadcastLivePageState extends State<BroadcastLivePage>   {

  List<BroadcastLive>? broadcastLives;
  int countLives=0;
  int countCurrentUserLives=0;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    countLives=broadcastLives==null? 0: broadcastLives!.length;
  }

  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
        create:(context)=> di.sl<BroadcastLiveBloc>()..add(const GetActivesBroadcastLivesEvent()),
        child: Scaffold(
          appBar: AppBarPageWidget(pageName: "Broadcast Live".tr,),
          bottomNavigationBar: Helper.buttonNavigation,
            // floatingActionButton: const AvatarGlowBroadcastLivePageWidget(iconUrl: AppImage.LIVE),
            // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
          body: BlocConsumer<BroadcastLiveBloc,BroadcastLiveState>(
            builder:_builderBodyBlocWidget,
            listener:_listenerBodyBlocWidget ,)
        ),
    );
  }

  Widget _builderBodyBlocWidget(BuildContext context, BroadcastLiveState state) {

    if(state is LoadingBroadcastLiveState ){
      return const  LoadingVehicleWidget();
    }
    if(state is ErrorBroadcastLiveState){
      return const ErrorPageWidget();//Center(child: Text(state.message,style: AppTextStyles.getErrorStyle(),),);
    }
    else if(state is LoadedBroadcastLivesState){
      Get.back();
      broadcastLives=state.broadcastLives;
      return _buildBodyWidget(context);
    }
    return _buildBodyWidget(context);
  }
  void _listenerBodyBlocWidget(BuildContext context, BroadcastLiveState state) {

    // if(state is LoadingBroadcastLiveState ){
    //   MessageBox.showProgress(context, WAIT_MESSAGE);
    // }
    if(state is ErrorBroadcastLiveState){
      Get.back();
      MessageBox.showError(context, state.message);
      // Get.offAll(HomePage(numberScreen:AppPages.COURSES.index));
    }
    else if(state is AddUpdateDeleteBroadcastLiveSuccessState){
      MessageBox.showSuccess(context, state.message);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _refreshIndicatorKey.currentState?.show();
      });
    }
    else if(state is LoadedBroadcastLivesState){
      Get.back();
      setState(() {
        broadcastLives=state.broadcastLives;
      });

    }
    else if(state is StopBroadcastLiveSuccessState){
      Get.back();
      MessageBox.showSuccess(context, DELETE_SUCCESS_MESSAGE);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _refreshIndicatorKey.currentState?.show();
      });
    }
  }
  Widget _buildBodyWidget(BuildContext context) {
    int countLives=broadcastLives==null? 0: broadcastLives!.length;

    return  RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh:()async{
        BlocProvider.of<BroadcastLiveBloc>(context).add(const GetActivesBroadcastLivesEvent());
      } ,
      child: Stack(
        children: [
          (broadcastLives==null || broadcastLives!.isEmpty) ? const EmptyWidget()
              : Container(
                padding: EdgeInsets.zero,
                child: ListView.builder(
                  itemBuilder: (context,index){
                    final  item= broadcastLives![index];
                    if(item?.user?.id==Helper.userId) {
                      countCurrentUserLives++;
                    }
                    if(item?.user==null || item?.user?.id==null) {
                      return   SizedBox(child: Text("${item.id}"),);
                    } else {
                      return  ListTile(
                       title: Column(
                         children: [
                           BroadcastLiveWidget(broadcastLive: item,onPressed:onSelectedBroadcastLive,),
                           const SizedBox(height: 20),
                           const Divider(height: 10,thickness: 5,),
                         ],
                       ) ,
                    );
                    }
                  },
                  itemCount: broadcastLives!.length,

                ),
              ),
            Positioned(
            top: -30,
            left: -30,
            child:AvatarGlowBroadcastLivePageWidget(
              animate: countLives > 0 ,
              iconUrl: AppImage.LIVE,
              counts:countLives,
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _refreshIndicatorKey.currentState?.show();
                });
            },)),
          (Helper.IsDoctor)? FloatingActionButtonWidget(
            icon:Icons.add,
            bottom: 16.0,
            right: 10.0,
            onPressed:onClickAddButton,):const SizedBox(),
        ],
      ),
    );
  }
  void onClickAddButton() async{
      Get.off(AddUpdateBroadcastLivePage());
      await Future.delayed(const Duration(seconds: 2));
  }
  void onSelectedBroadcastLive(BroadcastLive broadcastLive) async{
    Get.off(BroadcastLiveDetails(broadcastLive: broadcastLive,));
    await Future.delayed(const Duration(seconds: 2));
  }
  void onEditBroadcastLive(BroadcastLive broadcastLive) async{
    Get.off(AddUpdateBroadcastLivePage(broadcastLive: broadcastLive,));
    await Future.delayed(const Duration(seconds: 2));
  }









}



import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/core/utils/dailog/message/dssd.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/button/back_button_widget.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import 'package:moms_care/core/widget/button/update_delete_button_widget.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/broadcast_live.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_bloc.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_event.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_state.dart';
import 'package:moms_care/features/broadcast_live/persention/pages/add_update_broadcast_live_page.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/injection_container.dart' as di;
class BroadcastLiveDetails  extends StatelessWidget{

  const BroadcastLiveDetails({super.key, required this.broadcastLive});
 final BroadcastLive broadcastLive;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(create:(context)=> di.sl<BroadcastLiveBloc>(),
     child:  Scaffold(
          appBar: AppBarPageWidget(pageName: "broadcastLive Details".tr,actions: [
            BackButtonWidget(
                onPressed:()=> Get.offAll(HomePage(numberScreen:AppPages.BROADCASTLIVE.index,))),
          ],),
          body:BlocConsumer<BroadcastLiveBloc,BroadcastLiveState>(
          builder:_builderBodyBlocWidget,
          listener:_listenerBodyBlocWidget ),
      ),
    );
  }
  Widget _builderBodyBlocWidget(BuildContext context, BroadcastLiveState state) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30,),
              if(broadcastLive!=null)
              // BroadcastLiveWidget(broadcastLive:broadcastLive,),
              const SizedBox(height: 10,),
              UpdateDeleteButtonWidget(onUpdate:onUpdatebroadcastLive ,onDelete:()=>onDeletebroadcastLive(context)),
             const SizedBox(height: 50,),
              CustomButton(
                  widthPercent: 90,
                  labelText: "View broadcastLive Items".tr,
                  icon:const Icon(Icons.visibility,
                    color: AppColor.primaryIconColor,),
                  bgColor: AppColor.buttonPrimaryColor,
                  onPressed:  onViewbroadcastLiveJoins),
              const SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
// Widget _buildControlsWidget(BuildContext context){
//     return  (Helper.IsAdmin)? Container(
//       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//       decoration: BoxDecoration(
//         // color: AppColor.opacitybgCololr,
//         border:Border.all(color: AppColor.opacitybgCololr),
//         borderRadius: BorderRadius.circular(10)
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           CustomButton(
//               height:50,
//               widthPercent: 10,
//               // border: Border.all(color: AppColor.whiteColor),
//               labelText: "",
//               icon:const Icon(Icons.edit,
//                 color: AppColor.primaryLightIconColor,),
//               onPressed: onUpdatebroadcastLive),
//           Container(
//             width: 1,
//             height: 40,
//             margin: EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//               // color: AppColor.primaryTextColor,
//                  border:Border.symmetric(vertical:  BorderSide(color: Colors.black26,width: 2)),
//             ),
//           ),
//           const SizedBox(width: 10),
//           CustomButton(
//             // border: Border.all(color: AppColor.whiteColor),
//               height:50,
//               widthPercent: 10,
//               labelText: "",
//               icon:const Icon(Icons.delete,
//                   color: AppColor.primaryLightIconColor),
//               onPressed: ()=> onDeletebroadcastLive(context)),
//         ],
//       ),
//     )
//         :const SizedBox();
// }
void _listenerBodyBlocWidget(BuildContext context, BroadcastLiveState state) async{
    if(state is LoadingBroadcastLiveState){
      MessageBox.showProgress(context, WAIT_MESSAGE);
      await Future.delayed(const Duration(seconds: 5));
    }
    if(state is ErrorBroadcastLiveState){
      Get.back();
      MessageBox.showError(context, state.message);
      await Future.delayed(const Duration(seconds: 5));
    }
    else if(state is AddUpdateDeleteBroadcastLiveSuccessState){
      // MessageBox.showError(context, state.message);
      SnackBarBuilder.ShowSuccess(context: context ,message:state.message);
       Get.offAll(HomePage(numberScreen: AppPages.BROADCASTLIVE.index,));
      // Get.back();
       await Future.delayed(const Duration(seconds: 5));
    }



  }


 void onUpdatebroadcastLive() async{
      Get.offAll(AddUpdateBroadcastLivePage(broadcastLive: broadcastLive,));
  }

  void onDeletebroadcastLive(BuildContext _context) async{
    ShowAwesomeDialogBox(context:_context,dialogType: DialogType.question ,message: DELETE_CONSENT_MESSAGE,onAccept:() async{
      if(broadcastLive!=null) {
        BlocProvider.of<BroadcastLiveBloc>(_context).add(DeleteBroadcastLiveEvent(id: broadcastLive!.id!));
      }
    } );

  }



  onViewbroadcastLiveJoins() {
  }
}
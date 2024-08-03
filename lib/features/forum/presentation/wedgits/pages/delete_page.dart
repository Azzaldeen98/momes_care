
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import 'package:moms_care/core/widget/button/button_widget.dart';

import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_event.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_state.dart';

class DeletePage extends StatelessWidget {

const  DeletePage({required this.onAccepted,required this.onDeleted});

final Function(BuildContext context) onAccepted;
final Function(BuildContext context) onDeleted;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdateState>(
    builder: _builderPageBlocState,
    listener: _listenerPageBlocState,
    );
  }

  Widget _builderPageBlocState(BuildContext context, AddDeleteUpdateState state ) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }
  void _listenerPageBlocState(BuildContext context, AddDeleteUpdateState state){

    if (state is LoadingAddDeleteUpdateState) {
      print("LoadedPostsState99");
      MessageBox.showProgress(context!,WAIT_MESSAGE);
    }
    if (state is ErrorAddDeleteUpdateState) {
      Get.back();
      SnackBarBuilder.ShowError(context: context ,message:state.message!);
    } else if (state is AddDeleteUpdateSuccessState) {
      SnackBarBuilder.ShowSuccess(context: context, message: state.message!);
      onDeleted(context);
      Get.back();

      // Get.offAll(HomePage(numberScreen: NumberOfScreens.FORUM.index,));
    }
    else{
      Get.back();
    }
  }

  AppBar  _buildAppBar(){
  return AppBar(title:Text("Delete Item"!),
    backgroundColor: AppColor.primaryAppBarColor,
  );
}
  Widget _buildBody(BuildContext context){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
        ),
      ),
    );
  }



}

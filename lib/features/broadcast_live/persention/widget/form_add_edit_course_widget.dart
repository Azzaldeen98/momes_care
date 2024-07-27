


import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/constants/enam/broadcast_live_status.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/utils/validator/validator.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/broadcast_live.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_bloc.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_event.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_state.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../config/theme/text_style.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import 'package:moms_care/core/widget/text_field/text_field_widget.dart';

class FormAddEditBroadcastLiveWidget extends StatefulWidget{

  final BroadcastLive? broadcastLive;
  final bool isUpdate;
  final Function(BroadcastLive)? onSubmitAdd,onSubmitUpdate;


  const FormAddEditBroadcastLiveWidget({
    this.isUpdate=false,
    this.broadcastLive,
    this.onSubmitAdd,
    this.onSubmitUpdate,
  }) ;

  @override
  State<FormAddEditBroadcastLiveWidget> createState() => _FormAddEditBroadcastLiveWidgetState();
}

class _FormAddEditBroadcastLiveWidgetState  extends State<FormAddEditBroadcastLiveWidget>{

  final _formKey= GlobalKey<FormState>();

  TextEditingController urlController=TextEditingController();
  TextEditingController descriptController=TextEditingController();

  // BroadcastLiveType? _broadcastLiveType;
  String? _urlFile;
  BuildContext? _context;


  @override
  void initState() {

    if(widget.isUpdate && widget.broadcastLive!=null){
      urlController.text=widget.broadcastLive!.descript??"";
      descriptController.text=widget.broadcastLive!.descript??"";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BroadcastLiveBloc,BroadcastLiveState>(
      builder:_builderBodyBlocWidget,
      listener:_listenerBodyBlocWidget ,);
  }


  Widget _builderBodyBlocWidget(BuildContext context, BroadcastLiveState state) {

    return _buildBodyPageWidget();
  }

  void _listenerBodyBlocWidget(BuildContext context, BroadcastLiveState state) async{
    if(state is LoadingBroadcastLiveState ){
      MessageBox.showProgress(context, WAIT_MESSAGE);
      await Future.delayed(const Duration(seconds: 5));
    }
    if(state is ErrorBroadcastLiveState){
      Get.back();
      MessageBox.showError(context, state.message);
    }
    else if(state is AddUpdateDeleteBroadcastLiveSuccessState){
      Get.back();
      SnackBarBuilder.ShowSuccess(context: context ,message:ADD_SUCCESS_MESSAGE);
      Get.offAll(HomePage(numberScreen: AppPages.BROADCASTLIVE.index,));
      await Future.delayed(const Duration(seconds: 5));
    }


  }

  Widget _buildBodyPageWidget() {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(widget.isUpdate ? "Update Broadcast Live".tr: "Add Broadcast Live".tr,
              style: AppTextStyles.getTitleStyle(),),
            const SizedBox(height: 40),
            TextFieldWidget(
                controller:descriptController,
                multiLines:true,
                name:"Description".tr ,
                validator: (val)=> "".validator()!(val),
                textInputType: TextInputType.text,
                radius: 12,
                padding: 0,
                hintText: "Enter Description".tr),

           const SizedBox(height: 30,),
            TextFieldWidget(
                controller:urlController,
                multiLines:true,
                name:"Broadcast Live Url Link".tr ,
                validator:  (val)=> (""!.validator()!(_urlFile)==null)?null: "".validatorURL()!(val),
                textInputType: TextInputType.url,
                radius: 12,
                padding: 0,
                hintText: "Enter Broadcast Live Url Link".tr),
            // DropDownButtonWidget(
            //   items: broadcastLiveType.getStringValues(),
            //   values: broadcastLiveType.values,
            //   validator:(val)=> "".validatorDropDown()!(val),
            //   value: _broadcastLiveType,
            //   onChange: (value) {
            //     _broadcastLiveType = value;
            //     setState(() {});
            //   },
            //   name: "broadcastLive Type".tr ,
            //   radius: 12,
            //   padding: 0,
            // ),


            const SizedBox(height: 100,),
            CustomButton(
                widthPercent: 90,
                raduis: 10,
                labelText: widget.isUpdate ? "Update".tr :"Add".tr,
                icon: const Icon(Icons.start,color: AppColor.primaryIconColor,) ,
                bgColor: AppColor.PrimaryButtonLightColor,
                onPressed:() async{
                  validateFormThenUpdateOrAddPost();
                }),
          ],
        ),
      ),
    );
  }



  void validateFormThenUpdateOrAddPost() async{

    if(_formKey.currentState!.validate()){

      var broadcastLive=BroadcastLive(
        descript: descriptController.text,
        link: urlController.text,
        startDateTime: DateTime.now(),
        status: BroadcastLiveStatus.Active
      );

      if(widget.isUpdate && widget.broadcastLive!=null){
        broadcastLive=broadcastLive.copyWith(id: widget.broadcastLive!.id);
        BlocProvider.of<BroadcastLiveBloc>(context).add(UpdateBroadcastLiveEvent(broadcastLive: broadcastLive));
          // await widget.onSubmitUpdate!(broadcastLive!);
      }else{
        // await widget.onSubmitAdd!(broadcastLive!);
        BlocProvider.of<BroadcastLiveBloc>(context).add(AddBroadcastLiveEvent(broadcastLive: broadcastLive));
        Get.back();
      }

      }
    }



}

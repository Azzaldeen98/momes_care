

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import 'package:moms_care/core/constants/constants.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/constants/enam/gender.dart';
import 'package:moms_care/core/data/view_models/date_time_view_model.dart';
import 'package:moms_care/core/utils/dailog/message/dssd.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import 'package:moms_care/core/widget/image/image_widget.dart';
import 'package:moms_care/features/forum/presentation/wedgits/pages/delete_page.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/features/profile/domain/entities/baby_entity.dart';
import 'package:moms_care/features/profile/persention/bloc/baby/baby_bloc.dart';
import 'package:moms_care/features/profile/persention/bloc/baby/baby_event.dart';
import 'package:moms_care/features/profile/persention/bloc/baby/baby_state.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_bloc.dart';
import 'package:moms_care/features/profile/persention/pages/baby/add_update_baby_page.dart';
import 'package:moms_care/features/profile/persention/pages/baby/baby_daily_care_tims_schedule.dart';
import 'package:moms_care/features/profile/persention/widget/baby/baby_helper_methods.dart';
import 'package:moms_care/features/profile/persention/widget/back_button_widget.dart';
import 'package:moms_care/injection_container.dart' as di;
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';


class BabyDetailsPage extends StatelessWidget{

  BabyDetailsPage({super.key,  required this.baby});
  Baby? baby;

  @override
  Widget build(BuildContext context) {

    return  BlocProvider(
        create: (context) => di.sl<BabyBloc>(),
        child:BlocConsumer<BabyBloc,BabyState>(
          builder: _builderBabyDetailsWidgetBlocState,
          listener: _listenerBabyDetailsBlocState
      ));

  }
  Widget _builderBabyDetailsWidgetBlocState(BuildContext context, BabyState state) {

    String imgUrl=(baby?.urlImage!=null && baby?.urlImage!="")? baby?.urlImage!
        : getBabyIconByGender(baby?.gender!);;

    return   Scaffold(
      // bottomNavigationBar: Helper.buttonNavigation,
      appBar: AppBarPageWidget(pageName:"Baby details".tr,),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildBackButtonWidget(onPressed: ()=> Get.offAll( HomePage(numberScreen: AppPages.PROFILE.index,))),
                const SizedBox(height: 40,),
                ImageWidget(urlImage:imgUrl,width: 150,height: 150,),
                const SizedBox(height: 30),
                Column(
                  children: [
                    _buildDetailsTable(),
                    const SizedBox(height: 50,),
                    _buildDetailsFooter(context),
                  ],
                ),
              ],
            ),
          )),
    );
  }
  void _listenerBabyDetailsBlocState(BuildContext context, BabyState state) {

    if(state is LoadingBabiesState){
      Get.back();
      MessageBox.showDialog(context, textBody: WAIT_MESSAGE);
    }
    if(state is ErrorBabyState){
      Get.back();
      MessageBox.showError( context, state.message);
    }
    else  if(state is AddUpdateDeleteBabySuccessState){
      Get.back();
      SnackBarBuilder.ShowSuccess(context: context,message: state.message);
      Get.offAll(HomePage(numberScreen: AppPages.PROFILE.index,));
    }
  }
  Widget _buildDetailsFooter(BuildContext context){
    return Column(
      children: [
        CustomButton(widthPercent: 90,labelText: "Daily Care Times".tr,
            textStyle: AppTextStyles.getButtonTextStyle(color: AppColor.primaryTextColor),
            border: Border.all(),
            icon:const Icon(Icons.table_chart,color: AppColor.primaryLightIconColor), onPressed:(){
          if(baby!=null) {
            Get.to(BabyDailyCareTimesSchedulePage(baby: baby!,));
          }
            }),
        const SizedBox(height: 50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomButton(widthPercent: 40,labelText: "Edit".tr,
                border: Border.all(),
                textStyle: AppTextStyles.getButtonTextStyle(color: AppColor.primaryTextColor),
                icon:const Icon(Icons.edit,color: AppColor.primaryLightIconColor),
                onPressed:_onEditBabyInfo),
            CustomButton(widthPercent: 40,labelText: "Delete".tr,
                bgColor: AppColor.errorColor,
                icon:const Icon(Icons.delete,color: AppColor.primaryIconColor,), onPressed:()=>_onDeleteBaby(context)),
          ],
        ),
      ],
    );
  }
  Widget _buildDetailsTable(){
    return Container(
      padding: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.opacitybgCololr,width: 0.6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Table(
        children: [
          _buildTableRowItem(label:"Name".tr ,value: "${baby?.name}"),
          _buildTableRowItem(label:"Age".tr ,value: "${baby?.age}"),
          _buildTableRowItem(label:"Gender".tr ,value: "${GenderTypes[baby!.gender!.index]}"),
          _buildTableRowItem(label:"Date of Birth".tr ,value: "${DateTimeViewModel(dateTime:baby!.birthDay!).date}"),
          _buildTableRowItem(label:"Height".tr ,value:"${baby?.height} cm"),
          _buildTableRowItem(label:"Weight".tr ,value: "${baby?.weight}  kg"),
          _buildTableRowItem(label:"Number of Responsible Doctor".tr ,value: "${baby?.numberOfResponsibleDoctor}"),

        ],),
    );
  }
  TableRow _buildTableRowItem({String? label,String? value}){
    return TableRow(
      decoration: BoxDecoration(
      border:const Border(bottom:BorderSide(color: AppColor.opacitybgCololr,width:0.7 ), ),
      borderRadius:  BorderRadius.circular(15),
      ),
      children: [
        TableCell(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(label!),
        )),
        TableCell(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(value!),
        )),
      ]
    );
  }
  void _onEditBabyInfo() {
      Get.off(AddUpdateBabyPage(isUpdate: true,baby: baby,));
  }
  void _onDeleteBaby(BuildContext context) {
    ShowAwesomeDialogBox(context:context ,message: DELETE_CONSENT_MESSAGE,onAccept:() async{
       final int babyId=baby!.id ?? 0;
        if(babyId>0){
          BlocProvider.of<BabyBloc>(context).add(DeleteBabyEvent(id:babyId));
        }
    } );
  }

}
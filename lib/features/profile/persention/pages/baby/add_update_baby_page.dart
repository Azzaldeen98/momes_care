import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/cached/cached_name.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/constants/enam/app_refresh_data.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/helpers/cache_helper.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/features/profile/data/models/baby_model.dart';
import 'package:moms_care/features/profile/persention/bloc/baby/baby_bloc.dart';
import 'package:moms_care/features/profile/persention/bloc/baby/baby_state.dart';
import 'package:moms_care/features/profile/persention/pages/baby/baby_details.dart';
import 'package:moms_care/features/profile/persention/pages/profile_page.dart';
import 'package:moms_care/features/profile/persention/widget/baby/form_add_update_baby_widget.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';

import '../../../../../config/theme/text_style.dart';
import '../../../domain/entities/baby_entity.dart';
import '../../widget/back_button_widget.dart';
import 'package:moms_care/injection_container.dart' as di;

class AddUpdateBabyPage extends StatelessWidget{

  AddUpdateBabyPage({this.isUpdate=false,this.baby});
  final bool? isUpdate;
  final  Baby? baby;
  var title;

  @override
  Widget build(BuildContext context) {

    title=(isUpdate!)?"Update Baby".tr: "Add Baby".tr;

          return  BlocProvider(create: (context) => di.sl<BabyBloc>(),
            child: Scaffold(
                    // bottomNavigationBar: Helper.buttonNavigation,
                    appBar: AppBarPageWidget(pageName:title,),
                    body:  BlocConsumer<BabyBloc,BabyState>(
                    builder: _builderBabyWidgetBlocState,
                    listener: _listenerBabyBlocState)
                    )
                ,);


  }

  Widget _builderBabyWidgetBlocState(BuildContext context, BabyState state) {

    return KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible){
          return _buildBody(context,isKeyboardVisible);
        });
  }

  Widget _buildBody(BuildContext context,bool isKeyboardVisible){
    return SingleChildScrollView(
        padding: EdgeInsets.only(bottom: isKeyboardVisible ? MediaQuery.of(context).viewInsets.bottom : 0,),
        child: Column(
          children: [
            buildBackButtonWidget(onPressed: ()=> Get.offAll(HomePage(numberScreen: 3,))),
            SizedBox(height: 40,),
            Text(title,style: AppTextStyles.getTitleStyle(),),
            SizedBox(height: 40),
            FormAddUpdateBabyWidget(isUpdate:isUpdate!,baby:baby),
          ],
        ));
  }

  void _listenerBabyBlocState(BuildContext context, BabyState state) {

    if(state is LoadingBabiesState){
      Get.back();
      MessageBox.showDialog(context, textBody: WAIT_MESSAGE);
    }
    if(state is ErrorBabyState){
        Get.back();
        MessageBox.showError( context, state.message);
    }
    else  if(state is AddUpdateDeleteBabySuccessState) {
      Get.back();
      CacheHelper.removeAt(PROFILE_INFO_CACHED);
      SnackBarBuilder.ShowSuccess(context: context,message: state.message);
      Get.offAll(HomePage(numberScreen: AppPages.PROFILE.index,));
    }
  }
}
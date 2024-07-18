

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/widget/button/change_language_btn_widget.dart';

import '../../../config/theme/app_color.dart';
import '../../../config/theme/text_style.dart';
import '../../../features/auth/persention/page/auth_view.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import '../../utils/function/more_options_methods.dart';
import '../../utils/function/set_remove_auth.dart';
import '../bottom_sheets/DemoCWActionSheetScreen.dart';

class AppBarPageWidget extends StatelessWidget implements PreferredSizeWidget{

 final String? pageName;

 const AppBarPageWidget({this.pageName});


  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryAppBarColor,
      centerTitle: true,
      title: Text( pageName ?? 'AppName'.tr,style: TextStyle(color: Colors.white),),
      actions: [
        ChangeLanguageBtnWidget(),
        IconButton(
          onPressed:()=>onClickMoreOptions(context),
          icon: const Icon(Icons.more_vert, color: Colors.white,),
        ),

      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}
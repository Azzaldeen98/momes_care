

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/widget/button/change_language_btn_widget.dart';

import '../../utils/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import '../../../features/auth/persention/page/auth_view.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import '../../utils/function/more_options_methods.dart';
import '../../utils/function/set_remove_auth.dart';
import '../bottom_sheets/DemoCWActionSheetScreen.dart';

class AppBarPageWidget extends StatelessWidget implements PreferredSizeWidget{

 final String? pageName;
 final List<Widget>? actions;

 const AppBarPageWidget({this.pageName,this.actions});


  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryAppBarColor,
      centerTitle: true,
      title: Text( pageName ?? 'AppName'.tr,style: const TextStyle(color: Colors.white),),
      actions: [
        ChangeLanguageBtnWidget(),
        IconButton(
          onPressed:()=>onClickMoreOptions(context),
          icon: const Icon(Icons.more_vert, color: Colors.white,),
        ),
        // if(actions!=null)
          for(var action in actions??[])
              action,
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}
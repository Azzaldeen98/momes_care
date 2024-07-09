import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/local/locale_controller.dart';
import 'package:moms_care/config/routes/routes_name.dart';
import 'package:moms_care/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:moms_care/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';



class SplashPage extends StatelessWidget {

  const SplashPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Align(
      alignment: Alignment.topLeft,  // and bottomLeft
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppbar(context),
          body: Container(child:  Text(
            'Splash'.tr,
            style: TextStyle(
                color: Colors.black
            ),
          ),),
        ),
      ),
    );

  }
  
  _buildAppbar(BuildContext context) {
    return AppBar(
      title:  Text(
          'Splash'.tr,
          style: TextStyle(
            color: Colors.black
          ),
        ),
        actions: [
        ],
    );
  }




  
}
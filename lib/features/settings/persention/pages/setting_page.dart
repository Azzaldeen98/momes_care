import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/local/locale_controller.dart';
import 'package:moms_care/config/routes/routes_name.dart';

import 'package:moms_care/features/daily_news/domain/entities/article.dart';
import 'package:moms_care/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:moms_care/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:moms_care/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:moms_care/features/moms_care/presentation/bloc/local/speech/commands.dart';
import 'package:moms_care/features/moms_care/presentation/bloc/local/speech/speech.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>   {
  String  textSample = "";

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              SizedBox(height: 100,),
              Center(
                child: SizedBox(
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // ElevatedButton(
                      //   onPressed: () {
                      //     LocaleController().chingeLanguage(languageCode: 'ar');
                      //   },
                      //   child: Text("Arabic"),
                      // ),

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0).copyWith(bottom: 140),
                child: SubstringHighlight(
                  text: textSample,
                  textAlign: TextAlign.center,
                  terms: Command.commands,
                  textStyle: const TextStyle(

                    color: Colors.teal,
                    fontSize: 30,
                  ),
                  textStyleHighlight: const TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )),
    );
  }






}


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

class SpeechPage extends StatefulWidget {
  const SpeechPage({Key? key}) : super(key: key);

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> with TickerProviderStateMixin  {
  String textSample = "";//'Click button to start recording'.tr;
  bool isListening = false;
  bool flag=true;
  String btn_name="Arabic";
  // TabController _tabController;
  MotionTabBarController? _motionTabBarController;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 4,
      vsync: this,
    );
    //// Use normal tab controller
    // _tabController = TabController(
    //   initialIndex: 1,
    //   length: 4,
    //   vsync: this,
    // );

    //// use "MotionTabBarController" to replace with "TabController", if you need to programmatically change the tab

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      bottomNavigationBar:_buildBottomNavigationBar(),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title:  Text(
          'Speech Recognition'.tr,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await FlutterClipboard.copy(textSample);
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text('Text Copied to Clipboard'.tr)),
              );
            },
            icon: const Icon(
              Icons.copy,
              color: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButton: AvatarGlow(
        endRadius: 80,
        animate: isListening,
        glowColor: Colors.teal,
        child: FloatingActionButton(
          onPressed: toggleRecording,
          child: Icon(
            isListening ? Icons.circle : Icons.mic,
            size: 35,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                      ElevatedButton(
                        onPressed: () {

                          setState(() {
                            btn_name=(!flag)?"English":"Arabic";
                          });
                          LocaleController().chingeLanguage(languageCode: (flag)?'en':'ar');
                          flag=!flag;
                        },
                        child: Text(btn_name),
                      ),
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

  Future toggleRecording() => Speech.toggleRecording(
      onResult: (String text) => setState(() {
        textSample = text;
      }),
      onListening: (bool isListening) {
        setState(() {
          this.isListening = isListening;
        });
        if (!isListening) {
          Future.delayed(const Duration(milliseconds: 5000), () {
            Utils.scanVoicedText(textSample);
          });
        }
      });

  Widget _buildTabBarView(){
    return TabBarView(
      physics: NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
      // controller: _tabController,
      controller: _motionTabBarController,
      children: <Widget>[
        const Center(
          child: Text("Dashboard"),
        ),
        const Center(
          child: Text("Home"),
        ),
        const Center(
          child: Text("Profile"),
        ),
        const Center(
          child: Text("Settings"),
        ),
      ],
    );
  }
  Widget _buildBottomNavigationBar(){
    return  MotionTabBar(
      controller: _motionTabBarController, // ADD THIS if you need to change your tab programmatically
      initialSelectedTab: "Home",
      labels: const ["Dashboard", "Home", "Profile", "Settings"],
      icons: const [Icons.dashboard, Icons.home, Icons.people_alt, Icons.settings],

      // optional badges, length must be same with labels
      badges: [
        // Default Motion Badge Widget
        const MotionBadgeWidget(
          text: '10+',
          textColor: Colors.white, // optional, default to Colors.white
          color: Colors.red, // optional, default to Colors.red
          size: 18, // optional, default to 18
        ),

        // custom badge Widget
        Container(
          color: Colors.black,
          padding: const EdgeInsets.all(2),
          child: const Text(
            '11',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),

        // allow null
        null,

        // Default Motion Badge Widget with indicator only
        const MotionBadgeWidget(
          isIndicator: true,
          color: Colors.blue, // optional, default to Colors.red
          size: 5, // optional, default to 5,
          show: true, // true / false
        ),
      ],
      tabSize: 50,
      tabBarHeight: 55,
      textStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      tabIconColor: Colors.blue[600],
      tabIconSize: 28.0,
      tabIconSelectedSize: 26.0,
      tabSelectedColor: Colors.blue[900],
      tabIconSelectedColor: Colors.white,
      tabBarColor: Colors.white,
      onTabItemSelected: (int value) {
        setState(() {
          // _tabController!.index = value;
          _motionTabBarController!.index = value;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    // _tabController.dispose();
    _motionTabBarController!.dispose();
  }


}


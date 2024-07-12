import 'package:clipboard/clipboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/core/utils/function/set_auth.dart';
import 'package:moms_care/features/auth/persention/page/auth_view.dart';
import 'package:moms_care/features/moms_care/presentation/bloc/local/speech/commands.dart';
import 'package:moms_care/features/moms_care/presentation/bloc/local/speech/speech.dart';
import 'package:moms_care/features/moms_care/presentation/pages/splash/splash.dart';
import 'package:moms_care/features/speech/persention/pages/speech_page.dart';
import 'package:substring_highlight/substring_highlight.dart';
import '../../../../core/widget/bottom_sheets/DemoCWActionSheetScreen.dart';
import '../../../../core/widget/button/button_navigation_widget.dart';
import '../../../../core/widget/navigation_bar/bottom_navigation_bar.dart';
import '../../../../helpers/public_infromation.dart';
import '../../../../main.dart';
import '../../../forum/presentation/pages/post/posts_page.dart';
import '../../../settings/persention/pages/setting_page.dart';
import '/injection_container.dart' as di;
part 'home_page_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key,this.numberScreen=0}) : super(key: key);
  final int numberScreen ;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>   {

  String textSample = "";//'Click button to start recording'.tr;
  bool isListening = false;
  PageController? pageController;
  int numberScreen = 1;
  final pages=[
    const HomePageWidget() ,
    const PostsPage(),
    const SpeechPage(),
    const SettingsPage()
  ];

  @override
  void initState() {
    numberScreen = widget.numberScreen;
    pageController = PageController(initialPage: numberScreen);
    // pageController = PageController(initialPage: numberScreen);
    //(index)=>  setState(()=>numberScreen=index)

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Helper.bottomNavigation = BottomNavigationWidget(changeScreen: changeScreen, currentIndex: numberScreen);

    //   Helper.buttonNavigation  = ButtonNavigationWidget(
    //     changeScreen: changeScreen, currentIndex: numberScreen);

    return Scaffold(
            bottomNavigationBar: Helper.bottomNavigation,
            appBar: _buildAppBar(),
            body:  PageView(
                physics: const ClampingScrollPhysics(),
                onPageChanged: _changeScreen,
                controller: pageController,
                children: [
                  const HomePageWidget() ,
                  const PostsPage(),
                  const SpeechPage(),
                  const SettingsPage(),
                  // MomsCareView(changeScreen: changeScreen),
                  // const ProfileVeiw(),
                ]),
            // Container(child: pages[numberScreen]),
    );
    //   Stack(
    //   children: [
    //     PageView(
    //       // physics: const ClampingScrollPhysics(),
    //         onPageChanged: _changeScreen,
    //         controller: pageController,
    //         children: [
    //           PostsPage(),
    //           HomePage(),
    //           SpeechPage(),
    //           SpeechPage(),
    //           // MomsCareView(changeScreen: changeScreen),
    //           // const ProfileVeiw(),
    //         ]),
    //   ],
    // );
      // bottomNavigationBar: BottomNavigationWidget(changeScreen: changeScreen, currentIndex: numberScreen),
      // appBar: _buildAppBar(),
      //
      //  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,



      // BlocProvider<MomsCareBloc>(
      // create: (BuildContext context) =>
      // di.sl<MomsCareBloc>()..add(const GetMomsCareItemsEvent()),
      // child: Scaffold(
      //     bottomNavigationBar: Helper.bottomNavigation,
      //     // appBar: _buildAppBar(),
      //     // floatingActionButton: AvatarGlow(
      //     //   endRadius: 80,
      //     //   animate: isListening,
      //     //   glowColor: Colors.teal,
      //     //   child: FloatingActionButton(
      //     //     onPressed: toggleRecording,
      //     //     child: Icon(
      //     //       isListening ? Icons.circle : Icons.mic,
      //     //       size: 35,
      //     //     ),
      //     //   ),
      //     // ),
      //     // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //     body: SingleChildScrollView(
      //       child: PageView(
      //           physics: const ClampingScrollPhysics(),
      //           onPageChanged: _changeScreen,
      //           controller: pageController,
      //           children: [
      //              PostsPage(),
      //               HomePage(),
      //              SpeechPage(),
      //              SpeechPage(),
      //             // MomsCareView(changeScreen: changeScreen),
      //             // const ProfileVeiw(),
      //           ]),
      //     ),
      //
      //   ),

      // SafeArea(
      //   child: SingleChildScrollView(
      //       child: Container(
      //       color: Colors.white,
      //       child:
      //     ),
      //   ),
      // ),
    // );
  }
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.primaryAppBarColor,
      centerTitle: true,
      title:  Text(
        // 'Speech Recognition'.tr,
        'AppName'.tr,
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          onPressed: () async {

            showCupertinoModalPopup(context: context, builder: (BuildContext context) =>
                DemoCWActionMoreOptionSheetScreen(
                  onLogOut:() async{
                    try {
                      if (FirebaseAuth.instance != null && FirebaseAuth.instance.currentUser != null)
                        await FirebaseAuth.instance.signOut();
                    }
                    finally{

                        if(Helper.isAuth) {
                          await removeAuthAsync();
                        }
                        Get.offAll(AuthView());
                    }

                  }));


            // await FlutterClipboard.copy(textSample);
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text('Text Copied to Clipboard'.tr)),
            // );
          },
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
      ],
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

  void _changeScreen(int numberScreen) {
    this.numberScreen = numberScreen;
    setState(() {});
  }

  void changeScreen(int numberScreen) {
    while (Navigator.canPop(context)) {
      Get.back();
    }
    pageController!.animateToPage(numberScreen,
        duration: const Duration(microseconds: 300), curve: Curves.easeOutSine);
    setState(() {});
  }



}




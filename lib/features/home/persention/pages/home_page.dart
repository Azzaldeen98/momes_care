import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/features/broadcast_live/persention/pages/broadcast_live_page.dart';
import 'package:moms_care/features/courses/persention/pages/add_update_course_page.dart';
import 'package:moms_care/features/courses/persention/pages/courses_page.dart';
import 'package:moms_care/features/dashboard/persention/pages/dashboard_page.dart';
import 'package:moms_care/features/speech/persention/pages/speech_page.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/button/button_navigation_widget.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import '../../../forum/presentation/pages/post/posts_page.dart';
import '../../../profile/persention/pages/profile_page.dart';
import '../../../speech/persention/bloc/local/commands.dart';
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

  @override
  void initState() {
    numberScreen = widget.numberScreen;
    pageController = PageController(initialPage: numberScreen);
    //(index)=>  setState(()=>numberScreen=index)

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Helper.buttonNavigation = ButtonNavigationWidget(changeScreen: changeScreen,
        currentIndex: numberScreen) ;
    return Scaffold(
            // appBar: AppBarPageViewWidget(),
            body:  PageView(
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: _changeScreen,
                controller: pageController,
                children:[
                   const CoursesPage(),//AddUpdateCoursePage(),//const HomePageWidget() ,
                  const PostsPage(),
                  (Helper.IsAdmin)? const DashboardPage() :const SpeechPage(),
                  const BroadcastLivePage(),
                  ProfileScreen(),
                  const DashboardPage()
                ]),
    );
  }


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




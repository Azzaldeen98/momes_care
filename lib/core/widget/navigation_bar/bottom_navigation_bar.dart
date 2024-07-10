

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/features/forum/presentation/pages/post/posts_page.dart';
import 'package:moms_care/features/moms_care/presentation/pages/home/home_page.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

import '../../logic/navigation_logic.dart';

class BottomNavigationWidget extends StatefulWidget {
   BottomNavigationWidget({Key? key,this.currentIndex,this.changeScreen}) : super(key: key);

  final int? currentIndex;
  final void Function(int)? changeScreen;
  late NavigationLogic navigationLogic;
  late GlobalKey<TooltipState> tooltipkey;
  void update() {
    navigationLogic.chagneButtonNavigation();
  }

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends  State<BottomNavigationWidget>  with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    _motionTabBarController = MotionTabBarController(
      initialIndex: widget.currentIndex ?? 0,
      length: 4,
      vsync: this,
    );
  }
  @override
  Widget build(BuildContext context) {
    return  MotionTabBar(

      controller: _motionTabBarController, // ADD THIS if you need to change your tab programmatically
      initialSelectedTab: "Home".tr,
      labels:  [ "Home".tr,"Forum".tr, "Profile".tr, "Settings".tr],
      icons: const [ Icons.home,Icons.forum, Icons.people_alt, Icons.settings],

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
          _motionTabBarController!.index = value;
        });
        widget.changeScreen!(value);
        // switch(value){
        //   case 0: Get.offAll(() => const PostsPage()); break;
        //   case 1: Get.offAll(() => const HomePage()); break;
        //   case 2: Get.offAll(() => const HomePage()); break;
        //   case 3: Get.offAll(() => const HomePage()); break;
        // }
      },
    );
  }

  // Widget _buildTabBarView(){
  //   return TabBarView(
  //     physics: NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
  //     // controller: _tabController,
  //     controller: _motionTabBarController,
  //     children: <Widget>[
  //       const Center(
  //         child: Text("Dashboard"),
  //       ),
  //       const Center(
  //         child: Text("Home"),
  //       ),
  //       const Center(
  //         child: Text("Profile"),
  //       ),
  //       const Center(
  //         child: Text("Settings"),
  //       ),
  //     ],
  //   );
  // }
  @override
  void dispose() {
    super.dispose();

    // _tabController.dispose();
    _motionTabBarController!.dispose();
  }
}
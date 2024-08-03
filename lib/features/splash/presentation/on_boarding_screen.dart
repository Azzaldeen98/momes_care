import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/font_manager.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import 'package:moms_care/features/auth/persention/page/auth_view.dart';
import 'package:moms_care/features/splash/presentation/intro_screens/first_page_view.dart';
import 'package:moms_care/features/splash/presentation/intro_screens/second_page_view.dart';
import 'package:moms_care/features/splash/presentation/intro_screens/third_page_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:moms_care/core/utils/theme/images.dart';



class OnBoardingScreen extends StatefulWidget {

  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen>  createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  PageController _pageController = PageController();
  List<Widget> pages = [];
  bool onLastage=false;



  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        PageView(
          controller: _pageController,
          onPageChanged: (index){
           setState(() {
             onLastage=index==2;
           });
          },
          children: [
            FirstPageView(),
            SecondPageView(),
            ThridPageView(),
          ],
        ),
        Container(
          // padding: EdgeInsets.symmetric(vertical: 30),
          alignment: Alignment(0,0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            _bulidGestureDetector("Skip".tr,()=> _pageController.jumpToPage(2)),
            SmoothPageIndicator(controller: _pageController,count: 3,),
            onLastage? _bulidGestureDetector("Done".tr,()=> Get.offAll(() => const AuthView()))
            : _bulidGestureDetector("Next".tr,(){}),

              ],
            )),

      ],
    );
  }

  Widget _bulidGestureDetector(String text,Function onPressed){
    // ignore: avoid_returning_null_for_void, invalid_use_of_protected_member
    return GestureDetector(

        child: Text(text.tr,style:AppTextStyles.getBoldStyle(
            color: AppColor.PrimaryTextDarkColor,
            fontSize: FontSizeManager.s22)),
        onTap: (){
          _pageController.nextPage(duration: Duration(microseconds: 500),
              curve: Curves.easeIn);
          onPressed();

        });
  }

}
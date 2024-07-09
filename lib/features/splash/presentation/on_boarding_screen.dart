import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/config/theme/font_manager.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/features/auth/persention/page/auth_view.dart';
import 'package:moms_care/features/splash/presentation/intro_screens/first_page_view.dart';
import 'package:moms_care/features/splash/presentation/intro_screens/second_page_view.dart';
import 'package:moms_care/features/splash/presentation/intro_screens/third_page_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/utils/theme/images.dart';



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
            _bulidGestureDetector("skip".tr,()=> _pageController.jumpToPage(2)),
            SmoothPageIndicator(controller: _pageController,count: 3,),
            onLastage? _bulidGestureDetector("done".tr,()=> Get.offAll(() => const AuthView()))
            : _bulidGestureDetector("next".tr,(){}),

              ],
            )),

      ],
    );
  }

  Widget _bulidGestureDetector(String text,Function onPressed){
   return GestureDetector(
        child: Text(text.tr,style:AppTextStyles.getBoldStyle(
            color: AppColor.primaryTextColor,
            fontSize: FontSizeManager.s22).copyWith()),
        onTap: (){
          _pageController.nextPage(duration: Duration(microseconds: 500),
              curve: Curves.easeIn);
          onPressed();

        });
  }




  // @override
  // void afterFirstLayout(BuildContext context) {
  //   pages = [
  //     Image.asset(TypeImage.WALK_THEME_IMG1, height: context.height()),
  //     Image.asset(TypeImage.WALK_THEME_IMG2, height: context.height()),
  //     Image.asset(TypeImage.WALK_THEME_IMG3, height: context.height()),
  //   ];
  //
  //   setState(() {});
  // }
  //
  // @override
  // void setState(fn) {
  //   if (mounted) super.setState(fn);
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       body: Stack(
  //         children: [
  //           Container(
  //             height: context.height() * 0.72,
  //             decoration: boxDecorationWithRoundedCorners(
  //               borderRadius: BorderRadius.only(bottomRight: Radius.circular(180)),
  //               backgroundColor: t14_WalkThrough8BgColor,
  //             ),
  //           ),
  //           Container(
  //             height: context.height() - 0.5,
  //             child: PageView(
  //               controller: _pageController,
  //               children: pages.map((e) => e.cornerRadiusWithClipRRectOnly(bottomRight: 140)).toList(),
  //             ),
  //           ).cornerRadiusWithClipRRectOnly(bottomRight: 160),
  //           Positioned(
  //             bottom: 0,
  //             height: context.height() * 0.34,
  //             width: context.width(),
  //             child: Container(
  //               decoration: boxDecorationWithRoundedCorners(
  //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
  //                 backgroundColor: Colors.white,
  //               ),
  //               padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   DotIndicator(pageController: _pageController, pages: pages, indicatorColor: t14_TextField_BgColor),
  //                   16.height,
  //                   Text("t14_WalkThrough8_Title", style: boldTextStyle(size: 20)),
  //                   16.height,
  //                   Text("t14_WalkThrough8_SubTitle", textAlign: TextAlign.center, style: secondaryTextStyle(size: 16)),
  //                   16.height,
  //                   t14AppButton(
  //                     context,
  //                     onPress: () {
  //                       _pageController.nextPage(duration: _kDuration, curve: _kCurve);
  //
  //                     },
  //                     btnText: currentPage == 2 ? "t14_btn_WalkThrough2Start" : "t14_lbl_SignIn3",
  //                     bgColor: t14_colorLightSkyBlue,
  //                     width: 150,
  //                     shape: 25.0,
  //                     txtColor: t14_txt_BlueColor,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget t14AppButton(BuildContext context, {required String btnText, Color? bgColor, required double width, required double shape, Function? onPress, Color? txtColor}) {
  //   return ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: bgColor,
  //       elevation: 0.0,
  //       padding: EdgeInsets.all(14),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(shape)),
  //     ),
  //     onPressed: () {
  //       if (onPress != null) {
  //         onPress.call();
  //       }
  //     },
  //     child: Text(btnText, style: boldTextStyle(color: txtColor, size: 14)),
  //   ).withWidth(width);
  // }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moms_care/features/forum/presentation/pages/post/posts_page.dart';
// import '../../../order/presention/view/order_view.dart';
// import '../../../profile/presention/view/profile_view.dart';
import '../../../speech/persention/pages/speech_page.dart';
import '../bloc/moms_care/moms_care_bloc.dart';
import 'moms_care_view.dart';
import 'package:get/get.dart';
import '../../../../core/widget/button/button_navigation_widget.dart';
import '../../../../helpers/public_infromation.dart';
import '/injection_container.dart' as di;

class HomeView extends StatefulWidget {
  const HomeView({super.key, this.numberScreen = 1});
  final int numberScreen;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController? pageController;
  int numberScreen = 1;

  @override
  void initState() {
    numberScreen = widget.numberScreen;
    pageController = PageController(initialPage: numberScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Helper.buttonNavigation = ButtonNavigationWidget(
        changeScreen: changeScreen, currentIndex: numberScreen);
    return
      BlocProvider<MomsCareBloc>(
      create: (BuildContext context) =>
      di.sl<MomsCareBloc>()..add(const GetMomsCareItemsEvent()),
      child: Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Helper.buttonNavigation,
          body: PageView(
              physics: const ClampingScrollPhysics(),
              onPageChanged: _changeScreen,
              controller: pageController,
              children: [
                const PostsPage(),
                HomeView(),
                SpeechPage(),
                // MomsCareView(changeScreen: changeScreen),
                // const ProfileVeiw(),
              ]),
        ),
      ),
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

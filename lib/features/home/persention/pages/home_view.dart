import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../order/presention/view/order_view.dart';
// import '../../../profile/presention/view/profile_view.dart';
import '../logic/sps/sps_bloc.dart';
import 'sps_view.dart';
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
    return BlocProvider<SPSBloc>(
      create: (BuildContext context) =>
      di.sl<SPSBloc>()..add(const GetSparePartEvent()),
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
                // const OrderView(),
                Text("Welcom"),
                // SPSView(changeScreen: changeScreen),
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

import 'package:responsive_builder/responsive_builder.dart';
import '../../utils/theme/images.dart';
import '../../logic/navigation_logic.dart';
import '../../utils/style/border_radius.dart';
import '../../utils/theme/color_app.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../utils/theme/font_manager.dart';

// ignore: must_be_immutable
class ButtonNavigationWidget extends StatelessWidget {
  ButtonNavigationWidget(
      {Key? key, required this.currentIndex, required this.changeScreen})
      : super(key: key);
  final int currentIndex;
  final void Function(int) changeScreen;

  late NavigationLogic navigationLogic;
  late GlobalKey<TooltipState> tooltipkey;
  void update() {
    navigationLogic.chagneButtonNavigation();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: GetBuilder<NavigationLogic>(
        init: NavigationLogic(),
        builder: (controller) {
          navigationLogic = controller;
          return Row(children: [
            ...List.generate(
              ButtonInfo.values.length,
              (index) => Expanded(
                child: IconBottomApp(
                  buttonInfo: ButtonInfo.values[index],
                  check: currentIndex == index,
                  chingeScreen: changeScreen,
                  currentIndex: index,
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }
}

class IconBottomApp extends StatelessWidget {
  const IconBottomApp({
    super.key,
    required this.check,
    required this.chingeScreen,
    required this.currentIndex,
    required this.buttonInfo,
  });

  final bool check;
  final void Function(int) chingeScreen;
  final int currentIndex;
  final ButtonInfo buttonInfo;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => chingeScreen(currentIndex),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusAttributes.onlyBottom(8),
                color:
                    check ? AppColors.secondaryOneColor : Colors.transparent),
          ),
          const SizedBox(height: 5),
          // Construct and pass in a widget builder per screen type
          ScreenTypeLayout.builder(
            mobile: (BuildContext context) =>(this.buttonInfo.icon!=null)? this.buttonInfo.icon! : Image.asset(
                check ? buttonInfo.activeIcon! : buttonInfo.name,
                color: check ? AppColors.secondaryOneColor : Colors.grey,
                width: 22,
                height: 22),
            tablet: (BuildContext context) =>(this.buttonInfo.icon!=null)? this.buttonInfo.icon! : Image.asset(
                check ? buttonInfo.activeIcon! : buttonInfo.name,
                color: check ? AppColors.secondaryOneColor : Colors.grey,
                width: 32,
                height: 32),
          ),

          const SizedBox(height: 2),
          Text(buttonInfo.label.tr,
              style: TextStyle(
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: 11,
                    tablet: 18,
                  ),
                  fontWeight: FontWeight.w400,
                  color: check
                      ? AppColors.secondaryOneColor
                      : AppColors.grayForeColor,
                  fontFamily: FontFamilyNames.dINNEXTLTARABICLIGHT)),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

Widget _numberCart(int numberProduct) {
  return Text(
    numberProduct > 9 ? "+9" : "$numberProduct",
    style: const TextStyle(
      fontSize: 10,
      color: Colors.white,
    ),
  );
}

enum ButtonInfo {
  order(
    "Forum",
    AppImage.SHOP_CART_GREY,
    AppImage.SHOP_CART_GREY,
    false,
    true,
    icon: Icon(Icons.forum),
  ),
  home(
    "Home",
    AppImage.HOME_GREY,
    AppImage.HOME_GREY,
    false,
    false,
  ),

  profile(
    "Profile",
    AppImage.USER_GREY,
    AppImage.USER_GREY,
    false,
    false,

  ),
  settings(
    "Settings",
    AppImage.USER_GREY,
    AppImage.USER_GREY,
    false,
    false,

  );


  final String name;
  final String? activeIcon;
  final Icon? icon;
  final String label;
  final bool showNotification;
  final bool showCartProducts;
  const ButtonInfo(
    this.label,
    this.name,
    this.activeIcon,
    this.showNotification,
    this.showCartProducts, {
    this.icon,
  }
  );
}

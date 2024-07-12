import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/features/forum/presentation/pages/post/posts_page.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/constants/cached/cached_name.dart';
import '../../../../core/constants/enam/user_roles.dart';
import '../../../../core/utils/theme/images.dart';
import '../../../../helpers/cache_helper.dart';
import '../../../../helpers/public_infromation.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../../auth/persention/page/auth_view.dart';
import '../../../../core/widget/bottom_sheets/DemoCWActionSheetScreen.dart';
import '../../../home/persention/pages/home_page.dart';
import '../../../home/persention/pages/home_view.dart';
import '../on_boarding_screen.dart';



class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  SplashViewBodyState createState() => SplashViewBodyState();
}

class SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _goToNextView();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 250,
            width: 250,
            child: Image.asset(
              TypeImage.LOGO_COLORS,
              height: 250,
              width: 250,
            ),
          ),
          Text(
            "AppName".tr,
            style: AppTextStyles.getMediumStyle(fontSize: 20),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void _goToNextView() {
    Future.delayed(const Duration(seconds: 5), () async {

      if (Helper.isAuth) {
        String infoAccount = CacheHelper.getString(INFO_ACCOUNT_CACHED) ?? "";
        print("infoAccount: $infoAccount");

          final decodeJson = json.decode(infoAccount);
          Helper.auth = Auth.fromJson(decodeJson);
          Helper.isAdmin = Helper.auth?.userInfo != null &&
              Helper.auth?.userInfo?.role == UserRoles.ADMIN;
          Get.offAll(() =>  HomePage()); // DemoCWActionSheetScreen()

      }
      else
        Get.offAll(() => const OnBoardingScreen());

    });
  }
}

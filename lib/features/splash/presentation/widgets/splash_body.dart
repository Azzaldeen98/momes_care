import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/remote/firebase/firebase_message_actions.dart';
import 'package:moms_care/features/auth/persention/bloc/auth_bloc/auth_bloc.dart';
import 'package:moms_care/features/broadcast_live/persention/pages/broadcast_live_page.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/features/profile/persention/pages/baby/baby_details.dart';

import '../../../../config/theme/text_style.dart';
import 'package:moms_care/core/constants/cached/cached_name.dart';
import 'package:moms_care/core/constants/enam/user_roles.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/helpers/cache_helper.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../../profile/persention/pages/profile_page.dart';
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
    return BlocConsumer<AuthBloc,AuthState>(
        builder: _builderBodyByAuthBloc,
        listener: _listenerBodyByAuthBloc);
  }

  Widget _builderBodyByAuthBloc(BuildContext context, AuthState state) {
    return  SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 250,
            width: 250,
            child: Image.asset(
              AppImage.LOGO1,
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

  void _listenerBodyByAuthBloc(BuildContext context, AuthState state) {
  }

  void _goToNextView() {
    Future.delayed(const Duration(seconds: 5), () async {

      if (Helper.isAuth) {

        String infoAccount = CacheHelper.getString(INFO_ACCOUNT_CACHED) ?? "";
        print("infoAccount: $infoAccount");
        final decodeJson = json.decode(infoAccount);
        Helper.auth = Auth.fromJson(decodeJson);
        // Helper.isAdmin = CacheHelper.getInt(AUTH_ROLE_CACHED)==UserRoles.ADMIN.index;
        Helper.isAdmin = Helper.auth?.userInfo != null && Helper.auth?.userInfo?.role == UserRoles.ADMIN;

        FirebaseMessageActions.listenFCMToken(onRefreshFcmToken: (fcmToken) async{
          if(fcmToken!=null && fcmToken.isNotEmpty) {
            print("Splash-Response-FCM-Token: ${fcmToken!}");
            BlocProvider.of<AuthBloc>(context).add(RefreshFCMTokenEvent(fcmTocken: fcmToken));
          }
        });
        Get.offAll(() => const HomePage()); // DemoCWActionSheetScreen()

      }
      else {
        Get.offAll(() => const OnBoardingScreen());
      }

    });
  }


}

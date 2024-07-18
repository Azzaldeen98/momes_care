


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/core/constants/enam/profile_pages.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_bloc.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_event.dart';

import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/features/profile/persention/widget/image_profile_widget.dart';
import '../pages/profile_view.dart';

class ProfileUserInfoWidget extends StatelessWidget{

 const ProfileUserInfoWidget({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          ImageProfileWidget(urlImage: profile.image ?? ""),
          // _buildPictureUserWidget(),
          const SizedBox(height: 10),
          _buildUserInfoWidget(context),
          const SizedBox(height: 20),
        ],
      );

  }

  Widget _buildUserInfoWidget(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.zero,
          height: 40,
          width: 40,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(12)),
          child: IconButton(
            onPressed:()=> _updateUserInfo(context),
            // label: Text("Edit".tr),
            icon: Icon(Icons.edit),
          ),
        ),
        Column(
          children: [
            Text(profile!.displayName!, style: Theme.of(context).textTheme.titleLarge),
            Text(profile!.email!, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
  Widget _buildPictureUserWidget(){
    return         /// -- IMAGE
      Stack(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all(width: 3),
                borderRadius: BorderRadius.circular(50),),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: const Image(image: AssetImage(AppImage.RECEIPT))),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                  color: AppColor.primaryColor),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      );
  }


  void _updateUserInfo(BuildContext context) async{
    Get.off(ProfileView(profile: profile,));
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';
import 'package:moms_care/features/profile/persention/pages/pages_view/babies_widget.dart';
import 'package:moms_care/features/profile/persention/pages/pages_view/profile_settings_widget.dart';

class ProfileTabParWidget extends StatefulWidget{

  const ProfileTabParWidget({super.key,required this.profile,required this.bodyHeight});
  final double bodyHeight;
  final Profile profile;


  @override
  State<ProfileTabParWidget> createState() =>_ProfileTabParWidgetState();

}

class _ProfileTabParWidgetState extends State<ProfileTabParWidget>{

  // double? _bodyHeight;
  // Profile? profile;

  @override
  void initState() {

    // _bodyHeight=widget.bodyHeight;
    // profile=widget.profile;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _buildBodyTabBar(context);
  }

  Widget _buildItemTabBarWidget(String? name,IconData icon){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(icon,color: AppColor.primaryIconColor,),
        Tab(child: Text(name!,style: AppTextStyles.getBasicStyle(color: AppColor.PrimaryTextLightColor),),),
      ],
    );
  }
  Widget _buildHeaderTabBar(){
    return
      Container(
        height:50,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 0.9)),
        ),

        child: Material(
          color: AppColor.primaryAppBarColor,
          child: TabBar(
            tabs:[
              _buildItemTabBarWidget("Babies".tr,Icons.bedroom_baby_outlined),
              _buildItemTabBarWidget("Settings".tr,Icons.menu),
            ] ,
          ),
        ),
      );
  }
  Widget _buildBodyTabBar(BuildContext context){

    return  DefaultTabController(
      length: 2,
      child: Column(
        children: [
          _buildHeaderTabBar(),
          // SizedBox(height: 10,),
          SingleChildScrollView(
            child: Container(
              color: Colors.white,
              // height: double.maxFinite,
              height: widget.bodyHeight,
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      child: TabBarView(
                          children: [
                            BabiesWidget(babies: widget.profile!.babies!??[],),
                            ProfileSettingsWidget(profile: widget.profile,),
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
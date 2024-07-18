import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/core/constants/enam/gender.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/widget/empty_widget.dart';
import 'package:moms_care/core/widget/state/error_page_widget.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';

import 'package:moms_care/features/profile/persention/bloc/profile_bloc.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_event.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_state.dart';
import 'package:moms_care/features/profile/persention/pages/baby/baby_details.dart';
import 'package:moms_care/features/profile/persention/pages/pages_view/babies_widget.dart';
import 'package:moms_care/features/profile/persention/pages/pages_view/profile_settings_widget.dart';

import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';

import 'package:moms_care/injection_container.dart' as di;
import 'package:retrofit/http.dart';

import '../../../../core/widget/state/loading_widget.dart';
import '../../domain/entities/baby_entity.dart';
import '../widget/profile_user_info_widget.dart';
import '../widget/profile_user_statistics_widget.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // ProfileScreen({Key? key}) : super(key: key);

  late Profile profile;
  late bool isDark=false;
  final double basicBodyHeight = 300.0;
  double _bodyHeight = 300.0;
  double _bodyTopPosition = 300.0;


  @override
  Widget build(BuildContext context) {
    isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfilePostBloc>(
          create: (context) => di.sl<ProfilePostBloc>()..add(const GetMyPostsEvent()),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => di.sl<ProfileBloc>()..add(const GetProfileInfoEvent()),
        ),

      ],
      child: Scaffold(

        appBar: AppBarPageWidget(pageName: "Profile".tr,),
        bottomNavigationBar: Helper.buttonNavigation ,
        body: BlocConsumer<ProfileBloc,ProfileState>(
          builder: _buildProfilePageBlocState,
          //     (context,state){
          //   if (state is LoadingProfileState) {
          //     print("LoadedCommentsState99");
          //     return const Center(child: CupertinoActivityIndicator());
          //     // MessageBox.showProgress(context!,WAIT_MESSAGE);
          //   }
          //   if (state is ErrorProfileState) {
          //     Get.back();
          //     MessageBox.showError(context!,state.message!);
          //   }
          //   else if (state is LoadedProfileState) {
          //     return SizedBox(child: Text("profile"),);
          //   }
          //   return Center(child: SizedBox(child: Text("Empty".tr),));
          // }, //
          listener: _listenerProfilePageBlocState,),
      ),
    );
  }

  Widget _buildProfilePageBlocState(BuildContext context, ProfileState state) {

    if (state is LoadingProfileState) {
      print("LoadedCommentsState99");
      return const LoadingVehicleWidget(); //Center(child: CupertinoActivityIndicator());
      // MessageBox.showProgress(context!,WAIT_MESSAGE);
    }
    if (state is ErrorProfileState) {
      Get.back();
      // MessageBox.showError(context!,state.message!);
      // Get.offAll(BabyDetailsPage(baby: Baby(name: "Gana",height: 50
      //     ,id: 20,age: 0,birthDay: DateTime.now(),gender: Gender.female,
      // numberOfResponsibleDoctor: "778789546")));
      return ErrorPageWidget();
    }
    else if (state is LoadedProfileState) {
      Get.back();
      profile=state.profile;
      // SnackBarBuilder.ShowSuccess(context: context ,message:"Loaded Profile is Success");
      return _buildBodyWidget(context);
    }else{
      return const SizedBox();
    }

       //

  }
  void _listenerProfilePageBlocState(BuildContext context, ProfileState state) {

    if (state is ErrorProfileState) {
      // Get.back();
      MessageBox.showError(context!,state.message!);
    }
    else if (state is LoadedProfileState) {
      Get.back();
      // SnackBarBuilder.ShowSuccess(context: context ,message:"Loaded Profile is Success");
      // Get.back();
    }
  }
  Widget _buildBodyWidget(BuildContext context){

  return  GestureDetector(
    
      onVerticalDragUpdate: (details) {
        setState(() {
          if((_bodyTopPosition>100 && details.delta.dy < 0)
              || (_bodyTopPosition<300 && details.delta.dy > 0)){
            _bodyHeight -= details.delta.dy;
            _bodyTopPosition += details.delta.dy / 2;
          }
        });
      },
      onVerticalDragEnd: (details) {
        setState(() {
          // if (_bodyHeight < basicBodyHeight) {
          //   _bodyHeight = basicBodyHeight;
          //   _bodyTopPosition = 300;
          // }
        });
      },
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            // height: 300,
            child:   _buildProfileHeader(context),
          ),
          AnimatedPositioned(
            top: _bodyTopPosition,
            left: 0,
            right: 0,
            duration: Duration(milliseconds: 300),
            child: AnimatedContainer(
              // height: _bodyHeight,
              duration: Duration(milliseconds: 300),
              child:   _buildBodyTabBar(context),
            ),
          ),
        ],
      ),
    );
    // return Container(
    //   padding:  EdgeInsets.all(5.0),
    //   child: Column(
    //     children: [
    //       _buildProfileHeader(context),
    //       const Divider(height: 0),
    //       Expanded(child: _buildBodyTabBar(context)),
    //       const SizedBox(height: 0),
    //       // _buildMenu(),
    //     ],
    //   ),
    // );
  }
  Widget _buildProfileHeader(BuildContext context){
    return Container(

      child: Column(
        children: [
          ProfileUserInfoWidget(profile: profile,),
          ProfileUserStatisticsWidget(profile: profile,),
          SizedBox(height: 10,),
        ],
      ),
    );
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
          // color: AppColor.primaryAppBarColor,
        ),
        // constraints: BoxConstraints(maxHeight: 150.0),
        child: Material(
          // color: Colors.white,
           color: AppColor.primaryAppBarColor,
          child: TabBar(
            tabs:[
              _buildItemTabBarWidget("Babies".tr,Icons.bedroom_baby_outlined),
              // _buildItemTabBarWidget("Posts",Icons.post_add),
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
              height: _bodyHeight,
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      child: TabBarView(

                          children: [
                            // EmptyWidget(),
                            // MyPostsWidget() ,
                            BabiesWidget(babies: profile!.babies!??[],),
                            ProfileSettingsWidget(profile: profile,),
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

  AppBar _buildAppBar(BuildContext context){
    return AppBar(
      backgroundColor: AppColor.primaryAppBarColor,
      leading:Icon(Icons.arrow_back_ios ) ,//IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left_solid)),
      title: Text("Profile", style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color:AppColor.PrimaryTextLightColor )),
      actions: [IconButton(onPressed: () {isDark=!isDark;}, icon: Icon(!isDark ? Icons.sunny : Icons.shield_moon))],
    );
  }



}




// class UpdateProfileScreen extends StatelessWidget {
//   const UpdateProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ProfileController());
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left)),
//         title: Text(tEditProfile, style: Theme.of(context).textTheme.headline4),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(tDefaultSize),
//           child: Column(
//             children: [
//               // -- IMAGE with ICON
//               Stack(
//                 children: [
//                   SizedBox(
//                     width: 120,
//                     height: 120,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(100),
//                         child: const Image(image: AssetImage(tProfileImage))),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Container(
//                       width: 35,
//                       height: 35,
//                       decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(100), color: tPrimaryColor),
//                       child: const Icon(LineAwesomeIcons.camera, color: Colors.black, size: 20),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 50),
//
//               // -- Form Fields
//               Form(
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       decoration: const InputDecoration(
//                           label: Text(tFullName), prefixIcon: Icon(LineAwesomeIcons.user)),
//                     ),
//                     const SizedBox(height: tFormHeight - 20),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                           label: Text(tEmail), prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
//                     ),
//                     const SizedBox(height: tFormHeight - 20),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                           label: Text(tPhoneNo), prefixIcon: Icon(LineAwesomeIcons.phone)),
//                     ),
//                     const SizedBox(height: tFormHeight - 20),
//                     TextFormField(
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         label: const Text(tPassword),
//                         prefixIcon: const Icon(Icons.fingerprint),
//                         suffixIcon:
//                         IconButton(icon: const Icon(LineAwesomeIcons.eye_slash), onPressed: () {}),
//                       ),
//                     ),
//                     const SizedBox(height: tFormHeight),
//
//                     // -- Form Submit Button
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () => Get.to(() => const UpdateProfileScreen()),
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: tPrimaryColor,
//                             side: BorderSide.none,
//                             shape: const StadiumBorder()),
//                         child: const Text(tEditProfile, style: TextStyle(color: tDarkColor)),
//                       ),
//                     ),
//                     const SizedBox(height: tFormHeight),
//
//                     // -- Created Date and Delete Button
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text.rich(
//                           TextSpan(
//                             text: tJoined,
//                             style: TextStyle(fontSize: 12),
//                             children: [
//                               TextSpan(
//                                   text: tJoinedAt,
//                                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
//                             ],
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.redAccent.withOpacity(0.1),
//                               elevation: 0,
//                               foregroundColor: Colors.red,
//                               shape: const StadiumBorder(),
//                               side: BorderSide.none),
//                           child: const Text(tDelete),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



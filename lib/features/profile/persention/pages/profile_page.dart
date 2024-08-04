import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/cached/cached_name.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/helpers/cache_helper.dart';
import 'package:moms_care/core/widget/empty_widget.dart';
import 'package:moms_care/core/widget/state/error_page_widget.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';

import 'package:moms_care/features/profile/persention/bloc/profile_bloc.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_event.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_state.dart';
import 'package:moms_care/features/profile/persention/pages/pages_view/profile_settings_widget.dart';

import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/features/profile/persention/widget/profile_tab_par.dart';

import 'package:moms_care/injection_container.dart' as di;

import 'package:moms_care/core/widget/state/loading_widget.dart';
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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (context) => di.sl<ProfileBloc>()..add(const GetProfileInfoEvent()),
        ),
      ],
      child:RefreshIndicator(
        key: _refreshIndicatorKey ,
    onRefresh: () async  {
    BlocProvider.of<ProfileBloc>(context).add(const RefreshProfileInfoEvent());
    },child:  Scaffold(
        appBar: AppBarPageWidget(pageName: "Profile".tr,),
        bottomNavigationBar: Helper.buttonNavigation ,
        body: BlocConsumer<ProfileBloc,ProfileState>(
          builder: _buildProfilePageBlocState,
          listener: _listenerProfilePageBlocState,),

      ),
      ),
    );
  }

  Widget _buildProfilePageBlocState(BuildContext context, ProfileState state) {

    if (state is LoadingProfileState) {
      return const LoadingVehicleWidget(); //Center(child: CupertinoActivityIndicator());
    }
    if (state is ErrorProfileState) {
      Get.back();
      return const ErrorPageWidget();
    }
    else if (state is AddUpdateDeleteProfileSuccessState) {

      return _buildBodyWidget(context);
    }
    else if (state is LoadedProfileState) {
      profile=state.profile;
      return _buildBodyWidget(context);
    }else{
      return const SizedBox();
    }
  }
  void _listenerProfilePageBlocState(BuildContext context, ProfileState state) {

    if (state is LoadingProfileUpdateState) {
      MessageBox.showProgress(context, WAIT_MESSAGE);
    }
    if (state is ErrorProfileState) {
      Get.back();
      MessageBox.showError(context!,state.message!);
    }
    else if (state is LoadedProfileState) {
      Get.back();
      setState(() {profile=state.profile;});
      // SnackBarBuilder.ShowSuccess(context: context ,message:"Loaded Profile is Success");
    }
    else if (state is UpdateProfileUserInfoSuccessState) {
      Get.back();
      SnackBarBuilder.ShowSuccess(context: context ,message:state.message);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _refreshIndicatorKey.currentState?.show();
      });
    }
    else if (state is UploadImageSuccessfulState) {
       Get.back();
       SnackBarBuilder.ShowSuccess(context: context ,message:UPDATE_SUCCESS_MESSAGE);//"Update image is Successfully".tr);
       CacheHelper.removeAt(PROFILE_INFO_CACHED);
       Get.offAll(HomePage(numberScreen: AppPages.PROFILE.index,));
    }
    else if (state is AddUpdateDeleteProfileSuccessState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _refreshIndicatorKey.currentState?.show();
      });
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
            duration: const Duration(milliseconds: 300),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child:   ProfileTabParWidget(profile: profile,bodyHeight: _bodyHeight,),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildProfileHeader(BuildContext context){
    return Column(
      children: [
        ProfileUserInfoWidget(profile: profile,isEnableControl: true,),
        ProfileUserStatisticsWidget(profile: profile,),
      ],
    );
  }

  Widget _builderPageRefreshWidget(BuildContext context){
    return RefreshIndicator(
      key: _refreshIndicatorKey ,
      onRefresh: () async  {
        BlocProvider.of<ProfileBloc>(context).add(const RefreshProfileInfoEvent());
      },
      child: _buildBodyWidget(context),
    );
  }


}




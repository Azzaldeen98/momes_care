
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/state/error_page_widget.dart';
import 'package:moms_care/core/widget/state/loading_widget.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_bloc.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_event.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_state.dart';
import 'package:moms_care/features/profile/persention/widget/profile_user_info_widget.dart';
import 'package:moms_care/features/profile/persention/widget/profile_user_statistics_widget.dart';
import 'package:moms_care/injection_container.dart' as di;
class AuthorProfileView extends StatefulWidget{

  const AuthorProfileView({super.key,required this.authorId});
   final String authorId;

  @override
  State<AuthorProfileView> createState() => _AuthorProfileViewState();
}

class _AuthorProfileViewState  extends State<AuthorProfileView>{

  Profile? profile;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(create:(context) => di.sl<ProfileBloc>()
      ..add(GetAuthorInfoEvent(userId:widget.authorId)) ,
     child:  Scaffold(
       appBar: AppBarPageWidget(pageName: "Profile".tr,),
           body:BlocConsumer<ProfileBloc,ProfileState>(
        builder: _builderPageAuthorProfileBlocWidget,
        listener: _listenerPageAuthorProfileBloc,),
    ));
  }

  Widget _builderBodyWidget(BuildContext context) {

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(profile!=null)...[
            ProfileUserInfoWidget(profile: profile!,),
            ProfileUserStatisticsWidget(profile: profile!,),
          ]
          else
            const SizedBox(),
        ],
      ),
    );

  }


  Widget _builderPageAuthorProfileBlocWidget(BuildContext context, ProfileState state) {

    if (state is LoadingProfileUpdateState) {
      return const LoadingVehicleWidget();
    }
    if (state is ErrorProfileState) {
      return const ErrorPageWidget();
    }else  if(state is LoadedProfileState) {
      profile=state.profile;
      return _builderBodyWidget(context);
    }
    return const SizedBox();
  }

  void _listenerPageAuthorProfileBloc(BuildContext context, ProfileState state) {

    if (state is LoadingProfileUpdateState) {}
    if (state is ErrorProfileState) {
       SnackBarBuilder.ShowError(context: context,message:state.message);
    }else  if(state is LoadedProfileState) {}
    }


  void onPressed() async{

  }


}


// class LoadingScreen {
//   LoadingScreen._();
//
//   static show(BuildContext context, String text) {
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return Dialog(
//             elevation: 0,
//             backgroundColor: Colors.transparent,
//             child: _customDialog(context, text),
//           );
//         });
//   }
//
//   static hide(BuildContext context) {
//     Navigator.pop(context);
//   }
//
//   static _customDialog(BuildContext context, String text) {
//     return Container(
//       child: Center(
//         child: Container(
//           decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.5),
//               shape: BoxShape.rectangle,
//               borderRadius: BorderRadius.circular(10)),
//           child: Padding(
//             padding: EdgeInsets.all(30),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 CircularProgressIndicator(
//                   strokeWidth: 10,
//                   valueColor: AlwaysStoppedAnimation(Colors.black),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 20),
//                 ),
//                 Text(
//                   text,
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.w600),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
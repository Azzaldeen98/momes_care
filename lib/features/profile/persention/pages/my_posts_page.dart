import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/empty_widget.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import '../../../forum/domain/entities/Post.dart';
import '../../../forum/presentation/wedgits/posts/post_widget.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import 'package:moms_care/injection_container.dart' as di;


class MyPostsWidget extends StatelessWidget{


  late List<Post> listPost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPageWidget(pageName: "My Posts".tr,),
      bottomNavigationBar: Helper.buttonNavigation ,
      body: BlocConsumer<ProfilePostBloc,ProfilePostState>(
                    builder: _builderProfileWidgetBlocState,
                    listener: _listenerProfileBlocState),
    );
  }

  void _listenerProfileBlocState(BuildContext context, ProfilePostState state) {

    // if (state is LoadedProfileState) {
    //   print("LoadedCommentsState99");
    //   MessageBox.showProgress(context!,WAIT_MESSAGE);
    // }
    if (state is ErrorProfilePostState) {
      Get.back();
      SnackBarBuilder.ShowError( context:context!,message:state.message!);
    }
    else if (state is LoadedMyPostsState) {
      Get.back();
      SnackBarBuilder.ShowSuccess(context: context ,message:"Loaded my posts is successdully ");
    }

  }
  Widget _builderProfileWidgetBlocState(BuildContext context, ProfilePostState  state) {

    if (state is LoadingProfilePostState) {
      return const Center(child: CupertinoActivityIndicator());
    }
    if (state is ErrorProfilePostState) {
      Get.back();
      SnackBarBuilder.ShowError( context:context!,message:state.message!);
    }
    else if (state is LoadedMyPostsState) {
      if(listPost==null)
        listPost=state.posts;
      return  _buildProfileBodyWidget(context);
    }
    return  EmptyWidget();

  }
  Widget _buildProfileBodyWidget(BuildContext context){

    return (listPost==null || listPost!.isEmpty)
            ? EmptyWidget(explanatoryText: "EmptyPost".tr)
            : ListView.builder(itemBuilder: (context,index){
                     return PostWidget(post: listPost![index]);
                },
                itemCount: listPost!.length,
              );
  }

}



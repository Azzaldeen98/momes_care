import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/constants/enam/input_model_type.dart';
import 'package:moms_care/core/utils/dailog/toast/toast_box.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';
import 'package:moms_care/features/forum/presentation/bloc/post/post_event.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/color_app.dart';
import '../../../../../config/theme/text_style.dart';
import '../../../../../core/utils/dailog/message/message_box.dart';
import '../../../../../core/widget/bottom_sheets/bottom_sheet.dart';
import '../../../domain/entities/Comment.dart';
import '../../bloc/post/post_bloc.dart';
import '../../bloc/post/post_state.dart';
import '../../wedgits/comment_card_view_widget.dart';
import '../../wedgits/create_post_bottom_sheet_widget.dart';
import '../../wedgits/post_card_widget.dart';
import '/injection_container.dart' as di;

class PostsDetails extends StatefulWidget {
  final Post post;
  const PostsDetails({Key? key,required this.post})
      : super(key: key);

  @override
  State<PostsDetails> createState() => _PostsDetailsState();
}

class _PostsDetailsState extends State<PostsDetails> {

  Post? _postDetails;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<PostBloc>(), //..add()),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(actions: [],
          backgroundColor: AppColor.primaryAppBarColor,),
          floatingActionButton: AvatarGlow(
            endRadius: 80,
            // animate: isListening,
            glowColor: Colors.teal,
            child: FloatingActionButton(
              onPressed: () async{
                showCustomBottomSheet(context: context,child: CreateUpdatePostWidget(
                  inputModelType: InputModelType.ADD_COMMENT,
                  onClickSaved:(title,content) async{
                    // BlocProvider.of<PostBloc>(context).add(AddPostEvent(title: title,content:content));
                  },onCreatedOrUpdatedIsSuccess: (){
                  print("onCreatedOrUpdatedIsSuccess");
                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                  //   _refreshIndicatorKey.currentState?.show();
                  // });
                  // MessageBox.showSuccess(context, " succussfly ");
                  // Get.back();
                },baseContext: context,));
              },
              backgroundColor:  AppColor.primaryDarkColor,
              child: Icon(Icons.add ,color: AppColor.primaryIconColor, size: 35,),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
          // backgroundColor: const Color.fromRGBO(180, 178, 178, 1.0),
          body:_builderDetailsPostBlocState(),
        ),
      ),
    );

  }

  Widget _builderDetailsPostBlocState() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        // decoration: BoxDecoration(color: AppColor.opacitybgCololr),
        child: Column(
          children: [
            PostCardWidget(post:widget.post),
            Expanded(
              flex: 0,
              child: Container(
                color: AppColor.opacitybgCololr,
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return CommentCardViewWidget(comment: widget.post!.comments![index]) ;//
                  },
                  itemCount: widget.post!.comments!.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // return CustomScrollView(
   //    slivers: [
   //      SliverFillRemaining(
   //        hasScrollBody: true,
   //        child: Column(
   //          children: <Widget>[
   //            PostCardWidget(post:widget.post),
   //            Expanded(
   //              flex: 1,
   //              child: Container(
   //                color: Colors.grey,
   //                child: ListView.builder(
   //                  physics: NeverScrollableScrollPhysics(),
   //                  shrinkWrap: true,
   //                  itemBuilder: (context,index){
   //                    return  ListTile(title:CommentCardViewWidget(comment: widget.post!.comments![index]) ,);//
   //                  },
   //                  itemCount: widget.post!.comments!.length,
   //                ),
   //              ),
   //            ),
   //          ],
   //        ),
   //      ),
   //    ],
   //  );




  }

  void _listenerDetailsPostBlocState(BuildContext context, PostState state) {

    if(state is ErrorPostsState){
      Get.back();
      MessageBox.showError(context, state.message);
    }
    else  if(state is LoadedDetailsPostState){
      Get.back();
    }

  }
}
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
import 'package:moms_care/features/forum/presentation/bloc/posts/post_event.dart';
import 'package:moms_care/features/forum/presentation/wedgits/pages/add_update_comment_widget.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/color_app.dart';
import '../../../../../config/theme/text_style.dart';
import '../../../../../core/utils/dailog/message/message_box.dart';
import '../../../../../core/widget/bottom_sheets/bottom_sheet.dart';
import '../../../domain/entities/Comment.dart';
import '../../bloc/add_delete_update_comment/add_delete_update_comment_bloc.dart';
import '../../bloc/comments/comment_bloc.dart';
import '../../bloc/posts/post_bloc.dart';
import '../../bloc/posts/post_state.dart';
import '../../wedgits/comments/comment_widget.dart';
import '../../wedgits/pages/add_update_post_widget.dart';
import '../../wedgits/posts/post_widget.dart';
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

    // MultiBlocProvider(providers: [
    //   BlocProvider<PostBloc>(create: (_) => di.sl<PostBloc>()),
    //   BlocProvider<CommentBloc>(create: (_) => di.sl<CommentBloc>()),
    //   BlocProvider(create: (context) => di.sl<AddDeleteUpdateCommentBloc>()),
    // ],
    //   // create: (_) => di.sl<PostBloc>(), //..add()),
    //   child:
    return  SafeArea(
        child: Scaffold(
          appBar: AppBar(actions: [],
          backgroundColor: AppColor.primaryAppBarColor,),
          floatingActionButton: AvatarGlow(
            endRadius: 80,
            animate: true,
            glowColor: Colors.teal,
            child: FloatingActionButton(
              onPressed: () async{

                MessageBox.showDialog(context, textBody:"AddUpdateCommentPage" );
                // await Get.to(const AddUpdateCommentPage(isUpdate: false,));

                // showCustomBottomSheet(context: context,child: CreateUpdatePostWidget(
                //   inputModelType: InputModelType.ADD_COMMENT,
                //   onClickSaved:(title,content) async{
                //     // BlocProvider.of<PostBloc>(context).add(AddPostEvent(title: title,content:content));
                //   },onCreatedOrUpdatedIsSuccess: (){
                //   print("onCreatedOrUpdatedIsSuccess");
                //   // WidgetsBinding.instance.addPostFrameCallback((_) {
                //   //   _refreshIndicatorKey.currentState?.show();
                //   // });
                //   // MessageBox.showSuccess(context, " succussfly ");
                //   // Get.back();
                // },baseContext: context,));
              },
              backgroundColor:  AppColor.primaryDarkColor,
              child: Icon(Icons.add ,color: AppColor.primaryIconColor, size: 35,),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
          // backgroundColor: const Color.fromRGBO(180, 178, 178, 1.0),
          body:_builderDetailsPostBlocState(),
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
            PostWidget(post:widget.post),
            Expanded(
              flex: 0,
              child: Container(
                color: AppColor.opacitybgCololr,
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return CommentWidget(comment: widget.post!.comments![index]) ;//
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
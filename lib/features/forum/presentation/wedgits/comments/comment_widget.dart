


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/constants/cached/cached_name.dart';
import 'package:moms_care/core/helpers/cache_helper.dart';
import 'package:moms_care/features/forum/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:moms_care/features/forum/presentation/bloc/posts/post_event.dart';
import 'package:moms_care/features/forum/presentation/wedgits/body_widget.dart';
import 'package:moms_care/features/forum/presentation/wedgits/footer_widget.dart';
import 'package:moms_care/features/forum/presentation/wedgits/header_widget.dart';
import 'package:moms_care/features/forum/presentation/wedgits/pages/add_update_comment_widget.dart';
import 'package:moms_care/features/forum/presentation/wedgits/pages/delete_page.dart';

import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/widget/bottom_sheets/DemoCWActionSheetScreen.dart';
import '../../../domain/entities/Comment.dart';
import '../../bloc/add_delete_update_comment/add_delete_update_comment_bloc.dart';
import '../../bloc/add_delete_update_comment/add_delete_update_comment_event.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_event.dart';
import '../../bloc/posts/post_bloc.dart';
import '../date_time_widget.dart';
class CommentWidget extends StatefulWidget {

  const CommentWidget({super.key,
    this.onDelete,
    required this.baseContext,
    required this.comment});

  final Comment comment;
  final BuildContext baseContext;
  final VoidCallback? onDelete;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}
class _CommentWidgetState  extends  State<CommentWidget> {

  late Comment comment;
  late String contant;
  late BuildContext baseContext;
  late VoidCallback? onDelete;


  @override
  void initState() {

      comment=widget.comment;
      baseContext=widget.baseContext;
      onDelete=widget.onDelete;
      if(comment !=null) {
        contant=comment?.contant??"";
      }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(5),
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: const Color.fromARGB(227, 225, 224, 224), width: 0.7),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              HeaderWidget(
                  author:comment!.author! ,
                  onClickMoreOptions:()=>onMoreOptions(context)),
              const Divider(height: 0,thickness: 0.5,),
              BodyWidget(content: contant??""),
              const Divider(height: 10,thickness: 0.5,),
              DateTimeWidget(dateTime: comment!.createdAt,),
              const Divider(height: 0,thickness: 0.5,),
              FooterWidget(
                  onLiked:()=>onPressLike(context),
                  onComments:()=>onPressComments(context),
                  onReply:()=>onPressReply(context),
                  likes: comment!.likes??0,
                  isPost: false,
                  userLiked: comment!.userLiked??false,
                  comments: 0,
                ),
            ],
          ),
    );
  }

  void onMoreOptions(BuildContext context)async{
    showCupertinoModalPopup(context: context, builder: (BuildContext demo_context) =>
        DemoCWActionEditDeleteSheetScreen(
          onEdited:(_)async=>onPressEdit(context),
          onDeleted:(_)async=>onPressDelete(context),
        ));
  }
  void onPressDelete(BuildContext context)async{
    Get.back();
    Get.to(DeletePage(
      onAccepted: (_context){
        Get.back();
        BlocProvider.of<AddDeleteUpdatePostBloc>(_context).add(DeleteCommentEvent(commentId:comment.id!));
    },
      onDeleted: (_context){
      // MessageBox.showSuccess(_context,  "onDeleted");
      // Navigator.of(_context!).pop();

      // Navigator.of(context!).pop();
    },));
  }
  void onPressEdit(BuildContext context)async{
   await Get.to(AddUpdateCommentPage(comment:comment, isUpdate: true,
     onComplated:(_context,content){
     if(content!=null) {
       setState(()=>this.contant=content);
     }
     },));
  }
  void onPressLike(BuildContext context) async{
    CacheHelper.removeAt(PROFILE_INFO_CACHED);
    BlocProvider.of<PostBloc>(context).add((LikeUnLikeCommentEvent(commentId:comment.id!)));
  }
  void onPressComments(BuildContext context){

  }
  void onPressReply(BuildContext context){

  }
}
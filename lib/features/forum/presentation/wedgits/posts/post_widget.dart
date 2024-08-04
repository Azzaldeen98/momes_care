


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/cached/cached_name.dart';
import 'package:moms_care/core/data/entities/author.dart';
import 'package:moms_care/core/helpers/cache_helper.dart';
import 'package:moms_care/core/utils/dailog/message/dssd.dart';
import 'package:moms_care/features/forum/presentation/bloc/posts/post_bloc.dart';
import 'package:moms_care/features/forum/presentation/bloc/posts/post_event.dart';
import 'package:moms_care/features/forum/presentation/wedgits/body_widget.dart';
import 'package:moms_care/features/forum/presentation/wedgits/footer_widget.dart';
import 'package:moms_care/features/forum/presentation/wedgits/header_widget.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/widget/bottom_sheets/DemoCWActionSheetScreen.dart';
import '../../../domain/entities/Post.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_event.dart';
import '../pages/add_update_post_widget.dart';
import '../date_time_widget.dart';


class PostWidget  extends StatelessWidget {
  const PostWidget({super.key, this.onDelete, required this.post});
  final Post? post;
  final VoidCallback? onDelete;
  @override

  Widget build(BuildContext context) {
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    if(post==null)
      return SizedBox();

    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: const Color.fromARGB(227, 225, 224, 224), width: 0.7),
                borderRadius: BorderRadius.circular(10)),
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        HeaderWidget(
                          author:post!.author!,
                            onClickMoreOptions:()=>onMoreOptions(context)),
                        const Divider(height: 20,thickness: 0.5),
                        BodyWidget(title:post?.title ??"" ,content: post?.body??""),
                        const SizedBox(height: 10,),
                        const Divider(height: 10,thickness: 0.3,),
                        DateTimeWidget(dateTime: post!.publishedAt?? DateTime.now(),),
                        const Divider(height: 10,),
                        FooterWidget(
                            onLiked:()=>onPressLiked(context),
                            onComments:()=>onPressComments(context),
                            onReply:()=>onPressReply(context),
                            likes: post?.likes??0,
                            comments: post?.commentsCount??0,
                            isPost: true,
                            userLiked: post!.userLiked??false,
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),

          ),
        ],
      ),
    );
  }

  void onMoreOptions(BuildContext context) async{
    showCupertinoModalPopup(context: context, builder: (BuildContext base_context) =>
        DemoCWActionEditDeleteSheetScreen(
          onEdited:(_)=>onPressEdit(context),
          onDeleted:(_)=>onPressDelete(context),
        ));
  }
  void onPressLiked(BuildContext context) async{
    if(post!=null) {
      CacheHelper.removeAt(PROFILE_INFO_CACHED);
      BlocProvider.of<PostBloc>(context).add((LikeUnLikePostEvent(postId:post!.id??0)));
    }
  }
  void onPressComments(BuildContext context) async{
    if(post!=null) {
      CacheHelper.removeAt(PROFILE_INFO_CACHED);
      BlocProvider.of<PostBloc>(context).add(DetailsPostEvent(post: post!));
    }
  }
  void onPressReply(BuildContext context) async{}
  void onPressEdit(BuildContext context)async {
    if(post!=null) {
      Get.to(AddUpdatePostPage(post: post ?? Post(), isUpdatePost: true,));
    }
  }
  void onPressDelete(BuildContext context) {
    ShowAwesomeDialogBox(context:context ,message: DELETE_CONSENT_MESSAGE,onAccept:() async{
      Get.back();
      if(post!=null) {
        // CacheHelper.removeAt(PROFILE_INFO_CACHED);
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(DeletePostEvent(postId:post!.id??0));
      }
    } );

  }










// Widget _buildHeaderCard(Author? author,DateTime? dateTime){
  //
  //   final dateTimeVM = DateTimeViewModel(dateTime: dateTime!);
  //   return  Container(
  //     padding: EdgeInsets.all(5),
  //     margin: const EdgeInsets.only(left: 2,right: 2, top: 5),
  //     decoration: BoxDecoration(
  //         // color: CupertinoColors.opaqueSeparator,
  //         border: Border.all(
  //             color: const Color.fromARGB(227, 225, 224, 224), width: 0.7),
  //         borderRadius: BorderRadius.circular(5)),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Expanded(child: CardAuthorWidget(author: author!,)),
  //         const SizedBox(width: 10),
  //         SizedBox(
  //           width: 90,
  //           child: Expanded(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //
  //                     Text(textAlign: TextAlign.center,overflow: TextOverflow.fade,
  //                       "${dateTimeVM?.date} " ?? "---",
  //                       style: AppTextStyles.getMediumStyle(fontSize:
  //                       FontSizeManager.s12,color: AppColors.grayTwoColor),
  //                     ),
  //                     SizedBox(width: 5,),
  //                     Icon(Icons.date_range,size: 20,color: AppColors.grayThreeColor),
  //                     SizedBox(width: 5,),
  //                   ],
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //
  //                     Text(textAlign: TextAlign.start,
  //                       "${dateTimeVM?.time}" ?? "---",
  //                       style: AppTextStyles.getMediumStyle( fontSize:
  //                       FontSizeManager.s12,color: AppColors.grayTwoColor),
  //                     ),
  //                     SizedBox(width: 5,),
  //                     Icon(Icons.access_time_sharp,size: 20,color: AppColors.grayThreeColor,),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //
  //       ],
  //
  //     ),
  //   );
  // }
  //
  // Widget _buildBodyCard({String? title,String? content}){
  //   return  dWidget(title:title,content: content,) ;
  // }
  //
  // Widget _buildFooterCard({
  //    Function()? onLiked,
  //    Function()? onComments,
  //    Function()? onReply,
  //   int? likes=0,
  //   int? coments=0,
  //   bool isPost=true}){
  //
  //   return  Container(
  //     child:Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         TextButton.icon( label:Text(likes.toString()),onPressed: onLiked, icon:   Icon(Icons.favorite_outline_sharp) ?? Icon(Icons.favorite_sharp),),
  //         (!isPost)? SizedBox(): TextButton.icon( label:Text(coments.toString()),onPressed: onLiked, icon:   Icon(Icons.comment_sharp) ?? Icon(Icons.favorite_sharp),),
  //         IconButton(onPressed: onReply, icon:   Icon(Icons.reply)),
  //       ],
  //     ),);
  // }


}
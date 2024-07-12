

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/font_manager.dart';
import 'package:moms_care/core/data/entities/author.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/features/forum/domain/usecases/post/like_unlike_post_use_case.dart';
import 'package:moms_care/features/forum/presentation/bloc/posts/post_bloc.dart';
import 'package:moms_care/features/forum/presentation/bloc/posts/post_event.dart';
import 'package:moms_care/features/forum/presentation/wedgits/body_widget.dart';
import 'package:moms_care/features/forum/presentation/wedgits/footer_widget.dart';
import 'package:moms_care/features/forum/presentation/wedgits/header_widget.dart';
import 'package:moms_care/helpers/public_infromation.dart';
// import 'package:nb_utils/nb_utils.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/color_app.dart';
import '../../../../../config/theme/text_style.dart';
import '../../../../../core/constants/enam/DemoCWActionSheetType.dart';
import '../../../../../core/constants/enam/input_model_type.dart';
import '../../../../../core/data/view_models/date_time_view_model.dart';
import '../../../../../core/utils/dailog/message/messagebox_dialog_widget.dart';
import '../../../../../core/widget/bottom_sheets/DemoCWActionSheetScreen.dart';
import '../../../../../core/widget/bottom_sheets/bottom_sheet.dart';
import '../../../../../core/widget/card/card_author_widget.dart';
import '../../../../../core/widget/image/image_widget.dart';
import '../../../../../core/widget/label/text_newprice_widget.dart';
import '../../../../../core/widget/label/text_widget.dart';
import '../../../domain/entities/Comment.dart';
import '../../../domain/entities/Post.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_event.dart';
import '../pages/add_update_post_widget.dart';
import '../date_time_widget.dart';


class PostWidget  extends StatelessWidget {
  const PostWidget({super.key, this.onDelete, required this.post});
  final Post post;
  final VoidCallback? onDelete;
  @override
  Widget build(BuildContext context) {

    final dateTimeVM = DateTimeViewModel(dateTime: post.publishedAt!);

    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
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
                          author:post!.author ,
                            onClickMoreOptions:(){
                              showCupertinoModalPopup(context: context, builder: (BuildContext context) =>
                                  DemoCWActionEditDeleteSheetScreen(
                                    onEdited:(_context) async{
                                      // toasty(context, "onEdited7777");
                                      // showCustomBottomSheet(context: context,child:
                                       Get.to(AddUpdatePostPage(post: post, isUpdatePost: true,));

                                      //   onClickSaved:(title,content) async{
                                      //
                                      //     final _newPost=post.copyWith(title: title,body: content);
                                      //     // if(title!=post.title || content!=post.body)
                                      //     BlocProvider.of<PostBloc>(context).add(UpdatePostEvent(post:_newPost));
                                      //
                                      //   },onCreatedOrUpdatedIsSuccess: (){
                                      //   print("onCreatedOrUpdatedIsSuccess");
                                      //   WidgetsBinding.instance.addPostFrameCallback((_) {
                                      //     _refreshIndicatorKey.currentState?.show();
                                      //   });
                                      //   // Get.back();
                                      // },baseContext: context,));
                                      // // BlocProvider.of<PostBloc>(context).add(UpdatePostEvent(post: post));
                                      //  //
                                    } ,
                                    onDeleted: (_context) async{
                                      // toasty(context, "onDeleted7777");
                                       BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(DeletePostEvent(postId:post.id!));
                                       // MessageBox.showSuccess(context,  "onDeleted");

                                          // toast("Accept Delete");
                                          // _showDeleteDialog(_context);
                                          //  MessageBoxDialogWidget(message: "Do you really want to delete the current diagnostic process".tr,onAccenpt: () {
                                      //
                                      // },);
                                      // checkDeletedBox(context: context,onChangeOk: (){
                                      //
                                      // });

                                      // MessageBox.showDialog(context, textBody: "onDeleted");
                                    },
                                  ));

                              // MessageBox.showDialog(context, textBody: "onClickMoreOptions");
                            }),
                        Divider(height: 20,thickness: 0.5),
                        BodyWidget(title:post?.title ,content: post?.body),
                        SizedBox(height: 10,),
                        Divider(height: 10,thickness: 0.3,),
                        DateTimeWidget(dateTime: post!.publishedAt,),
                        Divider(height: 10,),
                        FooterWidget(
                            onLiked:(){
                              BlocProvider.of<PostBloc>(context).add((LikeUnLikePostEvent(postId:post.id!)));
                            },
                            onComments:(){
                                 BlocProvider.of<PostBloc>(context).add(DetailsPostEvent(post: post));
                              },
                            onReply:onPressedReply,
                            likes: post?.likes,
                            comments: post?.commentsCount,
                            isPost: true,
                            userLiked: post!.userLiked!,
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),

          ),
        ],
      ),
    );
  }


  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تنبيه'),
          content: Text("هل تريد حقًا حذف العملية التشخيصية الحالية؟".tr),
          actions: [
            TextButton(
              child: Text('إلغاء'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('موافق'.tr),
              onPressed: () {
                // تنفيذ عملية الحذف هنا
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void checkDeletedBox({required BuildContext context,required Function() onChangeOk}) {
    MessageBoxDialogWidget(message: "Do you really want to delete the current diagnostic process".tr,onAccenpt: () {
      onChangeOk();
    },);
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

  void onPressedLike(BuildContext context){

  }

  void onPressedReply(){

  }
}


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/config/theme/font_manager.dart';
import 'package:moms_care/core/data/entities/author.dart';
import 'package:moms_care/features/forum/presentation/wedgits/text_view_card_body_widget.dart';
import 'package:moms_care/features/forum/presentation/wedgits/text_view_card_footer_widget.dart';
import 'package:moms_care/features/forum/presentation/wedgits/text_view_card_header_widget.dart';
import 'package:moms_care/helpers/public_infromation.dart';

import '../../../../config/theme/color_app.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/data/view_models/date_time_view_model.dart';
import '../../../../core/widget/card/card_author_widget.dart';
import '../../../../core/widget/image/image_widget.dart';
import '../../../../core/widget/label/text_newprice_widget.dart';
import '../../../../core/widget/label/text_widget.dart';
import '../../domain/entities/Comment.dart';
import '../../domain/entities/Post.dart';



class CommentCardViewWidget  extends StatelessWidget {
  const CommentCardViewWidget({super.key, this.onDelete, required this.comment});
  final Comment comment;
  final VoidCallback? onDelete;
  @override
  Widget build(BuildContext context) {
      print("CommentCardViewWidget:${comment.contant}");
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: const Color.fromARGB(227, 225, 224, 224), width: 0.7),
                borderRadius: BorderRadius.circular(10)),
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(height: 0),
                        TextViewCarHeaderWidget(author:comment!.author ,createdAt:comment!.createdAt ,),
                        const SizedBox(height: 0),
                        TextViewCarBodyWidget(title:"" ,content: comment?.contant),
                        const SizedBox(height: 10),
                        // TextViewCarFooterWidget(
                        //     onLiked:onPressedLike,
                        //     onComments: onPressedComments,
                        //     onReply:onPressedReply,
                        //   likes: comment?.likes,
                        //   isPost: false,
                        // ),
                        const SizedBox(width: 0),
                      ],
                    ),

          ),
        ],
      ),
    );
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
  //   return  TextViewCardWidget(title:title,content: content,) ;
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

  void onPressedLike(){

  }
  void onPressedComments(){

  }
  void onPressedReply(){

  }
}


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moms_care/config/theme/font_manager.dart';
import 'package:moms_care/core/data/entities/author.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/features/forum/presentation/bloc/post/post_bloc.dart';
import 'package:moms_care/features/forum/presentation/bloc/post/post_event.dart';
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


// class TextViewCardWidget  extends StatelessWidget {
//   const TextViewCardWidget({super.key, this.title, required this.content});
//   final String? title;
//   final String? content;
//   @override
//   Widget build(BuildContext context) {
//     return    Container(
//       padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
//       margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(
//               color: const Color.fromARGB(227, 225, 224, 224), width: 0.7),
//           borderRadius: BorderRadius.circular(5)),
//       child: Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               // Container(
//               //   padding: EdgeInsets.all(5),
//               //   alignment: Alignment.centerRight,
//               //   width: double.maxFinite,
//               //   decoration: BoxDecoration(border: Border(bottom:BorderSide(width: 0.1))),
//                Text(title ?? "----",style: AppTextStyles.getTitleStyle(
//                    color: AppColors.grayOneColor,fontSize: FontSizeManager.s16),),
//               const SizedBox(height: 5),
//
//               const SizedBox(height: 5),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       content ?? "---",
//                       style: AppTextStyles.getMediumStyle(
//                           fontSize: 14, color: AppColors.grayTwoColor),
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                 ],
//               ),
//               const SizedBox(width: 20),
//             ],
//           )),
//
//     );
//   }
// }
class PostCardWidget  extends StatelessWidget {
  const PostCardWidget({super.key, this.onDelete, required this.post});
  final Post post;
  final VoidCallback? onDelete;
  @override
  Widget build(BuildContext context) {

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
                        const SizedBox(height: 0),
                        TextViewCarHeaderWidget(author:post!.author ,createdAt:post!.publishedAt ,),
                        const SizedBox(height: 0),
                        TextViewCarBodyWidget(title:post?.title ,content: post?.body),
                        const SizedBox(height: 10),
                        TextViewCarFooterWidget(
                            onLiked:onPressedLike,
                            onComments:(){
                              // MessageBox.show(context, "onComments");
                              BlocProvider.of<PostBloc>(context).add(DetailsPostEvent(post: post));
                              },
                            onReply:onPressedReply,
                            likes: post?.likes,
                            comments: post?.commentsCount,
                            isPost: true,
                        ),
                        const SizedBox(width: 20),
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
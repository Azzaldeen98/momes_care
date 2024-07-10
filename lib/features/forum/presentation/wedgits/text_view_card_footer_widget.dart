

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/config/theme/font_manager.dart';
import 'package:moms_care/core/data/entities/author.dart';
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


class TextViewCarFooterWidget  extends StatelessWidget {

  const TextViewCarFooterWidget({super.key,
    this.likes,
    this.comments,
    this.onLiked,
    this.onComments,
    this.onReply,
    this.isPost=true, });

  final Function()? onLiked;
  final Function()? onComments;
  final Function()? onReply;
  final  int? likes;
  final  int? comments;
  final  bool isPost;

  @override
  Widget build(BuildContext context) {
    return  Container(
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton.icon( label:Text(likes.toString()),onPressed: onLiked, icon:   Icon(Icons.favorite_outline_sharp) ?? Icon(Icons.favorite_sharp),),
          (!isPost)? SizedBox(): TextButton.icon( label:Text(comments.toString()),onPressed: onComments, icon:   Icon(Icons.comment_sharp) ?? Icon(Icons.favorite_sharp),),
          IconButton(onPressed: onReply, icon:   Icon(Icons.reply)),
        ],
      ),);
  }

}

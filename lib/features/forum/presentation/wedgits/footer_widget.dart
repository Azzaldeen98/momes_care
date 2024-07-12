

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/config/theme/font_manager.dart';
import 'package:moms_care/core/data/entities/author.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
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


class FooterWidget  extends StatefulWidget {

  const FooterWidget({super.key,
    this.likes=0,
    this.comments=0,
   required this.onLiked,
    required this.onComments,
    required  this.onReply,
    this.userLiked=false,
    this.isPost=true, });

  final Function()? onLiked;
  final Function()? onComments;
  final Function()? onReply;
  final  int? likes;
  final  int? comments;
  final  bool? isPost;
  final  bool? userLiked;
  @override
  State<FooterWidget> createState() => _FooterWidgetState();

}


class _FooterWidgetState  extends  State<FooterWidget> {

 late int likesCount=0;
 late bool _userLiked=false;
 @override
 void initState() {
   likesCount=widget!.likes??0;
   _userLiked=widget.userLiked??false;
   super.initState();
 }






  @override
  Widget build(BuildContext context) {


    return  Container(
      padding: EdgeInsets.all(5),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          TextButton.icon( label:Text(likesCount.toString()),onPressed: (){
            widget.onLiked!();
            setState(() {
              likesCount+= _userLiked ? -1:1;
              _userLiked=!_userLiked;
            });
          }, icon: Icon( _userLiked? Icons.favorite_sharp:Icons.favorite_outline_sharp,
              color: AppColor.primaryLightIconColor),),
          (!widget.isPost!)? SizedBox(): TextButton.icon( label:Text(widget.comments.toString()),onPressed: widget.onComments,
            icon:   Icon(Icons.comment_sharp,color: AppColor.primaryLightIconColor,) ?? Icon(Icons.favorite_sharp),),
          IconButton(onPressed: widget.onReply, icon:   Icon(Icons.reply)),
        ],
      ),);
  }

}






import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';




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



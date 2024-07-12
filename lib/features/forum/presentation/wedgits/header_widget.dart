

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/config/theme/font_manager.dart';
import 'package:moms_care/core/constants/cached/cached_name.dart';
import 'package:moms_care/core/data/entities/author.dart';
import 'package:moms_care/helpers/cache_helper.dart';
import 'package:moms_care/helpers/public_infromation.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../config/theme/color_app.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/data/view_models/date_time_view_model.dart';
import '../../../../core/widget/card/card_author_widget.dart';
import '../../../../core/widget/image/image_widget.dart';
import '../../../../core/widget/label/text_newprice_widget.dart';
import '../../../../core/widget/label/text_widget.dart';
import '../../domain/entities/Comment.dart';
import '../../domain/entities/Post.dart';


class HeaderWidget  extends StatelessWidget {

  const HeaderWidget({super.key,
    this.author,
    this.onClickMoreOptions});

  final Author? author;
  // final DateTime? createdAt;
  final Function()? onClickMoreOptions;

  @override
  Widget build(BuildContext context) {

    // print("authorUU: ${author!.id}");
    // print("authorYY: ${Helper.Auth_UId}");
    // final dateTimeVM = DateTimeViewModel(dateTime: createdAt!);
    return  Container(
      // color: Colors.white,
      // height: 60,
      padding: EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 2,right: 2, top: 5),
      decoration: BoxDecoration(
        color:Colors.white,// CupertinoColors.opaqueSeparator,
          // border: Border(bottom: BorderSide(
          //     color: const Color.fromARGB(227, 225, 224, 224), width: 0.7)
          // ),
          borderRadius: BorderRadius.circular(0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Expanded(child: CardAuthorWidget(author: author!,)),
          const SizedBox(width: 10),
          (FirebaseAuth.instance.currentUser!.uid== author!.id)?
              IconButton(onPressed: onClickMoreOptions, icon: Icon(Icons.more_vert_sharp))
              :SizedBox(),

        ],

      ),
    );
  }

  Widget  _buildControllButtons({BuildContext? context}){ //,Function()? onDeleted,Function()? onEdit}){
    return Row(
      children: [

        // IconButton(onPressed: onEdit, icon: Icon(Icons.edit)),
      ],
    );
  }
}

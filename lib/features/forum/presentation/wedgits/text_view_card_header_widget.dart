

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


class TextViewCarHeaderWidget  extends StatelessWidget {

  const TextViewCarHeaderWidget({super.key,this.author, this.createdAt});
  final Author? author;
  final DateTime? createdAt;

  @override
  Widget build(BuildContext context) {
    final dateTimeVM = DateTimeViewModel(dateTime: createdAt!);
    return  Container(
      padding: EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 2,right: 2, top: 5),
      decoration: BoxDecoration(
        // color: CupertinoColors.opaqueSeparator,
          border: Border.all(
              color: const Color.fromARGB(227, 225, 224, 224), width: 0.7),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: CardAuthorWidget(author: author!,)),
          const SizedBox(width: 10),
          SizedBox(
            width: 100,
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Text(textAlign: TextAlign.center,overflow: TextOverflow.fade,
                        "${dateTimeVM?.date} " ?? "---",
                        style: AppTextStyles.getMediumStyle(fontSize:
                        FontSizeManager.s12,color: AppColors.grayTwoColor),
                      ),
                      SizedBox(width: 5,),
                      Icon(Icons.date_range,size: 20,color: AppColors.grayThreeColor),
                      SizedBox(width: 5,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Text(textAlign: TextAlign.start,
                        "${dateTimeVM?.time}" ?? "---",
                        style: AppTextStyles.getMediumStyle( fontSize:
                        FontSizeManager.s12,color: AppColors.grayTwoColor),
                      ),
                      SizedBox(width: 5,),
                      Icon(Icons.access_time_sharp,size: 20,color: AppColors.grayThreeColor,),
                    ],
                  ),
                ],
              ),
            ),
          ),

        ],

      ),
    );
  }
}



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


class TextViewCarBodyWidget  extends StatelessWidget {
  const TextViewCarBodyWidget({super.key, this.title, required this.content});
  final String? title;
  final String? content;
  @override
  Widget build(BuildContext context) {
    return    Container(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: const Color.fromARGB(227, 225, 224, 224), width: 0.7),
          borderRadius: BorderRadius.circular(5)),
      child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container(
              //   padding: EdgeInsets.all(5),
              //   alignment: Alignment.centerRight,
              //   width: double.maxFinite,
              //   decoration: BoxDecoration(border: Border(bottom:BorderSide(width: 0.1))),
               Text(title ?? "----",style: AppTextStyles.getTitleStyle(
                   color: AppColors.grayOneColor,fontSize: FontSizeManager.s16),),
              const SizedBox(height: 5),

              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      content ?? "---",
                      style: AppTextStyles.getMediumStyle(
                          fontSize: 14, color: AppColors.grayTwoColor),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(width: 20),
            ],
          )),

    );
  }
}




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/config/theme/color_app.dart';
import 'package:moms_care/config/theme/font_manager.dart';
import 'package:moms_care/config/theme/text_style.dart';


class BodyWidget extends StatefulWidget {

  const BodyWidget({super.key, this.title="", required this.content});

  final String? title;
  final String content;

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}
class _BodyWidgetState  extends State<BodyWidget> {

  late String? title;
  late String content;

  @override
  void initState() {

      if(widget.title!=null) {
        title=widget.title;
      }
      content=widget.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
      decoration: BoxDecoration(
          // color: Colors.green,
          // border: Border.all(
          //     color: const Color.fromARGB(227, 225, 224, 224), width: 0),
          borderRadius: BorderRadius.circular(0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          ListTile(
            title: Text(
              title ?? "",
              softWrap: true,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.justify,
              style: AppTextStyles.getTitleStyle(
                color: AppColors.grayOneColor,fontSize: FontSizeManager.s16),),
            subtitle:Text(
              content ?? "---",
              softWrap: true,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.justify,
              style: AppTextStyles.getMediumStyle(
                  fontSize: 14, color: AppColors.grayTwoColor),),
          ),
        ],
      ),

    );
  }
}

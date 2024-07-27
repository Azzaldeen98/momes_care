

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/theme/app_color.dart';
import 'package:moms_care/core/constants/constants.dart';

class  FormHeaderWidget extends StatelessWidget{
  final String? title;
  final IconData? iconData;

const FormHeaderWidget({this.title,this.iconData});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
      decoration: BoxDecoration(
        // border: Border(bottom: BorderSide(color: AppColor.underLineColor))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title!,
            softWrap: true,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:
            FontWeight.bold),),
          SizedBox(width: 20,),
          Icon(iconData!)
        ],
      ),
    );
  }

}
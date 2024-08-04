

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/constants/constants.dart';

class  FormHeaderWidget extends StatelessWidget{
  final String? title;
  final IconData? iconData;

const FormHeaderWidget({super.key, this.title,this.iconData});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title!,
            softWrap: true,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:
            FontWeight.bold),),
          const SizedBox(width: 20,),
          Icon(iconData!)
        ],
      ),
    );
  }

}
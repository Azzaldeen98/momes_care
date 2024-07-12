

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


import '../../../../helpers/cache_helper.dart';
import '../../../config/theme/font_manager.dart';


class TextEntryField extends StatefulWidget {

  final String? labelText;
  final String? hintText;
  final IconData? icon;
  final int? maxLines;
  final int? maxLength;
  final TextEditingController controller;
  final String? error_text;

  TextEntryField({super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
     this.icon,
     this.maxLines=1,
     this.maxLength=1000,
     this.error_text=null,});

  @override
  _TextEntryFieldState createState() => _TextEntryFieldState();
}

class _TextEntryFieldState extends State<TextEntryField> {
  bool isFocus = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            // height: widget.height,
            // padding: EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
             controller: widget.controller!,
              style: TextStyle(fontSize: FontSizeManager.s14,),
              maxLines: widget.maxLines ?? 1,
              maxLength: widget.maxLength,
              decoration: InputDecoration(
                  // icon: Icon(widget.icon!) ,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  errorText: widget.error_text ??null,
                  labelText: widget.labelText??"",
                  hintText: widget.hintText??""),
                  strutStyle: StrutStyle(fontSize: FontSizeManager.s14,),
            ),
          );
  }


}
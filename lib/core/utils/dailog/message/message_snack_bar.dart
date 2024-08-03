
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:retrofit/http.dart';

import 'package:moms_care/core/utils/theme/text_style.dart';

class SnackBarBuilder{

  static _buildSnackBar({BuildContext? context,
    String? message,
    Color? bgColor,
    TextStyle? textStyle}){
    ScaffoldMessenger.of(context!).showSnackBar(  SnackBar(content: Text(message!,
      style:textStyle??AppTextStyles.getBasicStyle(color: Colors.white),),
      backgroundColor:bgColor! ));
  }
  static ShowSuccess({BuildContext? context,
    String? message}){
    _buildSnackBar(context:context ,message:message ,bgColor:Colors.green);
  }

  static ShowError({BuildContext? context,
    String? message}){
    _buildSnackBar(context:context ,message:message ,bgColor:Colors.red);
  }

}


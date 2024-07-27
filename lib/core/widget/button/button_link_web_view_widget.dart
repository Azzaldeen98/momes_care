


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/core/widget/web_view_screen.dart';

class ButtonLinkWebViewWidget extends StatefulWidget {

  const ButtonLinkWebViewWidget({super.key,
    required this.label,
     this.textStyle,
     this.icon,
     this.bgColor,
    required this.link});

  final String link;
  final Icon? icon;
  final String label;
  final TextStyle? textStyle;
  final Color? bgColor;

  @override
  State<ButtonLinkWebViewWidget> createState() => _ButtonLinkWebViewWidgetState();
}

class _ButtonLinkWebViewWidgetState extends State<ButtonLinkWebViewWidget> {


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(

      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration:  BoxDecoration(
        color: widget.bgColor ?? Colors.indigo,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton.icon(icon:widget.icon ?? const Icon(Icons.link_outlined,color: AppColor.primaryIconColor,),
        label: Text(widget.label,
          style: widget.textStyle ?? AppTextStyles.getLabelStyle(color: AppColor.PrimaryTextLightColor),),
        onPressed:()async{
        Get.to(WebViewScreen(Url: widget.link,));
      },),
    );
  }
  
}

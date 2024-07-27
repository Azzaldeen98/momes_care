

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/widget/image/image_widget.dart';


class AvatarGlowBroadcastLivePageWidget extends StatelessWidget implements PreferredSizeWidget{
  final String? iconUrl;
  final int? counts;
  final bool? animate;
  final VoidCallback? onPressed;
 const AvatarGlowBroadcastLivePageWidget({super.key,this.iconUrl,this.counts,this.onPressed,this.animate=false});


  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      endRadius: 80,
       animate: animate ?? false,
      glowColor: Colors.teal,
      child: Container(
        width: 56,
        height: 70,
        child: Stack(
          children: [
             Positioned(
              top: -2,
              left:0,
              child: FloatingActionButton(
                backgroundColor:Colors.white,
                  onPressed:onPressed??(){},
                  child: Image.asset(AppImage.LIVE,width: 30,height: 30),
              ),
            ),
             if(counts!=null && counts!>0)
                Positioned(
                  bottom: -5,
                  left: 10,
                  child: Card(
                    shape:const CircleBorder(),
                    color: Colors.red,
                    child:Padding(
                      padding:const EdgeInsets.only(top: 4.0,right: 4.0,left: 4.0),
                      child:Text("${counts!}",style: AppTextStyles.getLabelStyle(color: Colors.white,fontSize: 16),
                        textAlign: TextAlign.center,),
                    ),),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}
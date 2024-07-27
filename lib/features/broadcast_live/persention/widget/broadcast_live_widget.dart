  import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/core/constants/enam/broadcast_live_status.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/data/entities/author.dart';
import 'package:moms_care/core/data/view_models/date_time_view_model.dart';
import 'package:moms_care/core/helpers/helpers.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/core/utils/dailog/message/dssd.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/widget/button/button_link_web_view_widget.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import 'package:moms_care/core/widget/card/card_author_widget.dart';
import 'package:moms_care/core/widget/image/image_widget.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_bloc.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_event.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/broadcast_live.dart';
import 'package:retrofit/http.dart';

import '../../../../config/theme/color_app.dart';



class BroadcastLiveWidget extends StatelessWidget {
  final BroadcastLive ? broadcastLive;
  final void Function(BroadcastLive) ? onPressed;
  final  Function(BroadcastLive)? onEdit;
  const BroadcastLiveWidget({
    super.key,
    this.broadcastLive,
    this.onPressed,
    this.onEdit
  });

  @override
  Widget build(BuildContext context) {

    var raduis=BorderRadius.circular(20);

    // var heightCard=Helpers.getHeightPercent(context,20);
    // var widthCard=MediaQuery.of(context).size.width;
     DateTimeViewModel dateTimeViewModel=DateTimeViewModel(dateTime: broadcastLive?.startDateTime ?? DateTime.now());
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(
        padding:const EdgeInsets.all(10),

          child:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardAuthorWidget(author: Author(
                      id:broadcastLive?.user?.id,
                      name: broadcastLive?.user?.displayName,
                      image: broadcastLive?.user?.urlImage ),),
                  Container(
                    margin:const EdgeInsets.only(top: 10),
                    padding:const EdgeInsetsDirectional.all(10),
                    decoration: BoxDecoration(
                      borderRadius:const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                      ),
                      border: Border.all(width: 0.5,color: AppColor.opacitybgCololr),
                    ),
                    child: Column(
                      children: [
                        // const Divider(),
                        const SizedBox(height: 10,),
                        Text(broadcastLive!.descript!,style:AppTextStyles.getBasicStyle(),
                        maxLines: 5,
                        overflow: TextOverflow.visible,
                        softWrap: true,),
                        const Divider(),
                        const SizedBox(height: 10,),
                        Container(
                          // padding:const EdgeInsetsDirectional.all(10),
                          width:  MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: raduis,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(Icons.date_range,color: AppColor.primaryLightIconColor),
                                  const SizedBox(width: 10,),
                                  Text("${dateTimeViewModel.date}", style: AppTextStyles.getBasicStyle(),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(Icons.access_time_sharp,color: AppColor.primaryLightIconColor),
                                  const SizedBox(width: 10,),
                                  Text("${dateTimeViewModel.time}", style: AppTextStyles.getBasicStyle(),),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  if(broadcastLive?.user?.id == Helper.userId ) ...[
                    CustomButton(labelText: "End Broadcast".tr,
                      bgColor: Colors.redAccent,
                      height: 40,
                      // widthPercent: 20,
                      textStyle: AppTextStyles.getBoldStyle(color: Colors.white,fontSize: 16),
                      icon: const Icon(Icons.cancel_outlined,color: Colors.white,),
                      onPressed: ()=>onDeleteCourse(context)),
                    ] else ...[
                    ButtonLinkWebViewWidget(label: "Join".tr,
                        link:broadcastLive?.link ??"" ,
                        icon:const Icon(Icons.join_inner,color: AppColor.primaryIconColor,) ,
                        bgColor:Colors.redAccent ,
                        textStyle:AppTextStyles.getBoldStyle(color: Colors.white,fontSize: 16) ,)
                  ]
                    ],
                    ),


                ],
              ),


      ),
    );
  }


  void _onTap() {
    if (onPressed != null) {
      onPressed!(broadcastLive!);
    }
  }
  void onDeleteCourse(BuildContext _context) async{

    ShowAwesomeDialogBox(context:_context,dialogType: DialogType.question ,
        message:STOP_BROADCAST_MESSAGE,onAccept:() async{
      if(broadcastLive!=null) {
        BlocProvider.of<BroadcastLiveBloc>(_context).add(StopBroadcastLiveEvent(id: broadcastLive!.id!));
      }
    } );
  }
  void _onClickEdit() async{
    if (onEdit != null && Helper.isAdmin) {
     await onEdit!(broadcastLive!);
    }
  }
}
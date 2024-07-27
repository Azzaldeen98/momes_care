import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/enam/media_type.dart';
import 'package:moms_care/core/helpers/helpers.dart';
import 'package:moms_care/core/widget/button/button_link_web_view_widget.dart';
import 'package:moms_care/core/widget/image/image_widget.dart';
import 'package:moms_care/core/widget/video/video_widget.dart';
import 'package:moms_care/core/widget/video/youtube_player_widget.dart';
import 'package:moms_care/core/widget/web_view_screen.dart';

class ViewMediaWidget extends StatefulWidget {

  const ViewMediaWidget({super.key,required this.mediaURL});
  final String mediaURL;

  @override
  State<ViewMediaWidget> createState() => _ViewMediaWidgetState();
}

class _ViewMediaWidgetState extends State<ViewMediaWidget> {

  @override
  Widget build(BuildContext context) {

    final String mediaUrl=widget.mediaURL;

    if(mediaUrl!=null) {
      var mediaType=Helpers.detectFileType(mediaUrl);
      if (mediaType == MediaTypes.Image) {
        return ImageWidget(urlImage: mediaUrl, height: 300, width: 300);
      } else if ( mediaType == MediaTypes.Video) {
        return VideoPlayerScreen(videoURL: mediaUrl);
      }else if(mediaType==MediaTypes.Youtube){
        return  YoutubePlayerWidget(videoURL: mediaUrl);
      }else if(mediaType==MediaTypes.WebUrl){
        return  ButtonLinkWebViewWidget(link:mediaUrl,label: "Browse the site via the link".tr,);
      }
    }
    return const SizedBox();
  }


}
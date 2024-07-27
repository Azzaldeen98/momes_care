
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerWidget extends StatefulWidget {

  const YoutubePlayerWidget({super.key,required this.videoURL});
  final String videoURL;
  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    String? videoId = YoutubePlayer.convertUrlToId(widget.videoURL);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? 'iLnmTe5Q2Qw',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false, startAt: 0),
    );
    _controller.addListener(_listener);
  }

  void _listener() {
    setState(() {
      _isPlaying = _controller.value.isPlaying;
    });
  }


  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
      ),
      builder: (context, player) {
        return Center(
          child: Container(
            // height: 280,
            width: MediaQuery.of(context).size.width,
            margin:const EdgeInsets.all(0) ,
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color:const Color.fromRGBO(231, 164, 164, 1) ),
            ),
            child: Column(
              children: [
                player,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       padding: EdgeInsets.zero,
                //       margin:const EdgeInsets.only(top:5,bottom: 0),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(12),
                //         color: Colors.red,
                //       ),
                //       child: IconButton(
                //         icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow,
                //           color: Colors.white,
                //         ),
                //         onPressed: () {
                //           _isPlaying ?  _controller.pause(): _controller.play();
                //         },
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

}

// class YoutubePlayerWidget extends StatefulWidget {
//   const YoutubePlayerWidget({super.key,this.videoURL="https://youtu.be/Yp56thervZs?si=w8BM7yOA60FMStlE"});
//   final String videoURL;
//   @override
//   State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
// }
// class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
//
//
//   YoutubePlayerController? _controller;
//
//
//   @override
//   void initState() {
//
//     super.initState();
//
//     String?  videoId = YoutubePlayer.convertUrlToId(widget.videoURL ?? "https://www.youtube.com/watch?v=BBAyRBTfsOU");
//
//     _controller = YoutubePlayerController(
//        initialVideoId: videoId ?? 'iLnmTe5Q2Qw',
//       flags:const YoutubePlayerFlags(autoPlay: true, mute: false, startAt: 0),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return  YoutubePlayerBuilder(
//
//       player: YoutubePlayer(
//         showVideoProgressIndicator: true,
//         controller: _controller!,
//         progressIndicatorColor: Colors.amber,
//         progressColors: const ProgressBarColors(
//          playedColor: Colors.amber,
//          handleColor: Colors.amberAccent,),
//       ),
//       builder: (context, player) {
//         return Column(
//           children: [
//             // some widgets
//             player,
//           ],
//         );
//       },
//     );
//   // print(videoId); // BBAyRBTfsOU
//   //  return YoutubePlayer(
//   //    controller: _controller!,
//   //    showVideoProgressIndicator: true,
//   //    progressIndicatorColor: Colors.amber,
//   //    progressColors: const ProgressBarColors(
//   //      playedColor: Colors.amber,
//   //      handleColor: Colors.amberAccent,
//   //    ),
//   //    onReady: () {
//   //      _controller?.addListener(listener);
//   //    },
//   //  );
//   }
//
//
//   void listener() {
//   }
// }

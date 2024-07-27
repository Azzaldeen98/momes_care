
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/error/extination_valid.dart';
import 'package:moms_care/core/helpers/helpers.dart';
import 'package:moms_care/core/widget/empty_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key,required this.videoURL});
  final String videoURL;
  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  String? _videoURL;
  @override
  void initState() {
    super.initState();
    _videoURL=widget.videoURL;

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    if(_videoURL!.isValidAllowedVideoFile) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(_videoURL!));
      _initializeVideoPlayerFuture = _controller.initialize();
    }


  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    if(_controller!=null) {
      _controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return  (_controller!=null)?  _buildVideoPlayerWidget() :_errorVideoWidget();
  }

  Widget _buildVideoPlayerControllerWidget(){

   return  FloatingActionButton(
      onPressed: () {
        // Wrap the play or pause in a call to `setState`. This ensures the
        // correct icon is shown.
        setState(() {
          // If the video is playing, pause it.
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            // If the video is paused, play it.
            _controller.play();
          }
        });
      },
      // Display the correct icon depending on the state of the player.
      child: Icon(
        _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      ),
    );
  }
  Widget _buildVideoPlayerWidget(){
    return Container(
      // height: 300,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return Stack(
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                ),
                SizedBox(height: 20,),
                Positioned(
                  bottom: 20,
                  left: Helpers.getWidthPercent(context, 40),
                    child:  _buildVideoPlayerControllerWidget()),
              ],
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
  Widget _errorVideoWidget(){
    return EmptyWidget(explanatoryText: "ُError".tr,);
  }
}

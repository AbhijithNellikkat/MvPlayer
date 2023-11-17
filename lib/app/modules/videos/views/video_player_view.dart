import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/modules/videos/controllers/videos_player_controller.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:photo_manager/photo_manager.dart';

// ignore: must_be_immutable
class VideoPlayerView extends StatelessWidget {
  final AssetEntity video;

  VideoPlayerView({required this.video, Key? key}) : super(key: key);

  final VideosPlayerController videosPlayerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.black,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: videosPlayerController.initializeVideoPlayer(video),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Chewie(
                  controller: videosPlayerController.chewieController);
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Constants.black,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

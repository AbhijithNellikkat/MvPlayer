import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/modules/videos/controllers/videos_player_controller.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:photo_manager/photo_manager.dart';

class VideoPlayerView extends StatefulWidget {
  final AssetEntity video;

  const VideoPlayerView({required this.video, Key? key}) : super(key: key);

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  final VideosPlayerController videosPlayerController = Get.find();

  @override
  Widget build(BuildContext context) {
    log('path : ${widget.video.relativePath}');
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: FutureBuilder(
              future:
                  videosPlayerController.initializeVideoPlayer(widget.video),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Chewie(
                        controller: videosPlayerController.chewieController),
                  );
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
          Positioned(
            top: 40,
            left: 10,
            child: SizedBox(
              height: 60,
              width: 60,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  weight: 23,
                  color: Constants.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    videosPlayerController.videoPlayerController.dispose();
    videosPlayerController.chewieController.dispose();
    super.dispose();
  }
}

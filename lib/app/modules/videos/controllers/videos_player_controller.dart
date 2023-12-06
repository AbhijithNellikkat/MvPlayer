import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

class VideosPlayerController extends GetxController {
  late VideoPlayerController videoPlayerController;

  late ChewieController chewieController;

  RxBool isPlaying = false.obs;

  Future<void> initializeVideoPlayer(AssetEntity video) async {
    final File? videoFile = await video.file;
    log('$videoFile');

    

    if (videoFile != null) {
      videoPlayerController = VideoPlayerController.file(videoFile);
      await videoPlayerController.initialize();

      videoPlayerController.addListener(() {
        isPlaying.value = videoPlayerController.value.isPlaying;
      });

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        materialProgressColors: ChewieProgressColors(
          backgroundColor: Colors.white,
          playedColor: Colors.grey,
          handleColor: Colors.white,
        ),
        autoPlay: true,
        looping: false,
        allowFullScreen: false,
        placeholder: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        allowMuting: false,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );
    } else {
      log('Error: Video file is null.');
    }
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.onClose();
  }
}

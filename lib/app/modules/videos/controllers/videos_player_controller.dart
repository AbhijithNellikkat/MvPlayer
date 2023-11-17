import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideosPlayerController extends GetxController {
  late VideoPlayerController videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;
  bool isPlaying = false;


    @override
  void onInit()  {

    initializeVideoPlayer();
    super.onInit();
  }


   Future<void> initializeVideoPlayer() async {
    final File? videoFile = await Get.arguments['video']?.file;

    if (videoFile != null) {
      videoPlayerController = VideoPlayerController.file(videoFile);
      initializeVideoPlayerFuture = videoPlayerController.initialize();

      videoPlayerController.addListener(() {
        if (videoPlayerController.value.isPlaying) {
          isPlaying = true;
        } else {
          isPlaying = false;
        }
        update();
      });
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Unable to load the video.',
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      );
    }
  }


    @override
  void onClose() {
    videoPlayerController.dispose();
    super.onClose();
  }
}

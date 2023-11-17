import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

class VideosPlayerController extends GetxController {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  RxBool isPlaying = false.obs;

  Future<void> initializeVideoPlayer(AssetEntity video) async {
    final File? videoFile = await video.file;

    if (videoFile != null) {
      videoPlayerController = VideoPlayerController.file(videoFile);
      await videoPlayerController.initialize();

      videoPlayerController.addListener(() {
        isPlaying.value = videoPlayerController.value.isPlaying;
      });

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        autoInitialize: true,
        materialProgressColors: ChewieProgressColors(
          
          playedColor: Constants.white,
          handleColor: Constants.black,
        ),
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

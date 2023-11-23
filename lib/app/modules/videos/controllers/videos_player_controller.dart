import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/constants/constants.dart';

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
        autoPlay: true,
        looping: false,
        fullScreenByDefault: true,
        placeholder: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        allowMuting: true,
        additionalOptions: (context) {
          return [
            OptionItem(
              onTap: () {},
              iconData: Constants.musicPlayArrow,
              title: 'Option 1',
            ),
            OptionItem(
              onTap: () {},
              iconData: Constants.musicPlayArrow,
              title: 'Option 2',
            ),
            OptionItem(
              onTap: () {},
              iconData: Constants.musicPlayArrow,
              title: 'Option 3',
            ),
          ];
        },
        materialProgressColors: ChewieProgressColors(
          playedColor: Constants.white,
          handleColor: Constants.black,
        ),
      );
    } else {
      log('Error: Video file is null.');
    }
  }

  // late VlcPlayerController vlcPlayerController;

  // Future<void> initializeVideoPlayer(AssetEntity video) async {
  //   final File? videoFile = await video.file;

  //   if (videoFile != null) {
  //     vlcPlayerController = VlcPlayerController.file(
  //       videoFile,
  //       allowBackgroundPlayback: false,
  //       autoPlay: true,
  //       options: VlcPlayerOptions(),
  //     );

  //     await vlcPlayerController.initialize();
  //   } else {
  //     // Handle the case where the video file is null
  //     log('Error: Video file is null.');
  //   }
  // }

  // void play() {
  //   vlcPlayerController.play();
  // }

  // void pause() {
  //   vlcPlayerController.pause();
  // }

  // void stop() {
  //   vlcPlayerController.stop();
  // }

  @override
  void onClose() {
    // vlcPlayerController.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
    super.onClose();
  }
}

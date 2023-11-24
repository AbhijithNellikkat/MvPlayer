import 'dart:developer';

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
    log('path : ${video.relativePath}');
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                  )),
            ),
          )
        ],
      ),
    );
  }
}












//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         color: Colors.black,
//         width: double.infinity,
//         height: MediaQuery.of(context).size.height,
//         child: FutureBuilder(
//           future: videosPlayerController.initializeVideoPlayer(video),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   VlcPlayer(
//                     controller: videosPlayerController.vlcPlayerController,
//                     aspectRatio: 16 / 18,
//                     placeholder: const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                     virtualDisplay: true,
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           videosPlayerController.play();
//                         },
//                         icon: Icon(
//                           Icons.play_arrow,
//                           color: Colors.white,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           videosPlayerController.pause();
//                         },
//                         icon: Icon(Icons.pause, color: Colors.white),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           videosPlayerController.stop();
//                         },
//                         icon: Icon(Icons.stop, color: Colors.white),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           // Add your custom functionality
//                         },
//                         icon: Icon(
//                           Icons.youtube_searched_for,
//                           color: Colors.amber,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               );
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(
//                   color: Constants.black,
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
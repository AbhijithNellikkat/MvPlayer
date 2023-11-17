import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  final AssetEntity video;

  VideoPlayerView({required this.video, Key? key}) : super(key: key);

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  // late VideoPlayerController videoPlayerController;

  // late Future<void> initializeVideoPlayerFuture;

  // bool isPlaying = false;

  late VideoPlayerController videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture; // Initialize this variable

  bool isPlaying = false;
  // @override
  // void initState() {
  //   initializeVideoPlayer();
  //   super.initState();
  // }

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayerFuture = initializeVideoPlayer();
  }

  Future<void> initializeVideoPlayer() async {
    final File? videoFile = await widget.video.file;

    if (videoFile != null) {
      videoPlayerController = VideoPlayerController.file(videoFile);
      await videoPlayerController.initialize();

      videoPlayerController.addListener(() {
        if (videoPlayerController.value.isPlaying) {
          setState(() {
            isPlaying = true;
          });
        } else {
          setState(() {
            isPlaying = false;
          });
        }
      });
    } else {
      // Handle the case where the file is null
      log('Error: Video file is null.');
    }
  }

  // Future<void> initializeVideoPlayer() async {
  //   final File? videoFile = await widget.video.file;
  //   if (videoFile != null) {
  //     videoPlayerController = VideoPlayerController.file(videoFile);
  //     initializeVideoPlayerFuture = videoPlayerController.initialize();

  //     videoPlayerController.addListener(() {
  //       if (videoPlayerController.value.isPlaying) {
  //         setState(() {
  //           isPlaying = true;
  //         });
  //       } else {
  //         setState(() {
  //           isPlaying = false;
  //         });
  //       }
  //     });
  //   } else {
  //     // Handle the case where the file is null
  //     log('Error: Video file is null.');
  //     // ignore: use_build_context_synchronously
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: Text('Unable to load the video.'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Video Player'),
  //     ),
  //     body: Center(
  //       child: FutureBuilder(
  //         future: initializeVideoPlayerFuture,
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.done) {
  //             return AspectRatio(
  //               aspectRatio: videoPlayerController.value.aspectRatio,
  //               child: VideoPlayer(videoPlayerController),
  //             );
  //           } else {
  //             return CircularProgressIndicator();
  //           }
  //         },
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () {
  //         if (isPlaying) {
  //           videoPlayerController.pause();
  //         } else {
  //           videoPlayerController.play();
  //         }
  //       },
  //       child: Icon(
  //         isPlaying ? Icons.pause : Icons.play_arrow,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: videoPlayerController.value.aspectRatio,
                child: VideoPlayer(videoPlayerController),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isPlaying) {
            videoPlayerController.pause();
          } else {
            videoPlayerController.play();
          }
        },
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}

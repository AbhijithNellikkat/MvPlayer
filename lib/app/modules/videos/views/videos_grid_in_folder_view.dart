import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/videos/controllers/videos_controller.dart';
import 'package:mv_player/app/modules/videos/views/video_player_view.dart';
import 'package:photo_manager/photo_manager.dart';

class VideosGridInFolderView extends GetView<VideosController> {
  final List<AssetEntity> videos;
  final String foldersName;

  VideosGridInFolderView(
      {required this.videos, required this.foldersName, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          foldersName,
          style: GoogleFonts.poppins(),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => VideoPlayerView(video: videos[index]));
                log('Selected video path: ${videos[index].relativePath}');
              },
              child: Stack(
                children: [
                  FutureBuilder<Uint8List?>(
                    future: videos[index].thumbnailDataWithSize(
                      const ThumbnailSize(120, 120),
                      format: ThumbnailFormat.jpeg,
                      quality: 100,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.data != null) {
                        return Image.memory(
                          snapshot.data!,
                          filterQuality: FilterQuality.high,
                          width: 159,
                          height: 190,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return SizedBox(
                          width: 130,
                          height: 130,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                  Positioned(
                    bottom: 9,
                    right: 9,
                    child: Container(
                      width: 44,
                      height: 19,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(93, 17, 17, 17),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Center(
                        child: Text(
                          '${(videos[index].duration)}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

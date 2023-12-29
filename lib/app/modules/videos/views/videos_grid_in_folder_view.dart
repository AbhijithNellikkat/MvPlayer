import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/videos/controllers/videos_controller.dart';
import 'package:mv_player/app/modules/videos/views/video_player_view.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../utils/constants/constants.dart';

class VideosGridInFolderView extends GetView {
  final List<AssetEntity> videos;
  final String foldersName;
  const VideosGridInFolderView(
      {required this.videos, required this.foldersName, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          foldersName,
          style: GoogleFonts.poppins(
              // color: Colors.black,
              ),
        ),
        // backgroundColor: Constants.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Constants.backArrow,
              // color: Constants.black,
            )),
      ),
      body: GetBuilder<VideosController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(VideoPlayerView(
                      video: videos[index],
                    ));
                    log('Selected video path: ${videos[index].relativePath}');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        FutureBuilder<Uint8List?>(
                          future: videos[index].thumbnailDataWithSize(
                            const ThumbnailSize(120, 120),
                            format: ThumbnailFormat.jpeg,
                            quality: 100,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data != null) {
                              return Image.memory(
                                snapshot.data!,
                                filterQuality: FilterQuality.high,
                                width: 159,
                                height: 190,
                                fit: BoxFit.cover,
                              );
                            } else {
                              return const SizedBox(
                                width: 130,
                                height: 130,
                                // color: Colors.black,
                                child: Center(
                                  child: CircularProgressIndicator(
                                      // color: Colors.white,
                                      ),
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
                            // color: const Color.fromARGB(93, 17, 17, 17),
                            child: Text(
                              '${videos[index].duration.minutes}',
                              style: const TextStyle(
                                  // color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

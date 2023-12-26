import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/videos/controllers/videos_controller.dart';
import 'package:mv_player/app/modules/videos/views/video_player_view.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:photo_manager/photo_manager.dart';

class VideosListInFolderView extends StatelessWidget {
  final List<AssetEntity> videos;
  final String foldersName;

  const VideosListInFolderView(
      {Key? key, required this.videos, required this.foldersName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          foldersName,
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        backgroundColor: Constants.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Constants.backArrow,
              color: Constants.black,
            )),
      ),
      body: GetBuilder<VideosController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.transparent),
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    videos[index].title ?? 'Untitled',
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  leading: Stack(
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
                              width: 120,
                              height: 190,
                              fit: BoxFit.cover,
                            );
                          } else {
                            return Container(
                              width: 130,
                              height: 130,
                              color: Colors.black,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      Positioned(
                        bottom: 3,
                        right: 3,
                        child: Container(
                          width: 44,
                          height: 15,
                          color: const Color.fromARGB(255, 17, 17, 17),
                          child: Text(
                            '${videos[index].duration.minutes}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.to(VideoPlayerView(
                      video: videos[index],
                    ));
                    log('Selected video path: ${videos[index].relativePath}');
                  },
                  trailing: IconButton(
                    onPressed: () {
                      showDeleteConfirmationDialog(context, videos[index]);
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
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

Future<void> showDeleteConfirmationDialog(
    BuildContext context, AssetEntity video) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Video'),
        content: const Text('Are you sure you want to delete this video?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {},
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}

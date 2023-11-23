import 'dart:developer';

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
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(videos[index].title ?? 'Untitled'),
                    subtitle: Text('Path: ${videos[index].relativePath}'),
                    onTap: () {
                      Get.to(VideoPlayerView(
                        video: videos[index],
                      ));
                      log('Selected video path: ${videos[index].relativePath}');
                    },
                  );
                },
              ),
            );
          },
        ));
  }
}

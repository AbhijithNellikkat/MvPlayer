import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/modules/videos/controllers/videos_controller.dart';
import 'package:mv_player/app/modules/videos/views/video_player_view.dart';
import 'package:photo_manager/photo_manager.dart';

class VideosListInFolderView extends StatelessWidget {
  final List<AssetEntity> videos;

  const VideosListInFolderView({Key? key, required this.videos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Videos in Folder'),
        ),
        body: GetBuilder<VideosController>(
          builder: (controller) {
            return ListView.builder(
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
            );
          },
        ));
  }
}

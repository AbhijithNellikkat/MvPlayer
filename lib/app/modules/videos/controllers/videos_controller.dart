import 'dart:developer';

// import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import 'package:photo_manager/photo_manager.dart';

// import 'package:mv_player/app/modules/videos/controllers/video_model.dart';

class VideosController extends GetxController {
  // RxList<VideoModel> videos = <VideoModel>[].obs;

  // Future<void> fetchAllVideos() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.video,
  //       allowMultiple: true,
  //     );

  //     if (result != null) {
  //       List<VideoModel> selectedVideos = result.paths.map((path) {
  //         String name = path!.split('/').last;
  //         return VideoModel(name: name, path: path);
  //       }).toList();

  //       videos.assignAll(selectedVideos);
  //     }
  //   } catch (e) {
  //     ('Error selecting videos: $e');
  //   }
  // }
  Future<void> fetchMediaPaths() async {
    try {
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList();

      for (var path in paths) {
        log('Path Name: ${path.name}');
        // ignore: deprecated_member_use
        log('Number of Assets: ${path.assetCount}');

        // Fetch and display videos associated with this path
        // ignore: deprecated_member_use
        final List<AssetEntity> videos =
            // ignore: deprecated_member_use
            await path.getAssetListRange(start: 0, end: path.assetCount);

        for (var video in videos) {
          log('Video Name: ${video.title}');
          log('Video Path: ${video.relativePath}'); // You can use this path to display the video.
          // Add your logic to display or process each video as needed.
        }
      }
    } catch (e) {
      log('Error fetching media paths: $e');
    }
  }
}

import 'dart:developer';

import 'package:get/get.dart';
import 'package:mv_player/app/modules/videos/views/videos_grid_in_folder_view.dart';
import 'package:mv_player/app/modules/videos/views/videos_list_in_folder_view.dart';
import 'package:photo_manager/photo_manager.dart';

class VideosController extends GetxController {
  final RxList<AssetEntity> videos = <AssetEntity>[].obs;
  RxList<AssetPathEntity> folders = <AssetPathEntity>[].obs;

  RxBool isGridView = true.obs;


  void toggleView() {
    isGridView.toggle();
    update();
  }

  Future<void> fetchMediaFolders() async {
    log('--------------------------- Fetch Media Folders ---------------------------');
    try {
      final List<AssetPathEntity> paths =
          await PhotoManager.getAssetPathList(type: RequestType.video);

      folders.assignAll(paths);
      log('Folders : $folders');
    } catch (e) {
      log('Error fetching media folders: $e');
    }
  }

  Future<void> navigateToVideosInFolder(
      {required AssetPathEntity folder, required String foldersName}) async {
    try {
      final List<AssetEntity> videos =
          // ignore: deprecated_member_use
          await folder.getAssetListRange(start: 0, end: folder.assetCount);

      this.videos.assignAll(videos);
      Get.to(() => VideosListInFolderView(
            videos: videos,
            foldersName: foldersName,
          ));
    } catch (e) {
      log('Error navigating to videos: $e');
    }
  }

  Future<void> navigateToVideosGridInFolder(
      {required AssetPathEntity folder, required String foldersName}) async {
    try {
      final List<AssetEntity> videos =
          // ignore: deprecated_member_use
          await folder.getAssetListRange(start: 0, end: folder.assetCount);

      this.videos.assignAll(videos);
      Get.to(() => VideosGridInFolderView(
            videos: videos,
            foldersName: foldersName,
          ));
    } catch (e) {
      log('Error navigating to videos: $e');
    }
  }
}

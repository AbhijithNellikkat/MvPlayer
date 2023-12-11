import 'dart:developer';

import 'package:get/get.dart';
import 'package:mv_player/app/modules/videos/views/videos_grid_in_folder_view.dart';
import 'package:mv_player/app/modules/videos/views/videos_list_in_folder_view.dart';
import 'package:photo_manager/photo_manager.dart';

class VideosController extends GetxController {
  final RxList<AssetEntity> videos = <AssetEntity>[].obs;
  RxList<AssetPathEntity> folders = <AssetPathEntity>[].obs;

  RxBool isGridView = true.obs;

  @override
  void onInit() {
    fetchMediaFolders().then((List<AssetPathEntity> result) {
      // Handle the result here if needed
      log('Fetched media folders: $result');
    }).catchError((error) {
      // Handle the error here if needed
      log('Error fetching media folders: $error');
    });

    log('====================== VideosController  onInit ======================');
    super.onInit();
  }

  void toggleView() {
    isGridView.toggle();
    update();
  }

  Future<List<AssetPathEntity>> fetchMediaFolders() async {
    log('--------------------------- Fetch Media Folders ---------------------------');
    try {
      final List<AssetPathEntity> paths =
          await PhotoManager.getAssetPathList(type: RequestType.video);

      folders.assignAll(paths);
      update();
      log('folders : $folders');
      return paths;
    } catch (e) {
      log('Error fetching media folders: $e');
      // You might want to handle the error accordingly, e.g., throw an exception or return an empty list
      return [];
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

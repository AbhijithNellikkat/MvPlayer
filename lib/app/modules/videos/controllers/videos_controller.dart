import 'dart:developer';
import 'package:get/get.dart';
import 'package:mv_player/app/modules/videos/views/videos_list_in_folder_view.dart';
import 'package:photo_manager/photo_manager.dart';

class VideosController extends GetxController {
  final RxList<AssetEntity> videos = <AssetEntity>[].obs;
  final RxList<AssetPathEntity> folders = <AssetPathEntity>[].obs;

  @override
  void onInit() {
    fetchMediaFolders();

    super.onInit();
  }

  Future<void> fetchMediaFolders() async {
    try {
      final List<AssetPathEntity> paths =
          await PhotoManager.getAssetPathList(type: RequestType.video);

      folders.assignAll(paths);
    } catch (e) {
      log('Error fetching media folders: $e');
    }
  }

  Future<void> navigateToVideosInFolder(AssetPathEntity folder) async {
    try {
      final List<AssetEntity> videos =
          // ignore: deprecated_member_use
          await folder.getAssetListRange(start: 0, end: folder.assetCount);
      update();

      this.videos.assignAll(videos);
      Get.to(() => VideosListInFolderView(videos: videos));
    } catch (e) {
      log('Error navigating to videos: $e');
    }
  }
}

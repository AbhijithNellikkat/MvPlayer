import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../data/db_functions.dart';

class FetchLocalAlbumsController extends GetxController {
  RxList<AlbumModel> allAlbums = <AlbumModel>[].obs;

  final DbFunctions dbFunctions = DbFunctions();
  @override
  void onInit() {
    fetchLocalAlbums();
    super.onInit();
  }

  Future<void> fetchLocalAlbums() async {
    List<AlbumModel> albums = await dbFunctions.getLocalAlbums();
    allAlbums.assignAll(albums);
  }
}

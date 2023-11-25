import 'package:get/get.dart';

import 'package:mv_player/app/modules/musics/controllers/favourites_controller.dart';
import 'package:mv_player/app/modules/musics/controllers/music_player_controller.dart';
import 'package:mv_player/app/modules/musics/controllers/playlist_controller.dart';

class MusicsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouritesController>(
      () => FavouritesController(),
    );
    Get.put<PlaylistController>(PlaylistController());
    Get.put<MusicPlayerController>(MusicPlayerController());
  }
}

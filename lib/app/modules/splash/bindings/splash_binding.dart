import 'package:get/get.dart';
import 'package:mv_player/app/modules/home/controllers/home_controller.dart';
import 'package:mv_player/app/modules/home/controllers/nav_bar_controller_controller.dart';
import 'package:mv_player/app/modules/settings/controllers/settings_controller.dart';
import 'package:mv_player/app/modules/videos/controllers/videos_controller.dart';
import 'package:mv_player/app/modules/videos/controllers/videos_player_controller.dart';

import '../../musics/controllers/favourites_controller.dart';
import '../../musics/controllers/music_player_controller.dart';
import '../../musics/controllers/playlist_controller.dart';
import '../../musics/controllers/tracks_controller.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<VideosController>(VideosController());
    Get.put<HomeController>(HomeController());
    Get.put<SplashController>(SplashController());
    Get.put<NavBarController>(NavBarController());
    Get.lazyPut<TracksController>(
      () => TracksController(),
    );
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
    Get.lazyPut<FavouritesController>(
      () => FavouritesController(),
    );

    Get.put<VideosPlayerController>(VideosPlayerController());
    Get.put<PlaylistController>(PlaylistController());

    Get.put<MusicPlayerController>(MusicPlayerController());
  }
}

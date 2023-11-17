import 'package:get/get.dart';
import 'package:mv_player/app/modules/home/controllers/home_controller.dart';
import 'package:mv_player/app/modules/home/controllers/nav_bar_controller_controller.dart';
import 'package:mv_player/app/modules/videos/controllers/videos_controller.dart';

import '../../musics/controllers/music_player_controller.dart';
import '../../musics/controllers/playlist_controller.dart';
import '../../musics/controllers/tracks_controller.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<SplashController>(SplashController());
    Get.put<NavBarController>(NavBarController());
    Get.lazyPut<TracksController>(
      () => TracksController(),
    );

 
    Get.put<PlaylistController>(PlaylistController());
    Get.put<VideosController>(VideosController());
    Get.put<MusicPlayerController>(MusicPlayerController());
  }
}

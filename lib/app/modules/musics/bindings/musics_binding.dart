import 'package:get/get.dart';
import 'package:mv_player/app/modules/musics/controllers/music_player_controller.dart';

class MusicsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MusicPlayerController>(MusicPlayerController());
    // Get.put<MusicsController>(MusicsController());
    // Get.put<TracksController>(TracksController());
  }
}

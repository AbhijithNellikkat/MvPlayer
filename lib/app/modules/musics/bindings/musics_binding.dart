import 'package:get/get.dart';
import 'package:mv_player/app/modules/musics/controllers/all_musics_player_controller.dart';

import '../controllers/musics_controller.dart';

class MusicsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MusicsController>(MusicsController());
    Get.put<AllMusicsPlayerController>(AllMusicsPlayerController());
  }
}

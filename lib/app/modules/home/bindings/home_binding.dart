import 'package:get/get.dart';
import 'package:mv_player/app/modules/home/controllers/nav_bar_controller_controller.dart';
import 'package:mv_player/app/modules/musics/controllers/all_musics_player_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NavBarController>(NavBarController());
    Get.put<HomeController>(HomeController());
    Get.put<AllMusicsPlayerController>(AllMusicsPlayerController());
  }
}

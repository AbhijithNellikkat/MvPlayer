import 'package:get/get.dart';
import 'package:mv_player/app/modules/videos/controllers/videos_player_controller.dart';
import '../controllers/videos_controller.dart';

class VideosBinding extends Bindings {
  @override
  void dependencies() {

    Get.put<VideosController>(VideosController());
   
  }
}

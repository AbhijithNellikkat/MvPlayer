import 'package:get/get.dart';

import '../controllers/videos_controller.dart';

class VideosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideosController>(
      () => VideosController(),
    );
  }
}

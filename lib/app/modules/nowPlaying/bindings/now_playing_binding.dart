import 'package:get/get.dart';

import '../controllers/now_playing_controller.dart';

class NowPlayingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NowPlayingController>(
      () => NowPlayingController(),
    );
  }
}

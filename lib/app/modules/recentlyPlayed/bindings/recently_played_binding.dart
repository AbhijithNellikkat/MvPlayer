import 'package:get/get.dart';

import '../controllers/recently_played_controller.dart';

class RecentlyPlayedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecentlyPlayedController>(
      () => RecentlyPlayedController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/musics_controller.dart';

class MusicsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MusicsController>(MusicsController());
  }
}

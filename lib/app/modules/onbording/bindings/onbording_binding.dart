import 'package:get/get.dart';

import '../controllers/onbording_controller.dart';

class OnbordingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OnbordingController>(OnbordingController());
  }
}

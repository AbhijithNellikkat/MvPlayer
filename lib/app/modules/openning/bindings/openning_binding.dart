import 'package:get/get.dart';

import '../controllers/openning_controller.dart';

class OpenningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OpenningController>(
      () => OpenningController(),
    );
  }
}

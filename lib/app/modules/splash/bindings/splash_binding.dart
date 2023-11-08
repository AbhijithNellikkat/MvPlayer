import 'package:get/get.dart';

import '../../home/controllers/permission_controller.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.put<SplashController>(SplashController());
  }
}

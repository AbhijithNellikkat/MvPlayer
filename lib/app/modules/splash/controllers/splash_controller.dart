import 'package:get/get.dart';
import 'package:mv_player/app/routes/app_pages.dart';
// import 'package:mv_player/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 1),
        () => Get.offAndToNamed(Routes.ONBORDING));
  }
}

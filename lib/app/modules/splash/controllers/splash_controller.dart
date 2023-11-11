import 'package:get/get.dart';
import 'package:mv_player/app/routes/app_pages.dart';

class SplashController extends GetxController {


  @override
  void onReady() {
    super.onReady();
    Future.delayed(
        const Duration(seconds: 2), () => Get.offAndToNamed(Routes.ONBORDING));
  }
}

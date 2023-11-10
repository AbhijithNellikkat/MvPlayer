import 'package:get/get.dart';
import 'package:mv_player/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mv_player/app/routes/app_pages.dart';

int? isViewed;

class SplashController extends GetxController {


  @override
  void onReady() {
    super.onReady();
    Future.delayed(
        const Duration(seconds: 2), () => Get.offAndToNamed(Routes.ONBORDING));
  }
}

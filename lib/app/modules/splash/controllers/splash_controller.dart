import 'dart:developer';


import 'package:get/get.dart';
import 'package:mv_player/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  RxBool isFirstLaunch = true.obs;

  Future<void> checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstLaunch.value = prefs.getBool('isFirstLaunch') ?? true;
    log('isFirstLaunch: ${isFirstLaunch.value}');

    if (isFirstLaunch.value) {
      prefs.setBool('isFirstLaunch', false);
    }
  }

  Future<void> delayAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));
    log('Navigating to: ${isFirstLaunch.value ? 'OnbordingView' : 'BottomNavbarView'}');
    Get.offAllNamed(
        isFirstLaunch.value ? Routes.ONBORDING : Routes.BOTTOMNAVIGATIONBAR);
  }

  @override
  void onInit() {
    checkFirstLaunch();
    super.onInit();
  }

  
}

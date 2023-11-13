import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/modules/splash/bindings/splash_binding.dart';

import 'app/modules/home/controllers/permission_controller.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final permission = Get.put(PermissionController());
  permission.requestStoragePermission();
  permission.justAudioBackgroundInit();

  runApp(
    GetMaterialApp(
      title: "Mv Player",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      initialBinding: SplashBinding(),
      
    ),
  );
}

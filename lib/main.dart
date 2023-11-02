import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/modules/home/bindings/home_binding.dart';
import 'package:mv_player/app/modules/home/controllers/permission_controller.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final PermissionController permissionController =
      Get.put<PermissionController>(PermissionController());

  permissionController.requestpermission();

  runApp(
    GetMaterialApp(
      title: "Mv Player",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
    ),
  );
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    Future.delayed(const Duration(seconds: 4), () async {
      await Permission.storage.request();
    });
  } catch (e) {
    log('$e');
  }

  runApp(
    GetMaterialApp(
      title: "Mv Player",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(                                               ),
    ),
  );
}

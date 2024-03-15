// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mv_player/app/data/models/models.dart';
import 'package:mv_player/app/data/models/songmodel_adapter.dart';
import 'package:mv_player/app/modules/splash/bindings/splash_binding.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:mv_player/app/utils/themes/app_theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app/modules/home/controllers/permission_controller.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final permission = Get.put(PermissionController());

  // permission.requestStoragePermission();

  permission.justAudioBackgroundInit();

  Future.delayed(
    const Duration(seconds: 3),
    () async {
      await Permission.audio.request();
      await Permission.videos.request();
      // await Permission.photos.request();
    },
  );

  Directory directory = await getApplicationDocumentsDirectory();
  log('directory path :  ${directory.path}');

  // Initializes Hive with the path from getApplicationDocumentsDirectory
  Hive.init(directory.path);

  // Register the Adapter
  Hive.registerAdapter(MusicModelAdapter());
  Hive.registerAdapter(SongModelAdapter());

  await Hive.openBox(Constants.boxName);

  runApp(
    GetMaterialApp(
      title: "Mv Player",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      initialBinding: SplashBinding(),
      theme: AppThemes.lightTheme(),
      darkTheme: AppThemes.darkTheme(),
      themeMode: ThemeMode.system,
    ),
  );
}

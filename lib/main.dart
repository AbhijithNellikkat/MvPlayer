import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mv_player/app/data/models/models.dart';
import 'package:mv_player/app/data/models/songmodel_adapter.dart';
import 'package:mv_player/app/modules/splash/bindings/splash_binding.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:path_provider/path_provider.dart';

import 'app/modules/home/controllers/permission_controller.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final permission = Get.put(PermissionController());

  permission.requestStoragePermission();
  permission.justAudioBackgroundInit();

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
      theme: ThemeData(
        dialogBackgroundColor: Constants.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Colors.black,
        ),
        useMaterial3: true,
      ),
    ),
  );
}

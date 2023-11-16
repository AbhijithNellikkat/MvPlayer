import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  Future<void> justAudioBackgroundInit() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );
  }

  Future<void> requestStoragePermission() async {
    Future.delayed(
      const Duration(seconds: 5),
      () async {
        try {
          final PermissionStatus status = await Permission.storage.request();
          log('=================================== $status ===================================');

          if (status == PermissionStatus.granted) {
            Get.snackbar(
              'Granted',
              'The Permission is Granted',
              margin: const EdgeInsets.all(12),
            );
          }
          if (status == PermissionStatus.denied) {
            Get.snackbar(
              'Required',
              'The Permission is required !',
              margin: const EdgeInsets.all(12),
            );
            // await Permission.storage.request();
            Future.delayed(const Duration(seconds: 3), () => openAppSettings());
          }
        } on Exception catch (e) {
          log('------------------------------------- $e -------------------------------------');
        }
      },
    );
  }
}

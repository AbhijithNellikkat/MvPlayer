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
      const Duration(seconds: 4),
      () async {
        try {
          final PermissionStatus status = await Permission.storage.request();
          log('=================================== $status ===================================');

          if (status == PermissionStatus.granted) {
            Get.snackbar(
              'Granted',
              'The Permission is Granted',
              margin: const EdgeInsets.all(12),
              duration: const Duration(seconds: 2),
            );
          }
          if (status == PermissionStatus.denied) {
            Get.snackbar(
              'Required',
              'The Permission is required !',
              margin: const EdgeInsets.all(12),
              duration: const Duration(seconds: 2),
            );
            // await Permission.storage.request();
            Future.delayed(
              const Duration(seconds: 2),
              () => openAppSettings().then(
                (value) => value
                    ? requestStoragePermission()
                    : Get.snackbar(
                        'Granted',
                        'The Permission is Granted',
                        margin: const EdgeInsets.all(12),
                        duration: const Duration(seconds: 2),
                      ),
              ),
            );
          }
          if (status == PermissionStatus.permanentlyDenied) {
            requestStoragePermission();
            // Get.snackbar(
            //   'permanentlyDenied',
            //   'The Permission is required !',
            //   margin: const EdgeInsets.all(12),
            //   duration: const Duration(seconds: 2),
            // );
          }
        } on Exception catch (e) {
          log('------------------------------------- $e -------------------------------------');
        }
      },
    );
  }
}

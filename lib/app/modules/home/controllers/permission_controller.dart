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
    try {
      final PermissionStatus status = await Permission.storage.status;
      log('=================================== $status ===================================');

      if (status.isGranted) {
        Get.snackbar(
          'Granted',
          'The Permission is Granted',
          margin: const EdgeInsets.all(12),
          duration: const Duration(seconds: 2),
        );
      } else if (status.isDenied || status.isPermanentlyDenied) {
        // If permission is denied or permanently denied, request permission
        final PermissionStatus updatedStatus =
            await Permission.storage.request();

        if (updatedStatus.isGranted) {
          // Permission granted after request
          Get.snackbar(
            'Granted',
            'The Permission is Granted',
            margin: const EdgeInsets.all(12),
            duration: const Duration(seconds: 2),
          );
        } else {
          // Permission still denied or permanently denied after request
          Get.snackbar(
            'Required',
            'The Permission is required !',
            margin: const EdgeInsets.all(12),
            duration: const Duration(seconds: 2),
          );

          // Prompt user to go to settings to enable permission
          Future.delayed(const Duration(seconds: 2), () {
            openAppSettings();
          });
        }
      }
    } catch (e) {
      log('------------------------------------- $e -------------------------------------');
    }
  }
}

import 'dart:developer';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  void checkpermission() async {
    Future.delayed(
      const Duration(seconds: 6),
      () async {
        try {
          await Permission.storage.request();
          await Permission.audio.request();
          await Permission.microphone.request();
        } catch (e) {
          log('$e');
        }
      },
    );
  }
}

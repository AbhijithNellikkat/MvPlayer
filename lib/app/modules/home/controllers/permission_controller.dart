import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  final _audioQuery = OnAudioQuery();
  void requestpermission() async {
    try {
      if (!kIsWeb) {
        bool permissionStatus = await _audioQuery.permissionsStatus();
        if (!permissionStatus) {
          await _audioQuery.permissionsRequest();
        }
        update();
      }
      Future.delayed(const Duration(seconds: 4), () async {
        await Permission.storage.request();
      });
    } catch (e) {
      log('$e');
    }
  }
}

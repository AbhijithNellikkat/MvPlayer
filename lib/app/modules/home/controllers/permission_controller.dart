import 'dart:async';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  Rx<PermissionStatus> status = PermissionStatus.denied.obs;
  final Duration checkInterval = Duration(seconds: 5);
  late Timer _statusCheckTimer;

  Future<void> requestPermission() async {
   final result = await Permission.storage.request();
      status.value = result;
  }

  @override
  void onInit() {
    super.onInit();
    // Start a timer to periodically check and update the permission status.
    _statusCheckTimer = Timer.periodic(checkInterval, (timer) async {
      final result = await Permission.storage.status;
      status.value = result;
    });
  }

  @override
  void onClose() {
    super.onClose();
    // Cancel the timer when the controller is closed.
    _statusCheckTimer.cancel();
  }
}

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkPermission();
  } 

  checkPermission() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      Fluttertoast.showToast(msg: 'storage access granted', gravity: ToastGravity.TOP);
    } else if (status.isDenied) {
      requestStoragePermission();
    }
  }

  void requestStoragePermission() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
       Fluttertoast.showToast(msg: 'storage access granted', gravity: ToastGravity.TOP);
    } else if (status.isDenied) {
       Fluttertoast.showToast(msg: 'storage access Denied', gravity: ToastGravity.TOP);
    } else if (status.isPermanentlyDenied) {
       Fluttertoast.showToast(msg: 'storage access PermanentlyDenied', gravity: ToastGravity.TOP);
    }
  }
}                                                                       

import 'package:get/get.dart';

import '../controllers/create_account_controller.dart';

class CreateAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CreateAccountController>(CreateAccountController());
  }
}

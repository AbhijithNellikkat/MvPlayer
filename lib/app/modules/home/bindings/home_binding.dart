import 'package:get/get.dart';
import 'package:mv_player/app/modules/home/controllers/fetch_local_albums_controller.dart';
import 'package:mv_player/app/modules/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut<FetchLocalAlbumsController>(
      () => FetchLocalAlbumsController(),
    );
    Get.put<HomeController>(HomeController());
  }
}

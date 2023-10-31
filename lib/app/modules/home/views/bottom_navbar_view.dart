import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/modules/home/views/home_view.dart';
import '../../musics/views/musics_view.dart';
import '../../profile/views/profile_view.dart';
import '../../videos/views/videos_view.dart';
import '../controllers/nav_bar_controller_controller.dart';

// ignore: must_be_immutable
class BottomNavbarView extends StatelessWidget {
  BottomNavbarView({Key? key}) : super(key: key);

  final NavBarController navBarController = Get.find();

  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
      builder: (context) {
        return Scaffold(
          body: IndexedStack(
            index: navBarController.tabIndex,
            children: [
              const HomeView(),
              MusicsView(),
              const VideosView(),
              const ProfileView(),
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.white,
            color: Colors.black,
            index: navBarController.tabIndex,
            key: bottomNavigationKey,
            items: const <Widget>[
              Icon(
                Icons.home,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.music_note,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.play_circle_fill_outlined,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              ),
            ],
            onTap: navBarController.changeTabIndex,
          ),
        );
      },
    );
  }
}

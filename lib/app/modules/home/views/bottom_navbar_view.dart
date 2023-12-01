import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mv_player/app/modules/home/views/home_view.dart';
import 'package:mv_player/app/modules/settings/views/settings_view.dart';

import '../../musics/views/musics_view.dart';
import '../../videos/views/videos_view.dart';
import '../controllers/nav_bar_controller_controller.dart';

// ignore: must_be_immutable
class BottomNavbarView extends StatelessWidget {
  BottomNavbarView({Key? key}) : super(key: key);

  final NavBarController navBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
      builder: (context) {
        return Scaffold(
          body: IndexedStack(
            index: navBarController.tabIndex,
            children: [
              HomeView(),
              MusicsView(),
              VideosView(),
              SettingsView(),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.music_note,
                    text: 'Musics',
                  ),
                  GButton(
                    icon: Icons.play_circle_fill_outlined,
                    text: 'videos',
                  ),
                  GButton(
                    icon: Icons.settings,
                    text: 'settings',
                  ),
                ],
                selectedIndex: navBarController.tabIndex,
                onTabChange: (index) {
                  navBarController.changeTabIndex(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

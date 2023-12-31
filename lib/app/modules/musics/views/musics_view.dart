import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/home/controllers/nav_bar_controller_controller.dart';
import 'package:mv_player/app/modules/musics/views/favourites_view.dart';
import 'package:mv_player/app/modules/musics/views/mini_player_view.dart';
import 'package:mv_player/app/modules/musics/views/playlists_view.dart';
import 'package:mv_player/app/modules/musics/views/tracks_view.dart';

import '../controllers/tracks_controller.dart';

// ignore: must_be_immutable
class MusicsView extends StatelessWidget {
  MusicsView({Key? key}) : super(key: key);

  final TracksController tracksController = Get.find();
  final NavBarController navBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: GetBuilder<NavBarController>(builder: (controller) {
          return Scaffold(
            // backgroundColor: Colors.white,
            appBar: AppBar(
              // backgroundColor: Colors.white,
              title: const Text(
                'Musics',
                style: TextStyle(
                    // color: Colors.black,
                    ),
              ),
              bottom: TabBar(
                // dividerColor: Colors.black,
                tabs: [
                  Tab(
                    child: Text(
                      'Tracks',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Playlists',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Favourites',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: [
                TracksView(),
                PlaylistsView(),
                const FavouritesView(),
              ],
            ),

            persistentFooterButtons: const [MiniPlayerView()],
          );
        }),
      ),
    );
  }
}

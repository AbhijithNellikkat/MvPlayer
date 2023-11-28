import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text(
                'Music',
                style: TextStyle(color: Colors.black),
              ),
              // actions: [
              //   const SizedBox(height: 20),
              //   Padding(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 20,
              //     ),
              //     child: AnimSearchBar(
              //       rtl: true,
              //       onSubmitted: (p0) {},
              //       width: 300,
              //       textController: textController,
              //       onSuffixTap: () {},
              //     ),
              //   ),
              // ],
              // actions: [
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: PopupMenuButton(
              //       itemBuilder: (context) {
              //         return [
              //           PopupMenuItem(
              //             child: TextButton(
              //               onPressed: () {
              //                 tracksController.changeSortOption(
              //                   SortOption.byTitle,
              //                 );
              //                 Get.back();
              //               },
              //               child: const Text('Sort by Title'),
              //             ),
              //           ),
              //           PopupMenuItem(
              //             child: TextButton(
              //               onPressed: () {
              //                 tracksController.changeSortOption(
              //                   SortOption.byArtist,
              //                 );
              //                 Get.back();
              //               },
              //               child: const Text('Sort by Artist'),
              //             ),
              //           ),
              //           PopupMenuItem(
              //             child: TextButton(
              //               onPressed: () {
              //                 tracksController.changeSortOption(
              //                   SortOption.byDuration,
              //                 );
              //                 Get.back();
              //               },
              //               child: const Text('Sort by Duration'),
              //             ),
              //           ),
              //         ];
              //       },
              //     ),
              //   )
              // ],
              bottom: const TabBar(
                dividerColor: Colors.black,
                tabs: [
                  Tab(
                    child: Text(
                      'Tracks',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Playlists',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Favourites',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: [
                TracksView(),
                PlaylistsView(),
                FavouritesView(),
              ],
            ),

            persistentFooterButtons: [MiniPlayerView()],
            // persistentFooterAlignment: AlignmentDirectional.topCenter,
          );
        }),
      ),
    );
  }
}

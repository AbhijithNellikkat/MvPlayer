import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/modules/musics/controllers/musics_controller.dart';
import 'package:mv_player/app/modules/musics/views/favourites_view.dart';
import 'package:mv_player/app/modules/musics/views/playlists_view.dart';
import 'package:mv_player/app/modules/musics/views/tracks_view.dart';

import '../widgets/loading_widget.dart';

// ignore: must_be_immutable
class MusicsView extends GetView<MusicsController> {
  MusicsView({Key? key}) : super(key: key);

  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'Music',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: AnimSearchBar(
                  rtl: true,
                  onSubmitted: (p0) {},
                  width: 300,
                  textController: textController,
                  onSuffixTap: () {},
                ),
              ),
            ],
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
                    'Favourties',
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
              const FavouritesView(),
            ],
          ),
        ),
      ),
    );
  }
}

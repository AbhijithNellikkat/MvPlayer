import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/modules/musics/views/tracks_view.dart';

import '../controllers/musics_controller.dart';

class MusicsView extends GetView<MusicsController> {
  const MusicsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'Music',
              style: TextStyle(color: Colors.black),
            ),
            bottom: const TabBar(
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
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              TracksView(),
              Center(
                child: Text("Playlists"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

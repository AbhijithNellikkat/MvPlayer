import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/modules/musics/controllers/playlist_controller.dart';
import 'package:mv_player/app/modules/musics/controllers/tracks_controller.dart';

// ignore: must_be_immutable
class PlaylistsView extends StatelessWidget {
  PlaylistsView({Key? key}) : super(key: key);

  final PlaylistController playlistController = Get.find();

  final TracksController tracksController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile();
          },
        ));
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/modules/musics/controllers/playlist_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistView extends StatefulWidget {
  PlaylistView({
    Key? key,
    required this.playlistModel,
    required this.index,
  }) : super(key: key);

  PlaylistModel playlistModel;
  int index;

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  final PlaylistController playlistController = Get.find();

  @override
  void initState() {
    playlistController.loadPlaylistSongs(playlistId: widget.playlistModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<PlaylistController>(builder: (context) {
        return FutureBuilder<List<SongModel>>(
          future: playlistController.getPlaylistSongs(
            widget.playlistModel.id,
          ),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    snapshot.data![index].title,
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}

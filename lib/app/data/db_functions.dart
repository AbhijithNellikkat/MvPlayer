import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mv_player/app/data/models/models.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';

class DbFunctions {
  var box = Hive.box(Constants.boxName);

  Future<void> createPlaylist({
    required String playlistName,
    required List<SongModel> songs,
  }) async {
    var data = MusicModel(playlist: {playlistName: songs}, favourties: []);
    log('$data');
    await box.put(playlistName, data); 
    log('songs : ${box.get(playlistName)}');
  }

  Future<void> deletePlaylist(String playlistName) async {
    await box.delete(playlistName);
    log("Deleting playlist: $playlistName");
  }

  Future<void> addSongToPlaylist({
    required String playlistName,
    required SongModel song,
  }) async {
    var existingData = box.get(playlistName);

    if (existingData != null) {
      if (!existingData.playlist[playlistName]!.contains(song)) {
        existingData.playlist[playlistName]?.add(song);

        await box.put(playlistName, existingData);
      } else {
        Get.snackbar(
            'Duplicate Song', '${song.title} is already in the playlist');
        log('Song is already in the playlist: ${song.title}');
      }
    }
  }

  Future<List<SongModel>> getPlaylist(String playlistName) async {
    MusicModel? playlist = box.get(playlistName);

    if (playlist != null) {
      List<SongModel> songs = [];

      for (var songId in playlist.playlist[playlistName]!) {
        SongModel? song = songId;
        songs.add(song);
      }

      return songs;
    }

    return [];
  }

  Future<List<String>> getPlaylistNames() async {
    List<String> playlistNames = [];

    for (int i = 0; i < box.length; i++) {
      MusicModel value = box.getAt(i);
      playlistNames.addAll(value.playlist.keys);
    }

    return playlistNames;
  }
}

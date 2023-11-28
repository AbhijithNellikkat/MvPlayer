import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mv_player/app/data/models/models.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';

class DbFunctions {
  var box = Hive.box(Constants.boxName);

// ======================================================================================

  Future<void> createPlaylist({
    required String playlistName,
    required List<SongModel> songs,
  }) async {
    var data = MusicModel(
        playlist: {playlistName: songs}, favourites: [], recentlyPlayed: []);
    log('$data');
    await box.put(playlistName, data);
    log('songs : ${box.get(playlistName)}');
  }

  // ======================================================================================

  Future<void> deletePlaylist(String playlistName) async {
    await box.delete(playlistName);
    log("Deleting playlist: $playlistName");
  }

// ======================================================================================

  Future<void> renamePlaylist({
    required String oldPlaylistName,
    required String newPlaylistName,
  }) async {
    var existingData = box.get(oldPlaylistName);

    if (existingData != null) {
      // Create a new playlist with the new name and copy the songs
      var newData = MusicModel(
          playlist: {newPlaylistName: existingData.playlist[oldPlaylistName]!},
          favourites: existingData.favourites,
          recentlyPlayed: []);

      // Put the new playlist in the box
      await box.put(newPlaylistName, newData);

      // Delete the old playlist
      await box.delete(oldPlaylistName);

      log('Playlist renamed: $oldPlaylistName to $newPlaylistName');
    }
  }

// ======================================================================================

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

  // ======================================================================================

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

// ======================================================================================
  Future<List<String>> getPlaylistNames() async {
    List<String> playlistNames = [];

    for (int i = 0; i < box.length; i++) {
      MusicModel value = box.getAt(i);
      playlistNames.addAll(value.playlist.keys);
    }

    return playlistNames;
  }

  // ======================================================================================

  Future<void> deleteSongFromPlaylist({
    required String playlistName,
    required SongModel song,
  }) async {
    var existingData = box.get(playlistName);

    if (existingData != null) {
      existingData.playlist[playlistName]?.remove(song);

      await box.put(playlistName, existingData);
      log('Song deleted from playlist: ${song.title} ');
    }
  }

  // ===================================================================================

  Future<void> addRecentlyPlayedSong({required SongModel song}) async {
    var musicModel = box.get(Constants.boxName,
        defaultValue: MusicModel(
          playlist: {},
          favourites: [],
          recentlyPlayed: [],
        ));

    // Add the song to the recently played list
    musicModel.recentlyPlayed.insert(0, song);

    // Limit the recently played list to 10 songs
    if (musicModel.recentlyPlayed.length > 10) {
      musicModel.recentlyPlayed.removeLast();
    }

    await box.put(Constants.boxName, musicModel);
  }

  Future<List<SongModel>> getRecentlyPlayed() async {
    MusicModel? musicModel = box.get(Constants.boxName);

    if (musicModel != null) {
      return List<SongModel>.from(musicModel.recentlyPlayed);
    } else {
      return [];
    }
  }
}

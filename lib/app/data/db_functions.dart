import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mv_player/app/data/models/models.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';

class DbFunctions {
  var box = Hive.box(Constants.boxName);
  List<SongModel> favouritesSongs = [];

  // Initialize favouritesNotifier with an empty list
  final favouritesNotifier = ValueNotifier<List<SongModel>>([]);

// ======================================================================================

  Future<void> createPlaylist({
    required String playlistName,
    required List<SongModel> songs,
  }) async {
    var data = MusicModel(playlist: {playlistName: songs}, favourites: []);
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
      );

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

  Future<void> addToFavourites({required SongModel song}) async {
    log('Fav song : ${song.title}');

    favouritesSongs.add(song);

    var data = MusicModel(playlist: {}, favourites: favouritesSongs);
    box.put('favSong', data);

    // Update the ValueNotifier
    favouritesNotifier.value = List.from(favouritesSongs);
  }

  

  Future<void> removeFromFavourites({required SongModel song}) async {
    favouritesSongs.remove(song);

    var data = MusicModel(playlist: {}, favourites: favouritesSongs);
    box.put('favSong', data);

    // Update the ValueNotifier
    favouritesNotifier.value = List.from(favouritesSongs);
  }
}

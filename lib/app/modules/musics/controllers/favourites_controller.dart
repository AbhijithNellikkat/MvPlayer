import 'dart:developer';

import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../data/db_functions.dart';
import '../../../data/models/models.dart';

class FavouritesController extends GetxController {
  final DbFunctions dbFunctions = DbFunctions();

  // Add a song to favorites
  Future<void> addSongToFavourites(SongModel song) async {
    var existingData = dbFunctions.box.get('favourites',
        defaultValue: MusicModel(
          playlist: {},
          favourites: [],
          recentlyPlayed: [],
        ));

    if (!existingData.favourites.contains(song)) {
      existingData.favourites.add(song);

      await dbFunctions.box.put('favourites', existingData);

      log('Song added to favorites: ${song.title}');
    } else {
      log('Song is already in favorites: ${song.title}');
    }
  }

  // Get the list of favorite songs
  List<SongModel> getFavoriteSongs() {
    var favData = dbFunctions.box.get('favourites',
        defaultValue: MusicModel(
          playlist: {},
          favourites: [],
          recentlyPlayed: [],
        ));

    return favData.favourites;
  }

  // Remove a song from favorites
  Future<void> removeSongFromFavorites(SongModel song) async {
    var favData = dbFunctions.box.get(
      'favourites',
      defaultValue: MusicModel(
        playlist: {},
        favourites: [],
        recentlyPlayed: [],
      ),
    );

    favData.favourites.remove(song);

    dbFunctions.box.put(
      'favourites',
      favData,
    );
    update(); 
  }
}

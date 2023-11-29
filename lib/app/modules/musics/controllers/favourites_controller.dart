import 'dart:developer';

import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../data/db_functions.dart';
import '../../../data/models/models.dart';

class FavouritesController extends GetxController {
  final DbFunctions dbFunctions = DbFunctions();

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

  List<SongModel> getFavoriteSongs() {
    var favData = dbFunctions.box.get('favourites',
        defaultValue: MusicModel(
          playlist: {},
          favourites: [],
          recentlyPlayed: [],
        ));

    return favData.favourites;
  }

  Future<void> removeSongFromFavorites(SongModel song) async {
    var favData = dbFunctions.box.get(
      'favourites',
      defaultValue: MusicModel(
        playlist: {},
        favourites: [],
        recentlyPlayed: [],
      ),
    );

    favData.favourites.remove(song); // Corrected spelling here

    dbFunctions.box.put(
      'favourites',
      favData,
    );
    update();
  }

  
}

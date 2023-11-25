import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../data/models/models.dart';
import '../../../utils/constants/constants.dart';

class FavouritesController extends GetxController {
  late Box<MusicModel> box;
  late ValueNotifier<List<SongModel>> favouritesNotifier;

  @override
  void onInit() {
    super.onInit();
    box = Hive.box<MusicModel>(Constants.boxName);
    favouritesNotifier = ValueNotifier<List<SongModel>>([]);
    updateFavourites();
  }

  void updateFavourites() {
    var favouritesData = box.get('favSong');
    if (favouritesData != null) {
      favouritesNotifier.value = List.from(favouritesData.favourites);
    }
  }

  Future<void> addToFavourites({required SongModel song}) async {
    favouritesNotifier.value = [...favouritesNotifier.value, song];

    var data = MusicModel(playlist: {}, favourites: favouritesNotifier.value);
    await box.put('favSong', data);
  }

  Future<void> removeFromFavourites({required SongModel song}) async {
    favouritesNotifier.value =
        favouritesNotifier.value.where((s) => s.id != song.id).toList();

    var data = MusicModel(playlist: {}, favourites: favouritesNotifier.value);
    await box.put('favSong', data);
  }
}

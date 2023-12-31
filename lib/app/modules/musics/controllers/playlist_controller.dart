import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../data/db_functions.dart';

class PlaylistController extends GetxController {
  final OnAudioQuery audioquery = OnAudioQuery();

  // List to store the current playlist
  List<SongModel> allSongs = [];

  // Audio queue for the current playlist
  late ConcatenatingAudioSource currentQueue;

  final DbFunctions dbFunctions = DbFunctions();

  final RxList<SongModel> playlist = <SongModel>[].obs;

  ConcatenatingAudioSource playthesong({required List<SongModel> songs}) {
    allSongs.clear();
    allSongs = [...songs];
    List<AudioSource> sources = [];
    for (var song in songs) {
      sources.add(
        AudioSource.uri(
          Uri.parse(song.uri!),
          tag: MediaItem(
            id: '${song.id}',
            title: song.title,
            displaySubtitle: song.displayNameWOExt,
          ),
        ),
      );
    }
    currentQueue = ConcatenatingAudioSource(children: sources);
    return ConcatenatingAudioSource(children: sources);
  }

  Future<void> refreshTheApp() async {
    update();
  }

  Future<void> fetchAndSetPlaylist(String playlistName) async {
    List<SongModel> fetchedPlaylist =
        await dbFunctions.getPlaylist(playlistName);
    playlist.assignAll(fetchedPlaylist);
  }
}

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistController extends GetxController {
  final OnAudioQuery audioquery = OnAudioQuery();

  // List to store the current playlist
  List<SongModel> currentPlaylist = [];

  // Audio queue for the current playlist
  late ConcatenatingAudioSource currentQueue;

  createNewPlaylist({required playlistname}) {
    audioquery.createPlaylist(playlistname);
    update();
  }

  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    currentPlaylist.clear();
    currentPlaylist = [...songs];
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

  loadPlaylistSongs({required PlaylistModel playlistId}) async {
    var path = playlistId.getMap.entries;
    return await audioquery.queryAudiosFrom(AudiosFromType.PLAYLIST, path);
  }

  Future<void> addSongToPlaylist(int playlistId, int songId) async {
    await audioquery.addToPlaylist(playlistId, songId);
    update();
  }

  Future<List<SongModel>> getPlaylistSongs(
    int playlistId, {
    SongSortType? sortType,
    OrderType? orderType,
    String? path,
  }) async {
    return audioquery.queryAudiosFrom(
      AudiosFromType.PLAYLIST,
      playlistId,
      sortType: sortType ?? SongSortType.DATE_ADDED,
      orderType: orderType ?? OrderType.DESC_OR_GREATER,
    );
  }
}

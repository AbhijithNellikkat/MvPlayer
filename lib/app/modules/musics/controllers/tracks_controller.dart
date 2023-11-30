import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class TracksController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();

  // List to hold all songs
  RxList<SongModel> allSongs = <SongModel>[].obs;

  // List to hold filtered/searched songs
  RxList<SongModel> displayedSongs = <SongModel>[].obs;

  // List to hold all albums
  RxList<AlbumModel> allAlbums = <AlbumModel>[].obs;

  @override
  void onInit() {
    // Fetch all songs when the controller is initialized
    fetchAllSongs();
    fetchAlbums();
    super.onInit();
  }

  // Method to fetch all songs from the device
  fetchAllSongs() async {
    allSongs.value = await audioQuery.querySongs(
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    // Initially, set displayedSongs to be the same as allSongs
    displayedSongs.value = List.from(allSongs);
  }

  // Method to fetch all albums from the device
  fetchAlbums() async {
    allAlbums.value = await audioQuery.queryAlbums(
        sortType: AlbumSortType.ARTIST,
        ignoreCase: true,
        orderType: OrderType.DESC_OR_GREATER,
        uriType: UriType.EXTERNAL);
  }

  // Method to filter songs based on the search query
  filterSongs(String query) {
    // If the query is empty, show all songs
    if (query.isEmpty) {
      displayedSongs.value = List.from(allSongs);
    } else {
      // Filter songs based on the query
      displayedSongs.value = allSongs
          .where((song) =>
              song.title.toLowerCase().contains(query.toLowerCase()) ||
              song.artist!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}

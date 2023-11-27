import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class TracksController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();

  // List to hold all songs
  RxList<SongModel> allSongs = <SongModel>[].obs;

  // List to hold filtered/searched songs
  RxList<SongModel> displayedSongs = <SongModel>[].obs;

  @override
  void onInit() {
    // Fetch all songs when the controller is initialized
    fetchAllSongs();
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

















// ignore_for_file: invalid_use_of_protected_member

// import 'package:get/get.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// // Enum to define sorting options
// enum SortOption { byTitle, byArtist, byDuration }

// class TracksController extends GetxController {
//   final OnAudioQuery audioQuery = OnAudioQuery();

//   // List to hold all songs
//   RxList<SongModel> allSongs = <SongModel>[].obs;

//   // List to hold filtered/searched songs
//   RxList<SongModel> displayedSongs = <SongModel>[].obs;

//   late String query;

//   // Sorting option, initially set to sort by title
//   SortOption sortOption = SortOption.byTitle;

//   @override
//   void onInit() {
//     // Fetch all songs when the controller is initialized
//     fetchAllSongs();
//     super.onInit();
//   }

//   // Method to fetch all songs from the device
//   fetchAllSongs() async {
//     allSongs.value = await audioQuery.querySongs(
//       sortType: SongSortType.DISPLAY_NAME,
//       orderType: OrderType.ASC_OR_SMALLER,
//       uriType: UriType.EXTERNAL,
//       ignoreCase: true,
//     );
//     // Initially, set displayedSongs to be the same as allSongs
//     displayedSongs.value = List.from(allSongs);

//     // Sort the songs based on the initial sorting option
//     sortSongs();
//   }

//   // Method to filter songs based on the search query
//   filterSongs(String query) {
//     // If the query is empty, show all songs
//     if (query.isEmpty) {
//       displayedSongs.value = List.from(allSongs);
//     } else {
//       // Filter songs based on the query
//       displayedSongs.value = allSongs
//           .where((song) =>
//               song.title.toLowerCase().contains(query.toLowerCase()) ||
//               song.artist!.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//     // After filtering, reapply sorting
//     sortSongs();
//   }

//   // Method to sort songs based on the selected option
//   sortSongs() {
//     switch (sortOption) {
//       case SortOption.byTitle:
//         displayedSongs.value.sort((a, b) => a.title.compareTo(b.title));
//         break;
//       case SortOption.byArtist:
//         displayedSongs.value.sort((a, b) => a.artist!.compareTo(b.artist!));
//         break;
//       case SortOption.byDuration:
//         displayedSongs.value
//             .sort((a, b) => a.duration!.compareTo(b.duration as num));
//         break;
//     }
//   }

//   // Method to change the sorting option
//   changeSortOption(SortOption option) {
//     sortOption = option;
//     // After changing the sorting option, reapply sorting
//     sortSongs();
//   }
// }

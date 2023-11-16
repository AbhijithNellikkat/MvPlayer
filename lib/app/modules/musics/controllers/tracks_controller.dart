import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';


class TracksController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();   
  


  // Method to fetch all songs from the device
  fetchAllSongs() {
    return audioQuery.querySongs(
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  }
  
}

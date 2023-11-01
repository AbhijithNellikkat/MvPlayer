import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';


class TracksController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();


  fetchAllSongs() {
    return audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  }

 
}

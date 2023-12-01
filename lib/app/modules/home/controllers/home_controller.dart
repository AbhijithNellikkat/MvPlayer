import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();

  RxList<ArtistModel> allArtists = <ArtistModel>[].obs;

  @override
  void onInit() {
    fetchArtists();
    super.onInit();
  }

  // Method to fetch all artists from the device
  fetchArtists() async {
    allArtists.value = await audioQuery.queryArtists(
        sortType: ArtistSortType.ARTIST,
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL);
  }
}

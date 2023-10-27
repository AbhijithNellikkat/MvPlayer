// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/modules/musics/controllers/all_musics_player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/styles/text_styles.dart';

class TracksView extends StatelessWidget {
  TracksView({Key? key}) : super(key: key);

  final AllMusicsPlayerController allMusicsPlayerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Tracks"),)
    );
  }
}

Widget songsListView({required AllMusicsPlayerController controller}) {
  return FutureBuilder<List<SongModel>>(
    future: controller.audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        uriType: UriType.EXTERNAL),
    builder: (context, snapshot) {
      if (snapshot.data == null) {
        return const Center(
          child: CircularProgressIndicator(color: Constants.black),
        );
      } else if (snapshot.data!.isEmpty) {
        const Center(
          child: Text(
            "No songs Found",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.red),
          ),
        );
      }
      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: ListTile(
              onTap: () {
                controller.playSong(snapshot.data![index].uri);
              },
              leading: QueryArtworkWidget(
                id: snapshot.data![index].id,
                type: ArtworkType.AUDIO,
                nullArtworkWidget: const Icon(
                  Icons.music_note,
                  color: Constants.black,
                  size: 32,
                ),
              ),
              title: Text(
                snapshot.data![index].displayNameWOExt,
                style: musicsName,
              ),
              subtitle: Text(
                '${snapshot.data![index].artist}',
                style: const TextStyle(fontSize: 9),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Constants.moreVert),
                color: Colors.black,
              ),
            ),
          );
        },
      );
    },
  );
}

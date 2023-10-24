import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/modules/musics/controllers/all_musics_player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/styles/text_styles.dart';

class TracksView extends StatelessWidget {
  TracksView({Key? key}) : super(key: key);

  final AllMusicsPlayerController allMusicsPlayerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<SongModel>>(
        future: allMusicsPlayerController.audioQuery.querySongs(
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
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.red),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.MUSICPLAYER);
                  },
                  child: ListTile(
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
                    trailing: const Icon(
                      Constants.moreVert,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

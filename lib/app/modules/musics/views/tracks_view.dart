import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/modules/musics/controllers/tracks_controller.dart';
import 'package:mv_player/app/modules/nowPlaying/views/now_playing_view.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/styles/text_styles.dart';

class TracksView extends StatelessWidget {
  TracksView({Key? key}) : super(key: key);

  final TracksController tracksController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<SongModel>>(
        future: tracksController.fetchAllSongs(),
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
          return ListView.separated(
            separatorBuilder: (context, index) =>
                const Divider(color: Colors.transparent),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: QueryArtworkWidget(
                  id: snapshot.data![index].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const Icon(
                    Constants.music,
                    color: Constants.black,
                    size: 32,
                  ),
                ),
                title: Text(
                  snapshot.data![index].displayNameWOExt,
                  style: musicListTitleStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  snapshot.data![index].artist! == "<unknown>"
                      ? "Unknown Artist"
                      : snapshot.data![index].artist!,
                  style: musicArtistStyle,
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Constants.moreVert),
                  color: Colors.black,
                ),
                onTap: () {
                  Get.to(
                    transition: Transition.fade,
                    NowPlayingView(
                      
                      songModel: snapshot.data![index],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

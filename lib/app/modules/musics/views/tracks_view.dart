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
          List<SongModel> songs = snapshot.data!;
          return ListView.separated(
            separatorBuilder: (context, index) =>
                const Divider(color: Colors.transparent),
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: QueryArtworkWidget(
                  artworkFit: BoxFit.cover,
                  artworkQuality: FilterQuality.high,
                  artworkBorder: const BorderRadius.all(Radius.circular(15)),
                  artworkHeight: 130,
                  artworkWidth: 60,
                  id: snapshot.data![index].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: Container(
                    width: 60,
                    height: 130,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: const Icon(
                      Constants.music,
                      color: Constants.white,
                    ),
                  ),
                ),
                title: Text(
                  songs.elementAt(index).displayNameWOExt,
                  style: musicListTitleStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  songs.elementAt(index).artist == "<unknown>"
                      ? "Unknown Artist"
                      : '${songs.elementAt(index).artist}',
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
                      index: index,
                      songModel: songs.elementAt(index),
                    ),
                  );
                  tracksController.playSong(
                      index: index, uri: '${songs.elementAt(index).uri}');
                },
              );
            },
          );
        },
      ),
    );
  }
}

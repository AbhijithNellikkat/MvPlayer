import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/musics/controllers/tracks_controller.dart';
import 'package:mv_player/app/modules/musics/views/music_player_view.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/styles/text_styles.dart';
import '../controllers/music_player_controller.dart';

class TracksView extends StatelessWidget {
  TracksView({Key? key}) : super(key: key);

  final TracksController tracksController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldBgColor,
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
          MusicPlayerController.allSongs = [...snapshot.data!];
          return ListView.separated(
            separatorBuilder: (context, index) =>
                const Divider(color: Colors.transparent),
            itemCount: snapshot.data!.length,
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
                      color: Constants.black,
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
                  snapshot.data![index].title,
                  style: musicListTitleStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  snapshot.data![index].artist == "<unknown>"
                      ? "Unknown Artist"
                      : '${snapshot.data![index].artist}',
                  style: musicArtistStyle,
                ),
                trailing: PopupMenuButton(
                  elevation: 1,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Add to favorites",
                              style: GoogleFonts.poppins(),
                            )),
                      ),
                      PopupMenuItem(
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Add to Playlist",
                              style: GoogleFonts.poppins(),
                            )),
                      ),
                      PopupMenuItem(
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Delete from device",
                              style: GoogleFonts.poppins(),
                            )),
                      ),
                      PopupMenuItem(
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Rename",
                              style: GoogleFonts.poppins(),
                            )),
                      ),
                    ];
                  },
                ),
                onTap: () {
                  Get.to(MusicPlayerView(
                    songs: snapshot.data!,
                    index: index,
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }
}

// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/musics/controllers/playlist_controller.dart';
import 'package:mv_player/app/modules/musics/controllers/tracks_controller.dart';
import 'package:mv_player/app/modules/musics/views/music_player_view.dart';
import 'package:mv_player/app/modules/musics/views/playlist_view.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/styles/text_styles.dart';
import '../controllers/music_player_controller.dart';
import '../widgets/playlist_add_bottmSheet.dart';

// ignore: must_be_immutable
class PlaylistsView extends StatelessWidget {
  PlaylistsView({Key? key}) : super(key: key);

  final PlaylistController playlistController = Get.find();
  final TextEditingController playlistEditingController =
      TextEditingController();

  late int playlistId;
  late var songModel;

  final TracksController tracksController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<PlaylistController>(builder: (context) {
        return FutureBuilder(
          future: playlistController.audioquery.queryPlaylists(
            sortType: PlaylistSortType.DATE_ADDED,
            orderType: OrderType.DESC_OR_GREATER,
            ignoreCase: true,
          ),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(50.0),
                child: Center(
                  child: Text(
                    "No Playlists Found",
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                playlistId = snapshot.data![index].id;

                return ListTile(
                  onLongPress: () {
                    showAboutDialog(context: context, children: [
                      TextButton(
                          onPressed: () {
                            playlistController.audioquery
                                .removePlaylist(playlistId);
                            Get.back();
                          },
                          child: const Text('Delete'))
                    ]);
                  },
                  onTap: () {
                    Get.to(
                      PlaylistView(
                          playlistModel: snapshot.data![index], index: index),
                    );
                  },
                  title: Text(snapshot.data![index].playlist),
                  subtitle: Text('${snapshot.data![index].numOfSongs} songs'),
                  trailing: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            width: 350,
                            height: 400,
                            color: Colors.amber,
                            child: FutureBuilder(
                                future: tracksController.fetchAllSongs(),
                                builder: (context, snapshot) {
                                  if (MusicPlayerController.allSongs.isEmpty ==
                                      null) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                          color: Constants.black),
                                    );
                                  } else if (MusicPlayerController
                                      .allSongs.isEmpty) {
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
                                        const Divider(
                                            color: Colors.transparent),
                                    itemCount:
                                        MusicPlayerController.allSongs.length,
                                    itemBuilder: (context, index) {
                                      songModel = snapshot.data;
                                      return ListTile(
                                        leading: QueryArtworkWidget(
                                          artworkFit: BoxFit.cover,
                                          artworkQuality: FilterQuality.high,
                                          artworkBorder: const BorderRadius.all(
                                              Radius.circular(15)),
                                          artworkHeight: 130,
                                          artworkWidth: 60,
                                          id: MusicPlayerController
                                              .allSongs[index].id,
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
                                          MusicPlayerController
                                              .allSongs[index].title,
                                          style: musicListTitleStyle,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          MusicPlayerController
                                                      .allSongs[index].artist ==
                                                  "<unknown>"
                                              ? "Unknown Artist"
                                              : '${MusicPlayerController.allSongs[index].artist}',
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
                                                      style:
                                                          GoogleFonts.poppins(),
                                                    )),
                                              ),
                                              PopupMenuItem(
                                                child: TextButton(
                                                    onPressed: () {
                                                      playlistController
                                                          .addSongToPlaylist(
                                                              playlistId,
                                                              MusicPlayerController
                                                                  .allSongs[
                                                                      index]
                                                                  .id);
                                                    },
                                                    child: Text(
                                                      "Add to Playlist",
                                                      style:
                                                          GoogleFonts.poppins(),
                                                    )),
                                              ),
                                              PopupMenuItem(
                                                child: TextButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      "Delete from device",
                                                      style:
                                                          GoogleFonts.poppins(),
                                                    )),
                                              ),
                                              PopupMenuItem(
                                                child: TextButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      "Rename",
                                                      style:
                                                          GoogleFonts.poppins(),
                                                    )),
                                              ),
                                            ];
                                          },
                                        ),
                                        onTap: () {
                                          Get.to(MusicPlayerView(
                                              songs: MusicPlayerController
                                                  .allSongs,
                                              index: index));
                                        },
                                      );
                                    },
                                  );
                                }),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.more_vert_rounded),
                  ),
                );
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () {
          playlistAddBottmSheet(context, playlistEditingController);
        },
        label: const Text(
          'New playlist',
        ),
      ),
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mv_player/app/utils/constants/constants.dart';

// import '../widgets/playlist_add_bottmSheet.dart';

// class PlaylistsView extends GetView {
//   PlaylistsView({Key? key}) : super(key: key);

//   final TextEditingController playlistController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView(
//           children: [
//             const SizedBox(height: 20),
//             ListTile(
//               leading: const CircleAvatar(
//                 maxRadius: 30,
//                 backgroundColor: Colors.black,
//                 child: Icon(
//                   Icons.music_note_sharp,
//                   color: Constants.white,
//                 ),
//               ),
//               title: const Text('Malayalam songs'),
//               subtitle: Text(
//                 '209 songs',
//                 style: GoogleFonts.poppins(fontSize: 12),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ListTile(
//               leading: const CircleAvatar(
//                 maxRadius: 30,
//                 backgroundColor: Colors.black,
//                 child: Icon(
//                   Icons.music_note_sharp,
//                   color: Constants.white,
//                 ),
//               ),
//               title: const Text('English songs'),
//               subtitle: Text(
//                 '119 songs',
//                 style: GoogleFonts.poppins(fontSize: 12),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//           backgroundColor: Colors.black,
//           onPressed: () {
//             playlistAddBottmSheet(context, playlistController);
//           },
//           label: const Text(
//             'New playlist',
//             style: TextStyle(color: Constants.white),
//           )),
//     );
//   }
// }

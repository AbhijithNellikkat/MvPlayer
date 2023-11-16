// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_player/app/modules/musics/controllers/playlist_controller.dart';
import 'package:mv_player/app/modules/musics/controllers/tracks_controller.dart';
import 'package:mv_player/app/modules/musics/views/playlist_view.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/constants/constants.dart';
import '../widgets/playlist_add_bottmSheet.dart';

// ignore: must_be_immutable
class PlaylistsView extends StatelessWidget {
  PlaylistsView({Key? key}) : super(key: key);

  final PlaylistController playlistController = Get.find();
  final TextEditingController playlistEditingController =
      TextEditingController();

  late int playlistId;
  // ignore: prefer_typing_uninitialized_variables
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(Constants.emptyBoxAnimation),
                  ),
                  Text(
                    'No playlists here.',
                    style: GoogleFonts.poppins(fontSize: 11),
                  )
                ],
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                playlistId = snapshot.data![index].id;
                log('------------------- Playlist ID : $playlistId -------------------');
                log('----------------------------------------------------------------');
                return ListTile(
                  leading: Container(
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
                  onLongPress: () {
              
                    showAboutDialog(
                      context: context,
                      children: [
                        TextButton(
                          onPressed: () {
                            playlistController.removePlaylist(
                                playlistId: playlistId);
                            Get.back();
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                  onTap: () {
                    Get.to(
                      PlaylistView(
                          playlistModel: snapshot.data![index], index: index),
                    );
                    log('${snapshot.data![index]}');
                  },
                  title: Text(snapshot.data![index].playlist),
                  subtitle: Text('${snapshot.data![index].numOfSongs} songs'),
                  // trailing: IconButton(
                  //   onPressed: () {
                  //     Get.bottomSheet(
                  //         backgroundColor: Constants.black,
                  //         shape: const RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.only(
                  //           topLeft: Radius.circular(20),
                  //           topRight: Radius.circular(20),
                  //         )),
                  //         enableDrag: true,
                  //         Container(
                  //           width: 350,
                  //           height: 400,
                  //           padding: const EdgeInsets.only(top: 20),
                  //           decoration: const BoxDecoration(
                  //               borderRadius: BorderRadius.only(
                  //                   topLeft: Radius.circular(22),
                  //                   topRight: Radius.circular(22))),
                  //           child: FutureBuilder<List<SongModel>>(
                  //               future: tracksController.fetchAllSongs(),
                  //               builder: (context, snapshot) {
                  //                 if (MusicPlayerController.allSongs.isEmpty ==
                  //                     null) {
                  //                   return const Center(
                  //                     child: CircularProgressIndicator(
                  //                         color: Constants.black),
                  //                   );
                  //                 } else if (MusicPlayerController
                  //                     .allSongs.isEmpty) {
                  //                   Column(
                  //                     children: [
                  //                       Center(
                  //                         child: Lottie.asset(
                  //                             Constants.emptyBoxAnimation),
                  //                       ),
                  //                       Text(
                  //                         'No songs here.',
                  //                         style:
                  //                             GoogleFonts.poppins(fontSize: 11),
                  //                       )
                  //                     ],
                  //                   );
                  //                 }

                  //                 return ListView.separated(
                  //                   separatorBuilder: (context, index) =>
                  //                       const Divider(
                  //                           color: Colors.transparent),
                  //                   itemCount:
                  //                       MusicPlayerController.allSongs.length,
                  //                   itemBuilder: (context, index) {
                  //                     songModel = snapshot.data;
                  //                     return ListTile(
                  //                       leading: QueryArtworkWidget(
                  //                         artworkFit: BoxFit.cover,
                  //                         artworkQuality: FilterQuality.high,
                  //                         artworkBorder: const BorderRadius.all(
                  //                             Radius.circular(15)),
                  //                         artworkHeight: 130,
                  //                         artworkWidth: 60,
                  //                         id: MusicPlayerController
                  //                             .allSongs[index].id,
                  //                         type: ArtworkType.AUDIO,
                  //                         nullArtworkWidget: Container(
                  //                           width: 60,
                  //                           height: 130,
                  //                           decoration: const BoxDecoration(
                  //                             color: Constants.white,
                  //                             borderRadius: BorderRadius.all(
                  //                               Radius.circular(15),
                  //                             ),
                  //                           ),
                  //                           child: const Icon(
                  //                             Constants.music,
                  //                             color: Constants.black,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       title: Text(
                  //                         MusicPlayerController
                  //                             .allSongs[index].title,
                  //                         style: GoogleFonts.poppins(
                  //                             color: Constants.white,
                  //                             fontWeight: FontWeight.bold,
                  //                             fontSize: 13),
                  //                         maxLines: 1,
                  //                         overflow: TextOverflow.ellipsis,
                  //                       ),
                  //                       subtitle: Text(
                  //                         MusicPlayerController
                  //                                     .allSongs[index].artist ==
                  //                                 "<unknown>"
                  //                             ? "Unknown Artist"
                  //                             : '${MusicPlayerController.allSongs[index].artist}',
                  //                         style: GoogleFonts.poppins(
                  //                             color: Constants.white,
                  //                             fontSize: 12),
                  //                       ),
                  //                       trailing: PopupMenuButton(
                  //                         color: Constants.white,
                  //                         elevation: 1,
                  //                         itemBuilder: (context) {
                  //                           return [
                  //                             PopupMenuItem(
                  //                               child: TextButton(
                  //                                   onPressed: () {},
                  //                                   child: Text(
                  //                                     "Add to favorites",
                  //                                     style:
                  //                                         GoogleFonts.poppins(),
                  //                                   )),
                  //                             ),
                  //                             PopupMenuItem(
                  //                               child: TextButton(
                  //                                   onPressed: () {
                  //                                     playlistController
                  //                                         .addSongToPlaylist(
                  //                                       playlistId: playlistId,
                  //                                       songId:
                  //                                           MusicPlayerController
                  //                                               .allSongs[index]
                  //                                               .id,
                  //                                     );
                  //                                     Get.back();
                  //                                     log('================== Add Song To Playlist ===============');
                  //                                   },
                  //                                   child: Text(
                  //                                     "Add to Playlist",
                  //                                     style:
                  //                                         GoogleFonts.poppins(),
                  //                                   )),
                  //                             ),
                  //                             PopupMenuItem(
                  //                               child: TextButton(
                  //                                   onPressed: () {},
                  //                                   child: Text(
                  //                                     "Delete from device",
                  //                                     style:
                  //                                         GoogleFonts.poppins(),
                  //                                   )),
                  //                             ),
                  //                             PopupMenuItem(
                  //                               child: TextButton(
                  //                                   onPressed: () {},
                  //                                   child: Text(
                  //                                     "Rename",
                  //                                     style:
                  //                                         GoogleFonts.poppins(),
                  //                                   )),
                  //                             ),
                  //                           ];
                  //                         },
                  //                       ),
                  //                       onTap: () {
                  //                         Get.to(MusicPlayerView(
                  //                             songs: MusicPlayerController
                  //                                 .allSongs,
                  //                             index: index));
                  //                       },
                  //                     );
                  //                   },
                  //                 );
                  //               }),
                  //         ));
                  //   },
                  //   icon: const Icon(Constants.moreVert),
                  // ),
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

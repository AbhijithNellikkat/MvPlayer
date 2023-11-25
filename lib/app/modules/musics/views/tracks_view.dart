import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/data/db_functions.dart';
import 'package:mv_player/app/modules/musics/controllers/tracks_controller.dart';
import 'package:mv_player/app/modules/musics/views/music_player_view.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/styles/text_styles.dart';

class TracksView extends StatelessWidget {
  TracksView({Key? key}) : super(key: key);

  final TracksController tracksController = Get.find();
  final DbFunctions dbFunctions = DbFunctions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldBgColor,
      body: Column(
        children: [
          // UI for displaying favourite songs
          ValueListenableBuilder<List<SongModel>>(
            valueListenable: dbFunctions.favouritesNotifier,
            builder: (context, favourites, _) {
              if (dbFunctions.favouritesSongs.isEmpty) {
                return const SizedBox();
              }
              return Container(
                decoration: const BoxDecoration(
                  color: Constants.black,
                ),
                height: 220, // Adjust height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: favourites.length,
                  itemBuilder: (context, index) {
                    SongModel song = favourites[index];
                    return Container(
                      decoration: const BoxDecoration(
                        color: Constants.black,
                      ),
                      margin: const EdgeInsets.only(left: 15, top: 8, right: 8),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          QueryArtworkWidget(
                            artworkFit: BoxFit.cover,
                            artworkQuality: FilterQuality.high,
                            artworkBorder:
                                const BorderRadius.all(Radius.circular(15)),
                            artworkHeight: 130,
                            artworkWidth: 120,
                            id: song.id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Container(
                              width: 120,
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
                          const SizedBox(height: 8),
                          Text(song.title,
                              style: GoogleFonts.poppins(
                                  fontSize: 10, color: Constants.white)),
                          TextButton(
                              onPressed: () {
                                dbFunctions.removeFromFavourites(song: song);
                              },
                              child: Text(
                                'delete',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.red,
                                ),
                              ))
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          // UI for displaying all songs
          Expanded(
            child: FutureBuilder<List<SongModel>>(
              future: tracksController.fetchAllSongs(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Constants.circularProgressIndicator,
                  );
                } else if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "No songs Found",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.red,
                      ),
                    ),
                  );
                }

                List<SongModel> songs = snapshot.data!;
                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(color: Colors.transparent),
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    SongModel song = songs[index];
                    return ListTile(
                      leading: QueryArtworkWidget(
                        artworkFit: BoxFit.cover,
                        artworkQuality: FilterQuality.high,
                        artworkBorder:
                            const BorderRadius.all(Radius.circular(15)),
                        artworkHeight: 130,
                        artworkWidth: 60,
                        id: song.id,
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
                        song.title,
                        style: musicListTitleStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        song.artist == "<unknown>"
                            ? "Unknown Artist"
                            : '${song.artist}',
                        style: musicArtistStyle,
                      ),
                      trailing: PopupMenuButton(
                        elevation: 1,
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: TextButton(
                                  onPressed: () {
                                    dbFunctions.addToFavourites(song: song);
                                    log('All Fav Songs : ${dbFunctions.favouritesSongs}');
                                    Get.back();
                                  },
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
                        Get.to(
                          MusicPlayerView(
                            songs: snapshot.data!,
                            index: index,
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

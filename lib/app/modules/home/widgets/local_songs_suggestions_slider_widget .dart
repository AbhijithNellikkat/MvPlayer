// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_player/app/modules/musics/views/music_player_view.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/constants/constants.dart';

class LocalSongsSuggestionsSliderWidget extends StatelessWidget {
  const LocalSongsSuggestionsSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: fetchLocalSongs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final List<SongModel> localSongs = snapshot.data ?? [];

        if (localSongs.isNotEmpty) {
          return FutureBuilder<List<SongModel>>(
            future: fetchLocalSongs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final List<SongModel> localSongs = snapshot.data ?? [];

              if (localSongs.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 212,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: localSongs.length,
                        itemBuilder: (context, index) {
                          final song = localSongs[index];

                          return GestureDetector(
                            onTap: () {
                              Get.to(MusicPlayerView(
                                  songs: localSongs, index: index));
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              width: 170,
                              height: 130,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 180,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: QueryArtworkWidget(
                                      quality: 100,
                                      artworkFit: BoxFit.cover,
                                      artworkQuality: FilterQuality.high,
                                      artworkBorder: const BorderRadius.all(
                                          Radius.circular(7)),
                                      type: ArtworkType.AUDIO,
                                      id: song.id,
                                      nullArtworkWidget: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          color: Constants.black,
                                        ),
                                        width: 250,
                                        height: 230,
                                        child: Lottie.asset(
                                            Constants.nullArtworkWidget,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    song.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return SizedBox.shrink(); // No suggestions available
              }
            },
          );
        } else {
          return SizedBox.shrink(); // No suggestions available
        }
      },
    );
  }

  Future<List<SongModel>> fetchLocalSongs() async {
    final OnAudioQuery onAudioQuery = OnAudioQuery();
    return await onAudioQuery.querySongs();
  }
}

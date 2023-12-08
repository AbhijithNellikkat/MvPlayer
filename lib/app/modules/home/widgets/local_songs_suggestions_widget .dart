// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
          return CarouselSlider.builder(
            itemCount: localSongs.length,
            options: CarouselOptions(
              height: 180,
              autoPlay: true,
              viewportFraction: 0.55,
              enlargeCenterPage: true,
              pageSnapping: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(seconds: 2),
            ),
            itemBuilder: (context, itemIndex, pageViewIndex) {
              final song = localSongs[itemIndex];
              return GestureDetector(
                onTap: () {
                  MusicPlayerView(songs: localSongs, index: itemIndex);
                  print('$localSongs');
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 230,
                    width: 180,
                    child: QueryArtworkWidget(
                      quality: 100,
                      artworkFit: BoxFit.cover,
                      artworkQuality: FilterQuality.high,
                      artworkBorder: const BorderRadius.all(Radius.zero),
                      type: ArtworkType.AUDIO,
                      id: song.id,
                      nullArtworkWidget: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Constants.black,
                        ),
                        width: 250,
                        height: 230,
                        child: Lottie.asset(Constants.nullArtworkWidget,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              );
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

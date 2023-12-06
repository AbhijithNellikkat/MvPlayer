import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../data/db_functions.dart';
import '../../../utils/constants/constants.dart';

class RecentlyPlayedSongSliderWidget extends StatelessWidget {
  final DbFunctions dbFunctions = DbFunctions();

  RecentlyPlayedSongSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SizedBox(
        child: FutureBuilder(
          future: dbFunctions.getRecentlyPlayed(), // Updated function
          builder: (context, AsyncSnapshot<List<SongModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            final recentlyPlayed = snapshot.data ?? [];

            if (recentlyPlayed.isNotEmpty) {
              return CarouselSlider.builder(
                itemCount: recentlyPlayed.length,
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
                  final song = recentlyPlayed[itemIndex];

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: 250,
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
                          height: 180,
                          child: Lottie.asset(Constants.nullArtworkWidget,
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

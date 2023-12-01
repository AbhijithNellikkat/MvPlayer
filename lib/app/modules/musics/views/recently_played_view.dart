import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/data/db_functions.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyPlayedViews extends GetView {
  RecentlyPlayedViews({Key? key}) : super(key: key);

  final DbFunctions dbFunctions = DbFunctions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        width: double.infinity,
        height: 220,
        child: FutureBuilder<List<SongModel>>(
          future: dbFunctions.getRecentlyPlayed(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            final recentlyPlayed = snapshot.data ?? [];

            if (recentlyPlayed.isNotEmpty) {
              return GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recentlyPlayed.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                itemBuilder: (context, index) {
                  final song = recentlyPlayed[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 170,
                        child: QueryArtworkWidget(
                          artworkFit: BoxFit.cover,
                          artworkQuality: FilterQuality.high,
                          artworkBorder: const BorderRadius.all(Radius.zero),
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
                      ),
                      Text(
                        song.title,
                        style: GoogleFonts.poppins(
                            color: Constants.black, fontSize: 10),
                      ),
                    ],
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

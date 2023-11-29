import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/constants/constants.dart';
import '../controllers/music_player_controller.dart';
import '../controllers/tracks_controller.dart';

class MiniPlayerView extends StatefulWidget {
  const MiniPlayerView({Key? key}) : super(key: key);

  @override
  State<MiniPlayerView> createState() => _MiniPlayerViewState();
}

class _MiniPlayerViewState extends State<MiniPlayerView>
    with TickerProviderStateMixin {
  final MusicPlayerController musicPlayerController = Get.find();
  final TracksController tracksController = Get.find();
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicPlayerController>(
      builder: (controller) {
        final currentlyPlaying = controller.currentlyPlaying;

        if (currentlyPlaying != null && currentlyPlaying.id != null) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              height: 80,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GetBuilder<MusicPlayerController>(builder: (controller) {
                    return QueryArtworkWidget(
                      id: currentlyPlaying.id,
                      type: ArtworkType.AUDIO,
                      artworkFit: BoxFit.cover,
                      artworkQuality: FilterQuality.high,
                      artworkBorder:
                          const BorderRadius.all(Radius.circular(15)),
                      artworkHeight: 55,
                      artworkWidth: 55,
                      nullArtworkWidget: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Constants.black,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Lottie.asset(Constants.nullArtworkWidget,
                            fit: BoxFit.cover),
                      ),
                    );
                  }),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetBuilder<MusicPlayerController>(builder: (controller) {
                        return SizedBox(
                          width: 150,
                          height: 40,
                          child: Marquee(
                            text: currentlyPlaying.title,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                            fadingEdgeStartFraction: 0.5,
                            fadingEdgeEndFraction: 0.9,
                            scrollAxis: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            blankSpace: 20.0,
                            velocity: 50.0,
                            pauseAfterRound: const Duration(seconds: 0),
                            startPadding: 10.0,
                            accelerationDuration: const Duration(seconds: 1),
                            accelerationCurve: Curves.easeIn,
                            decelerationDuration:
                                const Duration(milliseconds: 500),
                            decelerationCurve: Curves.easeOut,
                            textDirection: TextDirection.ltr,
                            // Add any other properties you need
                          ),
                        );
                      }),
                    ],
                  ),
                  GetBuilder<MusicPlayerController>(builder: (controller) {
                    bool isPlaying = controller.audioPlayer.playing;
                    return GestureDetector(
                      onTap: () {
                        controller.toggleSong();
                      },
                      child: isPlaying
                          ? const Icon(
                              Constants.musicPause,
                              size: 37,
                              color: Constants.white,
                            )
                          : const Icon(
                              Constants.musicPlayArrow,
                              size: 37,
                              color: Constants.white,
                            ),
                    );
                  }),
                  GetBuilder<MusicPlayerController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          controller.playNextSong(
                              index: controller.currentlyPlayingIndex);
                        },
                        child: const Icon(
                          Constants.skipNext,
                          size: 37,
                          color: Constants.white,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

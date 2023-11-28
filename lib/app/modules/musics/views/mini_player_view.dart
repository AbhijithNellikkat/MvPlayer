import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/constants/constants.dart';
import '../controllers/music_player_controller.dart';
import '../widgets/music_playing_progressbar_widget.dart';

class MiniPlayerView extends StatelessWidget {
  MiniPlayerView({Key? key}) : super(key: key);

  final MusicPlayerController musicPlayerController = Get.find();
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicPlayerController>(
      builder: (controller) {
        final currentlyPlaying = musicPlayerController.currentlyPlaying;

        if (currentlyPlaying != null && currentlyPlaying.id != null) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(22)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QueryArtworkWidget(
                          id: currentlyPlaying.id,
                          type: ArtworkType.AUDIO,
                          artworkFit: BoxFit.cover,
                          artworkQuality: FilterQuality.high,
                          artworkHeight: 50,
                          artworkWidth: 50,
                          nullArtworkWidget: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Constants.black,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Lottie.asset(Constants.nullArtworkWidget,
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentlyPlaying.title,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              currentlyPlaying.artist,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 7.5,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        GetBuilder<MusicPlayerController>(
                          builder: (controller) {
                            bool isPlaying = controller.audioPlayer.playing;
                            return InkWell(
                              onTap: () async {
                                isPlaying
                                    ? await audioPlayer.pause()
                                    : audioPlayer.play();
                              },
                              child: isPlaying
                                  ? const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Constants.musicPause,
                                        size: 30,
                                        color: Constants.white,
                                      ),
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Constants.musicPlayArrow,
                                        size: 30,
                                        color: Constants.white,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 7, bottom: 6, left: 5, right: 5),
                    child: MusicPlayingProgressBarWidget(
                      thumbRadius: 0,
                      baseBarColor: Colors.grey,
                      progressBarColor: Constants.white,
                      thumbColor: Constants.white,
                      timeLabelTextColor: Constants.white,
                      musicPlayerController: musicPlayerController,
                    ),
                  ),
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

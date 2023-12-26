import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_player/app/data/db_functions.dart';
import 'package:mv_player/app/modules/musics/controllers/music_player_controller.dart';
import 'package:mv_player/app/modules/musics/controllers/tracks_controller.dart';
import 'package:mv_player/app/modules/settings/controllers/settings_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/constants/constants.dart';
import '../widgets/music_playing_progressbar_widget.dart';
import '../widgets/player_bottomsheet_widget.dart';

class MusicPlayerView extends StatefulWidget {
  final List<SongModel> songs;
  final int index;
  const MusicPlayerView({Key? key, required this.songs, required this.index})
      : super(key: key);

  @override
  State<MusicPlayerView> createState() => _MusicPlayerViewState();
}

class _MusicPlayerViewState extends State<MusicPlayerView> {
  final MusicPlayerController musicPlayerController = Get.find();

  final TracksController tracksController = Get.find();

  final SettingsController settingsController = Get.find();

  final DbFunctions dbFunctions = DbFunctions();

  @override
  void initState() {
    super.initState();
    musicPlayerController.playTheSong(
        songmodel: widget.songs, index: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    musicPlayerController.audioPlayer.currentIndexStream.listen(
      (index) {
        if (index != null) {
          if (index != musicPlayerController.currentlyPlayingIndex) {
            musicPlayerController.updateCurrentPlayingDetails(index);
          }
        }
      },
    );
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Constants.backArrow,
              // color: Colors.black,
            )),
        actions: [
          IconButton(
            onPressed: () {
              musicPlayerBottomSheet(
                tracksController: tracksController,
                context: context,
                index: widget.index,
                songs: widget.songs,
                dbFunctions: dbFunctions,
                musicPlayerController: musicPlayerController,
              );
            },
            icon: const Icon(
              Constants.moreVert,
              // color: Constants.black,
            ),
          ),
          const SizedBox(width: 11),
        ],
        automaticallyImplyLeading: false,
        // backgroundColor: Constants.scaffoldBgColor,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
          stream: musicPlayerController.audioPlayer.currentIndexStream,
          builder: (context, snapshot) {
            return ListView(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      QueryArtworkWidget(
                        nullArtworkWidget: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            // color: Constants.black,
                          ),
                          width: 350,
                          height: 350,
                          child: Lottie.asset(Constants.nullArtworkWidget,
                              fit: BoxFit.cover),
                        ),
                        quality: 100,
                        artworkQuality: FilterQuality.high,
                        size: MediaQuery.sizeOf(context).width.toInt(),
                        artworkHeight: 350,
                        artworkWidth: 350,
                        artworkBorder:
                            const BorderRadius.all(Radius.circular(15)),
                        id: musicPlayerController.currentlyPlaying.id,
                        type: ArtworkType.AUDIO,
                        artworkFit: BoxFit.cover,
                      ),
                      const SizedBox(height: 60),
                      Text(
                        musicPlayerController.currentlyPlaying.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      Text(
                        widget.songs[widget.index].artist! == "<unknown>"
                            ? "Unknown Artist"
                            : musicPlayerController.currentlyPlaying.artist!,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: MusicPlayingProgressBarWidget(
                          timeLabelLocation: TimeLabelLocation.below,
                          fontSize: 12,
                          musicPlayerController: musicPlayerController,
                          baseBarColor: Colors.grey,
                          thumbColor: settingsController.isDarkMode.value
                              ? Constants.white
                              : Constants.black,
                          progressBarColor: settingsController.isDarkMode.value
                              ? Constants.white
                              : Constants.black,
                          timeLabelTextColor:
                              settingsController.isDarkMode.value
                                  ? Constants.white
                                  : Constants.black,
                          thumbRadius: 9,
                        ),
                      ),
                      GetBuilder<MusicPlayerController>(
                        builder: (controller) {
                          bool isPlaying = controller.audioPlayer.playing;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () => controller.shuffleSong(),
                                icon: Icon(
                                  controller.audioPlayer.shuffleModeEnabled
                                      ? Constants.shuffleOnsharp
                                      : Constants.shuffle,
                                  size: 25,
                                  // color: Constants.black,
                                ),
                              ),

                              IconButton(
                                  onPressed: () {
                                    controller.playPrevSong(
                                        index: widget.index);
                                  },
                                  icon: const Icon(
                                    Constants.skipPrevious,
                                    size: 40,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  controller.toggleSong();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      color: settingsController.isDarkMode.value
                                          ? Constants.white
                                          : Constants.black,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: isPlaying
                                      ? const Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Icon(
                                            Constants.musicPause,
                                            size: 30,
                                          ),
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Icon(
                                            Constants.musicPlayArrow,
                                            size: 30,
                                          ),
                                        ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.playNextSong(index: widget.index);
                                },
                                icon: const Icon(
                                  Constants.skipNext,
                                  size: 40,
                                ),
                              ),
                              // InkWell(
                              //   onTap: () =>
                              //       musicPlayerController.togglePlaybackSpeed(),
                              //   child: Container(
                              //     margin: const EdgeInsets.only(top: 9),
                              //     decoration: BoxDecoration(
                              //       border: Border.all(
                              //           style: BorderStyle.solid,
                              //           color: Colors.black),
                              //       shape: BoxShape.circle,
                              //     ),
                              //     child: Obx(
                              //       () => Padding(
                              //         padding: const EdgeInsets.all(10.0),
                              //         child: Text(
                              //           '${musicPlayerController.playbackSpeed.value} x',
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              switch (controller.audioPlayer.loopMode) {
                                LoopMode.off => IconButton(
                                    onPressed: () => controller.loopSong(),
                                    icon: const Icon(
                                      Constants.repeatRounded,
                                      size: 25,
                                    )),
                                LoopMode.one => IconButton(
                                    onPressed: () => controller.loopSong(),
                                    icon: const Icon(
                                      Constants.repeatOneOnRounded,
                                      size: 25,
                                    )),
                                LoopMode.all => IconButton(
                                    onPressed: () => controller.loopSong(),
                                    icon: const Icon(
                                      Constants.repeatOnRounded,
                                      size: 25,
                                    )),
                              },
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

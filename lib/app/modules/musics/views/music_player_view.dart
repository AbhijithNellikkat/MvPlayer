import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_player/app/modules/musics/controllers/music_player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/constants/constants.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        actions: [
          IconButton(
            onPressed: () {
              musicPlayerBottomSheet(
                context: context,
                index: widget.index,
                songs: widget.songs,
                musicPlayerController: musicPlayerController,
              );
            },
            icon: const Icon(
              Constants.moreVert,
              color: Constants.black,
            ),
          ),
          const SizedBox(width: 11),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
          stream: musicPlayerController.audioPlayer.currentIndexStream,
          builder: (context, snapshot) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      QueryArtworkWidget(
                        nullArtworkWidget: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Constants.black,
                          ),
                          width: 350,
                          height: 350,
                          child: Lottie.asset(Constants.nullArtworkWidget,
                              fit: BoxFit.cover),
                        ),
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
                        child: StreamBuilder(
                          stream:
                              musicPlayerController.audioPlayer.positionStream,
                          builder: (context, stream) {
                            return ProgressBar(
                              progress: stream.data ?? Duration.zero,
                              total: Duration(
                                  milliseconds: musicPlayerController
                                      .currentlyPlaying.duration!),
                              onSeek: musicPlayerController.audioPlayer.seek,
                              thumbColor: Constants.black,
                              baseBarColor: Colors.grey,
                              progressBarColor: Constants.black,
                              timeLabelLocation: TimeLabelLocation.below,
                              timeLabelTextStyle: GoogleFonts.poppins(
                                  color: Constants.black, fontSize: 13),
                            );
                          },
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
                                      ? Icons.shuffle_on_sharp
                                      : Icons.shuffle,
                                  size: 25,
                                  color: Constants.black,
                                ),
                              ),

                              IconButton(
                                  onPressed: () {
                                    controller.playPrevSong(
                                        index: widget.index);
                                  },
                                  icon: const Icon(
                                    Icons.skip_previous,
                                    size: 40,
                                  )),
                              InkWell(
                                onTap: () {
                                  controller.toggleSong(
                                      uri: widget.songs[widget.index].uri!);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        style: BorderStyle.solid,
                                        color: Colors.black),
                                    shape: BoxShape.circle,
                                  ),
                                  child: isPlaying
                                      ? const Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Icon(
                                            Icons.pause,
                                            size: 30,
                                          ),
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Icon(
                                            Icons.play_arrow,
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
                                  Icons.skip_next,
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
                                      Icons.repeat_rounded,
                                      size: 25,
                                    )),
                                LoopMode.one => IconButton(
                                    onPressed: () => controller.loopSong(),
                                    icon: const Icon(
                                      Icons.repeat_one_on_rounded,
                                      size: 25,
                                    )),
                                LoopMode.all => IconButton(
                                    onPressed: () => controller.loopSong(),
                                    icon: const Icon(
                                      Icons.repeat_on_rounded,
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

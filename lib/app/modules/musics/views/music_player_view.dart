import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/constants/constants.dart';
import '../controllers/tracks_controller.dart';

class MusicPlayerView extends StatefulWidget {
  final List<SongModel> songs;
  final int index;
  const MusicPlayerView({Key? key, required this.songs, required this.index})
      : super(key: key);

  @override
  State<MusicPlayerView> createState() => _MusicPlayerViewState();
}

class _MusicPlayerViewState extends State<MusicPlayerView> {
  late AudioPlayer audioPlayer;
  late TracksController tracksController;

  @override
  void initState() {
    super.initState();
    tracksController = Get.find();
    audioPlayer = AudioPlayer();
    tracksController.playSong(songmodel: widget.songs, index: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    tracksController.audioPlayer.currentIndexStream.listen(
      (index) {
        if (index != null) {
          if (index != tracksController.currentlyPlayingIndex) {
            tracksController.updateCurrentPlayingDetails(index);
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
          stream: tracksController.audioPlayer.currentIndexStream,
          builder: (context, snapshot) {
            return Column(
              children: [
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
                        id: tracksController.currentlyPlaying.id,
                        type: ArtworkType.AUDIO,
                        artworkFit: BoxFit.cover,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        tracksController.currentlyPlaying.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      Text(
                        widget.songs[widget.index].artist! == "<unknown>"
                            ? "Unknown Artist"
                            : tracksController.currentlyPlaying.artist!,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: StreamBuilder(
                          stream: tracksController.audioPlayer.positionStream,
                          builder: (context, stream) {
                            return ProgressBar(
                              progress: stream.data ?? Duration.zero,
                              total: Duration(
                                  milliseconds: tracksController
                                      .currentlyPlaying.duration!),
                              onSeek: tracksController.audioPlayer.seek,
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
                      GetBuilder<TracksController>(
                        builder: (controller) {
                          bool isPlaying = controller.audioPlayer.playing;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              switch (controller.audioPlayer.loopMode) {
                                LoopMode.off => IconButton(
                                    onPressed: () => controller.loopSong(),
                                    icon: const Icon(
                                      Icons.repeat_rounded,
                                      size: 30,
                                    )),
                                LoopMode.one => IconButton(
                                    onPressed: () => controller.loopSong(),
                                    icon: const Icon(
                                      Icons.repeat_one_on_rounded,
                                      size: 30,
                                    )),
                                LoopMode.all => IconButton(
                                    onPressed: () => controller.loopSong(),
                                    icon: const Icon(
                                      Icons.repeat_on_rounded,
                                      size: 30,
                                    )),
                              },
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
                                icon: Icon(
                                  Icons.skip_next,
                                  size: 40,
                                ),
                              ),
                              IconButton(
                                  onPressed: () => controller.shuffleSong(),
                                  icon: Icon(
                                    controller.audioPlayer.shuffleModeEnabled
                                        ? Icons.shuffle_on_rounded
                                        : Icons.shuffle_rounded,
                                    size: 30,
                                  ))
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

// SafeArea(
//         child: Center(
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               StreamBuilder<int?>(
//                 stream: tracksController.audioPlayer.currentIndexStream,
//                 builder: (context, snapshot) {
//                   final currentIndex = widget.index;
//                   return QueryArtworkWidget(
//                     id: widget.songs[currentIndex].id,
//                     artworkHeight: 350,
//                     artworkWidth: 320,
//                     artworkBorder: const BorderRadius.all(Radius.circular(15)),
//                     artworkFit: BoxFit.cover,
//                     type: ArtworkType.AUDIO,
//                     artworkQuality: FilterQuality.high,
//                     nullArtworkWidget: Container(
//                       width: 320,
//                       height: 350,
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                         color: Constants.black,
//                       ),
//                       child: Lottie.asset(Constants.nullArtworkWidget,
//                           fit: BoxFit.cover),
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 child: StreamBuilder(
//                   stream: tracksController.audioPlayer.currentIndexStream,
//                   builder: (context, snapshot) {
//                     final currentIndex = widget.index;
//                     return Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 22),
//                           child: Text(
//                             widget.songs[currentIndex].displayNameWOExt,
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.poppins(
//                                 fontWeight: FontWeight.bold, fontSize: 15.0),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           '${widget.songs[currentIndex].artist}' == "<unknown>"
//                               ? "Unknown Artist"
//                               : '${widget.songs[currentIndex].artist}',
//                           overflow: TextOverflow.fade,
//                           maxLines: 1,
//                           style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w400, fontSize: 12.0),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 23),
//                 child: Obx(
//                   () => Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(tracksController.position.value),
//                       Expanded(
//                         child: Slider(
//                           inactiveColor: Colors.grey,
//                           activeColor: Constants.black,
//                           min: const Duration(seconds: 0).inSeconds.toDouble(),
//                           max: tracksController.max.value,
//                           value: tracksController.value.value,
//                           onChanged: (newValue) {
//                             tracksController
//                                 .changeDurationToSeconds(newValue.toInt());
//                             newValue = newValue;
//                           },
//                         ),
//                       ),
//                       Text(tracksController.duration.value),
//                     ],
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         // tracksController.playSong(
//                         //   uri: songs[index].uri,
//                         //   index: index - 1,
//                         // );
//                       },
//                       icon: Icon(Icons.skip_previous)),
//                   InkWell(
//                     onTap: () {
//                       if (tracksController.audioPlayer.playing) {
//                         tracksController.audioPlayer.pause();
//                       } else {
//                         if (tracksController.audioPlayer.currentIndex != null) {
//                           tracksController.audioPlayer.play();
//                         }
//                       }
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                             style: BorderStyle.solid, color: Colors.black),
//                         shape: BoxShape.circle,
//                       ),
//                       child: StreamBuilder<bool>(
//                         stream: tracksController.audioPlayer.playingStream,
//                         builder: (context, snapshot) {
//                           bool? playingState = snapshot.data;
//                           if (playingState != null && playingState) {
//                             return const Icon(
//                               Icons.pause,
//                               size: 30,
//                             );
//                           }
//                           return const Icon(
//                             Icons.play_arrow,
//                             size: 30,
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.skip_next),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       tracksController.togglePlaybackSpeed();
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(15),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                             color: Colors.black, style: BorderStyle.solid),
//                       ),
//                       child: Obx(() {
//                         final speed = tracksController.playbackSpeed.value;
//                         return Text(
//                           "${speed}x",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         );
//                       }),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),

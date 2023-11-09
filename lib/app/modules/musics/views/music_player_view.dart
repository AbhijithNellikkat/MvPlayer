import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_player/app/modules/musics/controllers/tracks_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/constants/constants.dart';

class MusicPlayerView extends StatelessWidget {
  final List<SongModel> songs;
  final int index;
  MusicPlayerView({Key? key, required this.songs, required this.index})
      : super(key: key);

  final TracksController tracksController = Get.find();

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              StreamBuilder<int?>(
                stream: tracksController.audioPlayer.currentIndexStream,
                builder: (context, snapshot) {
                  final currentIndex = index;
                  return QueryArtworkWidget(
                    id: songs[currentIndex].id,
                    artworkHeight: 350,
                    artworkWidth: 320,
                    artworkBorder: const BorderRadius.all(Radius.circular(15)),
                    artworkFit: BoxFit.cover,
                    type: ArtworkType.AUDIO,
                    artworkQuality: FilterQuality.high,
                    nullArtworkWidget: Container(
                      width: 320,
                      height: 350,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Constants.black,
                      ),
                      child: Lottie.asset(Constants.nullArtworkWidget,
                          fit: BoxFit.cover),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                child: StreamBuilder(
                  stream: tracksController.audioPlayer.currentIndexStream,
                  builder: (context, snapshot) {
                    final currentIndex = index;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Text(
                            songs[currentIndex].displayNameWOExt,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 15.0),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${songs[currentIndex].artist}' == "<unknown>"
                              ? "Unknown Artist"
                              : '${songs[currentIndex].artist}',
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400, fontSize: 12.0),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(tracksController.position.value),
                        Expanded(
                          child: Slider(
                            inactiveColor: Colors.grey,
                            activeColor: Constants.black,
                            min:
                                const Duration(seconds: 0).inSeconds.toDouble(),
                            max: tracksController.max.value,
                            value: tracksController.value.value,
                            onChanged: (newValue) {
                              tracksController
                                  .changeDurationToSeconds(newValue.toInt());
                              newValue = newValue;
                            },
                          ),
                        ),
                        Text(tracksController.duration.value),
                      ],
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      if (tracksController.audioPlayer.hasPrevious) {
                        tracksController.onBackPlay();
                      }
                    },
                    child: Icon(
                      Icons.skip_previous,
                      size: 33,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (tracksController.audioPlayer.playing) {
                        tracksController.audioPlayer.pause();
                      } else {
                        if (tracksController.audioPlayer.currentIndex != null) {
                          tracksController.audioPlayer.play();
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                            style: BorderStyle.solid, color: Colors.black),
                        shape: BoxShape.circle,
                      ),
                      child: StreamBuilder<bool>(
                        stream: tracksController.audioPlayer.playingStream,
                        builder: (context, snapshot) {
                          bool? playingState = snapshot.data;
                          if (playingState != null && playingState) {
                            return const Icon(
                              Icons.pause,
                              size: 30,
                            );
                          }
                          return const Icon(
                            Icons.play_arrow,
                            size: 30,
                          );
                        },
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (tracksController.audioPlayer.hasNext) {
                        tracksController.onNextPlay();
                      }
                    },
                    child: Icon(
                      Icons.skip_next,
                      size: 33,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

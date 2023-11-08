import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_player/app/modules/musics/controllers/tracks_controller.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingView extends StatelessWidget {
  NowPlayingView({required this.songModel, 
   Key? key})
      : super(key: key);

  final List<SongModel> songModel;


  final TracksController tracksController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldBgColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Constants.backArrow,
            color: Constants.black,
          ),
        ),
        backgroundColor: Constants.scaffoldBgColor,
      ),
      body: Center(
        child: Obx(
          () => Column(
            children: [
              const SizedBox(height: 20),
              QueryArtworkWidget(
                id: songModel[tracksController.playIndex.value].id,
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
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Text(
                  songModel[tracksController.playIndex.value].displayNameWOExt,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${songModel[tracksController.playIndex.value].artist}' ==
                        "<unknown>"
                    ? "Unknown Artist"
                    : '${songModel[tracksController.playIndex.value].artist}',
                overflow: TextOverflow.fade,
                maxLines: 1,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400, fontSize: 12.0),
              ),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(tracksController.position.value),
                        Expanded(
                          child: Slider(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        
                      },
                      icon: const Icon(
                        Icons.skip_previous,
                        size: 35.0,
                      ),
                    ),
                    Obx(
                      () => IconButton(
                        onPressed: () {
                          if (tracksController.isPlaying.value) {
                            tracksController.audioPlayer.pause();
                            tracksController.isPlaying(false);
                          } else {
                            tracksController.audioPlayer.play();
                            tracksController.isPlaying(true);
                          }
                        },
                        icon: Icon(
                          tracksController.isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 35.0,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                       
                      },
                      icon: const Icon(
                        Icons.skip_next,
                        size: 35.0,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Volume:"),
                  Slider(
                    activeColor: Constants.black,
                    value: tracksController.volume.value,
                    onChanged: tracksController.setVolume,
                    min: 0.0,
                    max: 1.0,

                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {
                  tracksController.togglePlaybackSpeed();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Obx(() {
                  final speed = tracksController.playbackSpeed.value;
                  return Text("${speed}x");
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

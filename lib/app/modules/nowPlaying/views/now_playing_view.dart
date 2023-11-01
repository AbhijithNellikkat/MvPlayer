import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_player/app/modules/musics/controllers/tracks_controller.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingView extends StatefulWidget {
  NowPlayingView({required this.songModel, required this.index, Key? key})
      : super(key: key);

  final SongModel songModel;
  final int index;

  @override
  State<NowPlayingView> createState() => _NowPlayingViewState();
}

class _NowPlayingViewState extends State<NowPlayingView> {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // playSong(uri: '${widget.songModel.uri}');
  }

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
        child: Column(
          children: [
            const SizedBox(height: 30),
            QueryArtworkWidget(
                id: widget.songModel.id,
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
                )),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                widget.songModel.displayNameWOExt,
                overflow: TextOverflow.fade,
                maxLines: 1,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${widget.songModel.artist}' == "<unknown>"
                  ? "Unknown Artist"
                  : '${widget.songModel.artist}',
              overflow: TextOverflow.fade,
              maxLines: 1,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400, fontSize: 12.0),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('0.0'),
                  Expanded(
                    child: Slider(
                      value: 0.0,
                      onChanged: (value) {},
                    ),
                  ),
                  Text('0.0'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_next,
                      size: 35.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

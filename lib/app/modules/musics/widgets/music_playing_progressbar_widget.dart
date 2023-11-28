import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/music_player_controller.dart';

class MusicPlayingProgressBarWidget extends StatelessWidget {
  const MusicPlayingProgressBarWidget(
      {super.key,
      required this.musicPlayerController,
      required this.thumbColor,
      required this.progressBarColor,
      required this.baseBarColor,
      required this.timeLabelTextColor,
      this.thumbRadius = 8});

  final MusicPlayerController musicPlayerController;
  final Color thumbColor;
  final Color progressBarColor;
  final Color baseBarColor;
  final Color timeLabelTextColor;
  final double thumbRadius;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: musicPlayerController.audioPlayer.positionStream,
      builder: (context, stream) {
        return ProgressBar(
          timeLabelLocation: TimeLabelLocation.none,
          progress: stream.data ?? Duration.zero,
          total: Duration(
              milliseconds: musicPlayerController.currentlyPlaying.duration!),
          onSeek: musicPlayerController.audioPlayer.seek,
          thumbColor: thumbColor,
          thumbRadius: thumbRadius,
          baseBarColor: baseBarColor,
          barCapShape: BarCapShape.round,
          thumbCanPaintOutsideBar: true,
          progressBarColor: progressBarColor,
          timeLabelTextStyle:
              GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
        );
      },
    );
  }
}

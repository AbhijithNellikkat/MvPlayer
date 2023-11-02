import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'dart:developer';

class TracksController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();

  var playIndex = 0.obs;
  var isPlaying = false.obs;

  var duration = ''.obs;
  var position = ''.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  var volume = 1.0.obs;
  var playbackSpeed = 1.0.obs;
  final List<double> availableSpeeds = [0.5, 1.0, 1.5, 2.0];
  int speedIndex = 1;

  void setVolume(double value) {
    audioPlayer.setVolume(value);
    volume.value = value;
  }

  void togglePlaybackSpeed() {
    speedIndex = (speedIndex + 1) % availableSpeeds.length;
    final newSpeed = availableSpeeds[speedIndex];
    audioPlayer.setSpeed(newSpeed);
    playbackSpeed.value = newSpeed;
  }

  updatePosition() {
    audioPlayer.durationStream.listen((event) {
      duration.value = event.toString().split('.')[0];
      max.value = event!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((event) {
      position.value = event.toString().split('.')[0];
      value.value = event.inSeconds.toDouble();
    });
  }

  changeDurationToSeconds(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  fetchAllSongs() {
    return audioQuery.querySongs(
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  }

  playSong({required uri, required index}) async {
    playIndex.value = index;
    try {
      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri),
        ),
      );
      audioPlayer.play();
      isPlaying(true);
      updatePosition();
    } on Exception {
      log('Cannot parse song');
    } catch (e) {
      log('$e');
    }
  }
}

import 'dart:developer';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class TracksController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();

  var playIndex = 0.obs; // Index of the currently playing song
  var isPlaying = false.obs; // Whether audio is currently playing

  var duration = ''.obs; // Current song duration
  var position = ''.obs; // Current playback position

  var max = 0.0.obs; // Maximum duration
  var value = 0.0.obs; // Current position value

  var volume = 1.0.obs; // Audio volume
  var playbackSpeed = 1.0.obs; // Playback speed

  final List<double> availableSpeeds = [
    0.5,
    1.0,
    1.5,
    2.0
  ]; // Available playback speeds

  int speedIndex = 1; // Current playback speed index

  // Method to change the volume
  void setVolume(double value) {
    audioPlayer.setVolume(value);
    volume.value = value;
  }

  // Method to toggle between available playback speeds
  void togglePlaybackSpeed() {
    speedIndex = (speedIndex + 1) % availableSpeeds.length;
    final newSpeed = availableSpeeds[speedIndex];
    audioPlayer.setSpeed(newSpeed);
    playbackSpeed.value = newSpeed;
  }

  // Method to update the current position and duration
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

  // Method to change the playback position to a specified number of seconds
  changeDurationToSeconds(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  onNextPlay() async{
    await audioPlayer.seekToNext();
  }

  onBackPlay() async {
    await audioPlayer.seekToPrevious();
  }

  // Method to fetch all songs from the device
  fetchAllSongs() {
    return audioQuery.querySongs(
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  }

  // Method to play a selected song
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

  @override
  void onClose() {
    super.onClose();
    audioPlayer.dispose();
  }
}

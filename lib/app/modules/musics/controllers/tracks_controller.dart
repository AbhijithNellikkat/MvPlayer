import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class TracksController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();
  // final AudioPlayer audioPlayer = AudioPlayer();

  // final List<double> availableSpeeds = [
  //   0.5,
  //   1.0,
  //   1.5,
  //   2.0
  // ]; // Available playback speeds

  // int speedIndex = 1; // Current playback speed index

  

  // // Method to change the volume
  // void setVolume(double value) {
  //   audioPlayer.setVolume(value);
  //   volume.value = value;
  // }

  // // Method to toggle between available playback speeds
  // void togglePlaybackSpeed() {
  //   speedIndex = (speedIndex + 1) % availableSpeeds.length;
  //   final newSpeed = availableSpeeds[speedIndex];
  //   audioPlayer.setSpeed(newSpeed);
  //   playbackSpeed.value = newSpeed;
  // }

  // Method to fetch all songs from the device
  fetchAllSongs() {
    return audioQuery.querySongs(
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  }

  
}

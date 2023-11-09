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

  var currentlyPlaying;
  int currentlyPlayingIndex = 0;

  late ConcatenatingAudioSource currentQueue;
  static List<SongModel> allSongs = [];
  List<SongModel> currentPlaylist = [];

  Duration positionn = Duration.zero;

  TracksController() {
    log('====================== TracksController ======================');
    loadDuration();
  }

  loadDuration() async {}

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

  // Method to fetch all songs from the device
  fetchAllSongs() {
    return audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  }

  // Method to play a selected song
  // playSong({required uri, required index}) async {
  //   // _index = index;
  //   playIndex.value = index;
  //   try {
  //     await audioPlayer.setAudioSource(
  //       AudioSource.uri(
  //         Uri.parse(uri),
  //       ),
  //     );
  //     audioPlayer.play();
  //     isPlaying(true);
  //     updatePosition();
  //   } on Exception {
  //     log('Cannot parse song');
  //   } catch (e) {
  //     log('$e');
  //   }
  // }

  playSong({required List<SongModel> songmodel, required index}) {
    // var uri = songmodel[index].uri;
    try {
      // audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioPlayer.setAudioSource(createPlaylist(songmodel),
          initialIndex: index);
      playSongg(songmodel[index], index);
    } on Exception {
      log("error playing");
    } catch (e) {
      log(e.toString());
    }
  }

  loopSong() {
    switch (audioPlayer.loopMode) {
      case LoopMode.off:
        audioPlayer.setLoopMode(LoopMode.off);
        update();
        break;
      case LoopMode.one:
        audioPlayer.setLoopMode(LoopMode.one);
        update();
        break;
      case LoopMode.all:
        audioPlayer.setLoopMode(LoopMode.all);
        update();
        break;
    }
  }

  shuffleSong() {
    audioPlayer.shuffleModeEnabled
        ? audioPlayer.setShuffleModeEnabled(false)
        : audioPlayer.setShuffleModeEnabled(true);
    update();
  }

  playNextSong({required index}) {
    // increaseIndex();
    // int ind = _index!;
    // var uri = _songmodel[ind].uri;
    // audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
    // audioPlayer.play();
    audioPlayer.seekToNext();

    update();
  }

  playPrevSong({required index}) {
    // decreaseIndex();
    // int ind = _index!;
    // var uri = _songmodel[ind].uri;
    // audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
    // audioPlayer.play();
    audioPlayer.seekToPrevious();
    update();
  }

  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    currentPlaylist.clear();
    currentPlaylist = [...songs];
    List<AudioSource> sources = [];
    for (var song in songs) {
      sources.add(AudioSource.uri(Uri.parse(song.uri!)));
    }
    currentQueue = ConcatenatingAudioSource(children: sources);
    return ConcatenatingAudioSource(children: sources);
  }

  playSongg(song, index) {
    currentlyPlayingIndex = index;
    currentlyPlaying = song;
    audioPlayer.play();
  }

  toggleSong({required String uri}) async {
    try {
      audioPlayer.playing ? await audioPlayer.pause() : audioPlayer.play();
      update();
    } on Exception {
      log("error playing");
    } catch (e) {
      log(e.toString());
    }
  }

  void updateCurrentPlayingDetails(int index) {
    if (currentPlaylist.isNotEmpty) {
      currentlyPlayingIndex = index;
      currentlyPlaying = currentPlaylist[index];
    } else {
      currentlyPlaying = null;
      audioPlayer.dispose();
    }
  }

  @override
  void onClose() {
    super.onClose();
    audioPlayer.dispose();
  }
}

// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:developer';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mv_player/app/modules/musics/controllers/playlist_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../data/db_functions.dart';

class MusicPlayerController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();
  final OnAudioQuery audioquery = OnAudioQuery();

  late PlaylistController playlistController;

  // RxList<SongModel> recentlyPlayed = <SongModel>[].obs;

  @override
  void onInit() {
    playlistController = Get.find();
    super.onInit();
  }

  // Currently playing song information
  var currentlyPlaying;

  int currentlyPlayingIndex = 0;

  // ignore: unused_field
  int? _index;

  // Current playback position
  Duration position = Duration.zero;

  // Available playback speeds
  final List<double> availableSpeeds = [0.5, 1.0, 1.5, 2.0];

  // Current playback speed index
  int speedIndex = 1;

  var playbackSpeed = 1.0.obs;

  var volume = 1.0.obs;

  late DbFunctions dbFunctions;

  MusicPlayerController() {
    dbFunctions = DbFunctions();
    loadDuration();
  }

  @override
  void onClose() {
    super.onClose();
    audioPlayer.dispose();
  }

  // Method to load the duration of the currently playing song
  loadDuration() async {
    _index = audioPlayer.currentIndex;
  }

  // Method to play a specific song in the playlist
  playTheSong({required List<SongModel> songmodel, required index}) async {
    try {
      audioPlayer.setAudioSource(
        playlistController.playthesong(songs: songmodel),
        initialIndex: index,
      );

      // recentlyPlayed.add(songmodel[index]);

      await dbFunctions.addRecentlyPlayedSong(song: songmodel[index]);
      playSong(songmodel[index], index);
      update();
    } on Exception {
      log("error playing");
    } catch (e) {
      log('$e');
    }
  }

  // Method to play a specific song and update the currently playing details
  playSong(song, index) {
    currentlyPlayingIndex = index;
    currentlyPlaying = song;
    audioPlayer.play();
  }

  // Method to toggle play/pause for the currently playing song
  toggleSong() async {
    try {
      audioPlayer.playing ? await audioPlayer.pause() : audioPlayer.play();
      update();
    } on Exception {
      log("error playing");
    } catch (e) {
      log(e.toString());
    }
  }

  playNextSong({required index}) {
    audioPlayer.seekToNext();
    update();
  }

  playPrevSong({required index}) {
    audioPlayer.seekToPrevious();
    update();
  }

  void togglePlaybackSpeed() {
    speedIndex = (speedIndex + 1) % availableSpeeds.length;
    final newSpeed = availableSpeeds[speedIndex];
    audioPlayer.setSpeed(newSpeed);
    playbackSpeed.value = newSpeed;
  }

  shuffleSong() {
    audioPlayer.shuffleModeEnabled
        ? audioPlayer.setShuffleModeEnabled(false)
        : audioPlayer.setShuffleModeEnabled(true);
    update();
  }

  loopSong() {
    switch (audioPlayer.loopMode) {
      case LoopMode.off:
        audioPlayer.setLoopMode(LoopMode.one);
        update();
        break;
      case LoopMode.one:
        audioPlayer.setLoopMode(LoopMode.all);
        update();
        break;
      case LoopMode.all:
        audioPlayer.setLoopMode(LoopMode.off);
        update();
        break;
    }
  }

  // Method to set the volume of the audio player
  void setVolume(double value) {
    audioPlayer.setVolume(value);
    volume.value = value;
    update();
  }

  void updateCurrentPlayingDetails(int index) {
    if (playlistController.allSongs.isNotEmpty) {
      currentlyPlayingIndex = index;
      currentlyPlaying = playlistController.allSongs[index];
    } else {
      currentlyPlaying = null;
      audioPlayer.dispose();
    }
  }

  void updateCurrentlyPlayingIndex(int index) {
    currentlyPlayingIndex = index;
  }
}

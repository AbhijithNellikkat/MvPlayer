// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicPlayerController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();

  // Currently playing song information
  var currentlyPlaying;

  int currentlyPlayingIndex = 0;

  // ignore: unused_field
  int? _index;

  // Audio queue for the current playlist
  late ConcatenatingAudioSource currentQueue;

  // List to store all songs from the device
  static List<SongModel> allSongs = [];

  // List to store the current playlist
  List<SongModel> currentPlaylist = [];

  // Current playback position
  Duration position = Duration.zero;

  // Available playback speeds
  final List<double> availableSpeeds = [0.5, 1.0, 1.5, 2.0];

  // Current playback speed index
  int speedIndex = 1;

  var playbackSpeed = 1.0.obs;

  var volume = 100.0.obs;

  MusicPlayerController() {
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
  playTheSong({required List<SongModel> songmodel, required index}) {
    try {
      audioPlayer.setAudioSource(createPlaylist(songmodel),
          initialIndex: index);
      playSong(songmodel[index], index);
    } on Exception {
      log("error playing");
    } catch (e) {
      log(e.toString());
    }
  }

  // Method to play a specific song and update the currently playing details
  playSong(song, index) {
    currentlyPlayingIndex = index;
    currentlyPlaying = song;
    audioPlayer.play();
  }

  // Method to toggle play/pause for the currently playing song
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
    if (currentPlaylist.isNotEmpty) {
      currentlyPlayingIndex = index;
      currentlyPlaying = currentPlaylist[index];
    } else {
      currentlyPlaying = null;
      audioPlayer.dispose();
    }
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
}

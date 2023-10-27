import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllMusicsPlayerController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();

  final AudioPlayer audioPlayer = AudioPlayer();



  playSong(String? uri) async {
    await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
    await audioPlayer.play();
  }
}

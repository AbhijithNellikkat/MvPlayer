import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class AllMusicsPlayerController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();

  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  checkPermission() async {
    var permission = await Permission.storage.request();

    if (permission.isGranted) {
    } else {
      checkPermission();
    }
  }

  playSong(String? uri) async {
    await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
    await audioPlayer.play();
  }
}

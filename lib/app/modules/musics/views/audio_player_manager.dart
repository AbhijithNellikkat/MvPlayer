import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerManager {
  final AudioPlayer player = AudioPlayer();
  Stream<DurationState>? durationState;

  void init() {
    durationState = Rx.combineLatest2<Duration, Duration?, DurationState>(
        player.positionStream,
        player.durationStream,
        (position, duration) => DurationState(
            position: position, duration: duration ?? Duration.zero));
    player.play();
  }

  void dispose() {
    player.dispose();
  }
}

class DurationState {
  const DurationState(
      {this.position = Duration.zero, this.duration = Duration.zero});
  final Duration position, duration;
}

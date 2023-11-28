import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'models.g.dart';

@HiveType(typeId: 1)
class MusicModel extends HiveObject {
  MusicModel({required this.playlist, required this.favourites, required this.recentlyPlayed});

  @HiveField(0)
  Map<String, List<SongModel>> playlist;

  @HiveField(1)
  List<SongModel> favourites;

   @HiveField(2)
  List<SongModel> recentlyPlayed;
}

import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongModelAdapter extends TypeAdapter<SongModel> {
  @override
  final int typeId = 3;

  @override
  SongModel read(BinaryReader reader) {
    final Map<dynamic, dynamic> info = reader.readMap();
    return SongModel(info);
  }

  @override
  void write(BinaryWriter writer, SongModel model) {
    writer.writeMap(model.getMap);
  }
}

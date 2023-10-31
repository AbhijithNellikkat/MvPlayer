import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/styles/text_styles.dart';


class TracksView extends StatefulWidget {
  TracksView({Key? key}) : super(key: key);

  @override
  State<TracksView> createState() => _TracksViewState();
}

class _TracksViewState extends State<TracksView> {


  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(color: Constants.black),
            );
          } else if (snapshot.data!.isEmpty) {
            const Center(
              child: Text(
                "No songs Found",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.red),
              ),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: ListTile(
                  onTap: () {},
                  leading: QueryArtworkWidget(
                    id: snapshot.data![index].id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: const Icon(
                      Icons.music_note,
                      color: Constants.black,
                      size: 32,
                    ),
                  ),
                  title: Text(
                    snapshot.data![index].displayNameWOExt,
                    style: musicsName,
                  ),
                  subtitle: Text(
                    '${snapshot.data![index].artist}',
                    style: const TextStyle(fontSize: 9),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Constants.moreVert),
                    color: Colors.black,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

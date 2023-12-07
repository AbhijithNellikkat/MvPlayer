import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumCard extends StatelessWidget {
  final AlbumModel album;

  const AlbumCard({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QueryArtworkWidget(
                id: album.id,
                artworkHeight: 90,
                artworkWidth: 120,
                type: ArtworkType.ALBUM),
            const SizedBox(height: 8),
            Text(
              album.album,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              album.artist ?? 'Unknown Artist',
              style: TextStyle(color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

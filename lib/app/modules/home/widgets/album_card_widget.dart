import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumCard extends StatelessWidget {
  final AlbumModel album;

  const AlbumCard({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // Set the desired width for each album card
      margin: const EdgeInsets.all(4),
      child: Card(
        color: Constants.black,
        child: Column(
          children: [
            QueryArtworkWidget(
              id: album.id,
              type: ArtworkType.ALBUM,
              artworkBorder: const BorderRadius.all(Radius.circular(12)),
              artworkFit: BoxFit.fitHeight,
              artworkHeight: 160,
              artworkWidth: double.infinity,
              quality: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(album.album,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Constants.white)),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/musics/views/widgets/my_favourties_widget.dart';

import 'widgets/playlist_add_bottmSheet.dart';

class PlaylistsView extends GetView {
  PlaylistsView({Key? key}) : super(key: key);

  final TextEditingController playlistController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
          
           
            const SizedBox(height: 20),
            ListTile(
              leading: const CircleAvatar(
                maxRadius: 30,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.music_note_sharp,
                  color: Colors.white,
                ),
              ),
              title: const Text('Malayalam songs'),
              subtitle: Text(
                '209 songs',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const CircleAvatar(
                maxRadius: 30,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.music_note_sharp,
                  color: Colors.white,
                ),
              ),
              title: const Text('English songs'),
              subtitle: Text(
                '119 songs',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () {
            playlistAddBottmSheet(context, playlistController);
          },
          label: const Text('New playlist')),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/musics/controllers/playlist_controller.dart';

import '../../../utils/constants/constants.dart';

void playlistAddBottmSheet(
    BuildContext context, TextEditingController playlistEditingController) {
  final PlaylistController playlistController = Get.find();
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 250,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.playlist_add,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Create New Playlist',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: TextFormField(
                controller: playlistEditingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  playlistController.createNewPlaylist(
                      playlistname: playlistEditingController.text);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Create',
                    style: TextStyle(color: Constants.white),
                  ),
                ))
          ],
        ),
      );
    },
  );
}

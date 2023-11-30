import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/musics/controllers/playlist_controller.dart';
import 'package:mv_player/app/utils/constants/constants.dart';

import '../../../common/widgets/toast_message_widget.dart';
import '../../../data/db_functions.dart';

Future<void> createPlaylistDialogWidget(BuildContext context,
    DbFunctions dbFunctions, PlaylistController playlistController) async {
  final TextEditingController playlistNameController = TextEditingController();
  await showDialog(
    traversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Create New Playlist',
        style: GoogleFonts.poppins(fontSize: 15, color: Constants.white),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            style: GoogleFonts.poppins(color: Constants.white),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Playlist Name',
              labelStyle:
                  GoogleFonts.poppins(fontSize: 12, color: Constants.white),
            ),
            controller: playlistNameController,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final String playlistName = playlistNameController.text.trim();
              if (playlistName.isEmpty) {
                toastMessageWidget(
                  message: "The playlist name is empty ⚠️",
                  gravity: ToastGravity.TOP,
                );
              } else {
                await dbFunctions.createPlaylist(
                  playlistName: playlistName,
                  songs: [],
                );
              }
              playlistNameController.clear();
              playlistController.refreshTheApp();
              Get.back();
            },
            child: Text(
              'Create Playlist',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/musics/controllers/playlist_controller.dart';

import '../../../common/widgets/toast_message_widget.dart';
import '../../../data/db_functions.dart';
import '../../../utils/constants/constants.dart';
import '../../settings/controllers/settings_controller.dart';

final SettingsController settingsController = Get.find();

Future<void> createPlaylistDialogWidget(BuildContext context,
    DbFunctions dbFunctions, PlaylistController playlistController) async {
  final TextEditingController playlistNameController = TextEditingController();
  await showDialog(
    traversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: settingsController.isDarkMode.value
          ? Constants.white
          : Constants.black,
      title: Text(
        'Create New Playlist',
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: settingsController.isDarkMode.value
              ? Constants.black
              : Constants.white,
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            style: GoogleFonts.poppins(
              color: settingsController.isDarkMode.value
                  ? Constants.black
                  : Constants.white,
            ),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Playlist Name',
              labelStyle: GoogleFonts.poppins(
                fontSize: 12,
                color: settingsController.isDarkMode.value
                    ? Constants.black
                    : Constants.white,
              ),
            ),
            controller: playlistNameController,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    settingsController.isDarkMode.value
                        ? Constants.black
                        : Constants.white)),
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
                color: settingsController.isDarkMode.value
                    ? Constants.white
                    : Constants.black,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/data/db_functions.dart';
import 'package:mv_player/app/modules/settings/controllers/settings_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../common/widgets/toast_message_widget.dart';
import '../../../utils/constants/constants.dart';

final SettingsController settingsController = Get.find();

Future<void> songAddToPlaylistDialogWidget({
  required DbFunctions dbFunctions,
  required SongModel selectedSong,
  required BuildContext context,
}) async {
  List<String> playlistNames = await dbFunctions.getPlaylistNames();

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: settingsController.isDarkMode.value
            ? Constants.white
            : Constants.black,
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'close',
              style: GoogleFonts.poppins(
                color: settingsController.isDarkMode.value
                    ? Constants.black
                    : Constants.white,
              ),
            ),
          )
        ],
        title: Text(
          'Add to playlist',
          style: GoogleFonts.poppins(
            color: settingsController.isDarkMode.value
                ? Constants.black
                : Constants.white,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (playlistNames.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'No playlists available ❗',
                  style: GoogleFonts.poppins(
                    color: settingsController.isDarkMode.value
                        ? Constants.black
                        : Constants.white,
                  ),
                ),
              )
            else
              for (var playlistName in playlistNames)
                Card(
                  child: ListTile(
                    title: Text(
                      playlistName,
                      style: GoogleFonts.poppins(
                        color: settingsController.isDarkMode.value
                            ? Constants.white
                            : Constants.black,
                      ),
                    ),
                    onTap: () {
                      dbFunctions.addSongToPlaylist(
                        playlistName: playlistName,
                        song: selectedSong,
                      );
                      Get.back();
                      toastMessageWidget(
                        message:
                            '${selectedSong.title} added to $playlistName ✨',
                        gravity: ToastGravity.TOP,
                      );
                    },
                  ),
                ),
          ],
        ),
      );
    },
  );
}

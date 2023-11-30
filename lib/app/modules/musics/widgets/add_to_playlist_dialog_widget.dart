import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/data/db_functions.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../common/widgets/toast_message_widget.dart';

Future<void> songAddToPlaylistDialogWidget(
    {required DbFunctions dbFunctions,
    required SongModel selectedSong,
    required BuildContext context}) async {
  List<String> playlistNames = await dbFunctions.getPlaylistNames();

  // ignore: use_build_context_synchronously
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add to playlist'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var playlistName in playlistNames)
              ListTile(
                title: Text(playlistName),
                onTap: () {
                  // Add the selected song to the chosen playlist
                  dbFunctions.addSongToPlaylist(
                    playlistName: playlistName,
                    song: selectedSong,
                  );
                  Get.back();
                  toastMessageWidget(
                    message: '${selectedSong.title} added to $playlistName',
                    gravity: ToastGravity.TOP,
                  );
                },
              ),
          ],
        ),
      );
    },
  );
}

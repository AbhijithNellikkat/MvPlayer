import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/data/db_functions.dart';
import 'package:mv_player/app/modules/musics/controllers/playlist_controller.dart';

import '../../../common/widgets/toast_message_widget.dart';

Future<void> deletePlaylistComfirmationDialogWidget({
  required BuildContext context,
  required DbFunctions dbFunctions,
  required String playlistName,
  required PlaylistController playlistController,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete Playlist"),
        content: Text(
            'Are you sure you want to delete the playlist $playlistName ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await dbFunctions.deletePlaylist(playlistName);
              playlistController.refreshTheApp();
              toastMessageWidget(
                message: "The playlist list deleted permanently ❗",
                gravity: ToastGravity.TOP,
              );
              Get.back();
            },
            child: const Text("Delete"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancel"),
          ),
        ],
      );
    },
  );
}

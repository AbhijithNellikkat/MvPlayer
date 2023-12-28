import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_player/app/modules/musics/controllers/playlist_controller.dart';
import 'package:mv_player/app/modules/musics/views/playlist_details_view.dart';
import 'package:mv_player/app/modules/musics/widgets/delete_comfirmation_dialog_widget.dart';
import 'package:mv_player/app/modules/musics/widgets/rename_playlist_dialog_widget.dart';
import 'package:mv_player/app/modules/settings/controllers/settings_controller.dart';

import '../../../common/widgets/toast_message_widget.dart';
import '../../../data/db_functions.dart';
import '../../../utils/constants/constants.dart';
import '../widgets/create_playlist_dialog_widget.dart';

class PlaylistsView extends StatelessWidget {
  PlaylistsView({Key? key}) : super(key: key);

  final PlaylistController playlistController = Get.find();
  final DbFunctions dbFunctions = DbFunctions();
  final SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Constants.scaffoldBgColor,
      body: GetBuilder<PlaylistController>(builder: (context) {
        return FutureBuilder<List<String>>(
          future: dbFunctions.getPlaylistNames(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Constants.circularProgressIndicator,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(Constants.emptyBoxAnimation),
                  ),
                  Text(
                    Constants.noPlaylist,
                    style: GoogleFonts.poppins(
                        fontSize: 11, fontWeight: FontWeight.w300),
                  ),
                ],
              );
            }

            List<String> playlistNames = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.transparent,
                ),
                itemCount: playlistNames.length,
                itemBuilder: (context, index) {
                  String playlistName = playlistNames[index];
                  return ListTile(
                    horizontalTitleGap: 12,
                    leading: Container(
                      width: 60,
                      height: 130,
                      decoration: const BoxDecoration(
                        // color: Constants.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: const Icon(
                        Icons.playlist_play_rounded,
                        // color: Constants.white,
                        size: 35,
                      ),
                    ),
                    title: Text(playlistName),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: TextButton(
                              onPressed: () async {
                                Get.back();
                                deleteComfirmationDialogWidget(
                                    context: context,
                                    onPressed: () async {
                                      await dbFunctions
                                          .deletePlaylist(playlistName);
                                      playlistController.refreshTheApp();
                                      Get.back();
                                      toastMessageWidget(
                                        message:
                                            "The playlist list deleted permanently ❗",
                                        gravity: ToastGravity.TOP,
                                      );
                                    },
                                    deleteConfirmMessage:
                                        'Are you sure you want to delete the playlist $playlistName ?');
                              },
                              child: Text(
                                "Delete the playlist",
                                style: GoogleFonts.poppins(
                                  color: settingsController.isDarkMode.value
                                      ? Constants.black
                                      : Constants.white,
                                ),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            child: TextButton(
                              onPressed: () async {
                                Get.back();
                                await renamePlaylist(context, playlistName);
                              },
                              child: Text(
                                "Rename the playlist",
                                style: GoogleFonts.poppins(
                                  color: settingsController.isDarkMode.value
                                      ? Constants.black
                                      : Constants.white,
                                ),
                              ),
                            ),
                          ),
                        ];
                      },
                    ),
                    onTap: () {
                      Get.to(PlaylistDetailsView(
                        playlistName: playlistName,
                        dbFunctions: dbFunctions,
                      ));
                    },
                  );
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        // backgroundColor: Constants.black,
        onPressed: () {
          createPlaylistDialogWidget(context, dbFunctions, playlistController);
        },
        label: Text(
          'create playlist',
          style: GoogleFonts.poppins(
            color: settingsController.isDarkMode.value
                ? Constants.black
                : Constants.white,
          ),
        ),
      ),
    );
  }

  Future<void> renamePlaylist(BuildContext context, String playlistName) async {
    String? newPlaylistName = await renamePlaylistDialogWidget(
        context: context, oldName: playlistName);

    if (newPlaylistName!.isNotEmpty) {
      await dbFunctions.renamePlaylist(
        oldPlaylistName: playlistName,
        newPlaylistName: newPlaylistName,
      );

      playlistController.refreshTheApp();
      toastMessageWidget(
        message: "Playlist renamed to $newPlaylistName ✨",
        gravity: ToastGravity.TOP,
      );
      Get.back();
    }
  }
}

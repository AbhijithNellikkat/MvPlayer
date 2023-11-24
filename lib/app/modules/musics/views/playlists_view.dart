import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_player/app/modules/musics/controllers/playlist_controller.dart';
import 'package:mv_player/app/modules/musics/views/playlist_details_view.dart';

import '../../../common/widgets/toast_message_widget.dart';
import '../../../data/db_functions.dart';
import '../../../utils/constants/constants.dart';
import '../widgets/create_playlist_dialog_widget.dart';

class PlaylistsView extends StatelessWidget {
  PlaylistsView({Key? key}) : super(key: key);

  final PlaylistController playlistController = Get.find();
  final DbFunctions dbFunctions = DbFunctions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldBgColor,
      body: GetBuilder<PlaylistController>(builder: (context) {
        return FutureBuilder<List<String>>(
          future: dbFunctions
              .getPlaylistNames(), // Assuming you have a method to get playlist names
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
                        color: Constants.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: const Icon(
                        Icons.playlist_play_rounded,
                        color: Constants.white,
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
                                await dbFunctions.deletePlaylist(playlistName);
                                playlistController.refreshTheApp();
                                toastMessageWidget(
                                  message:
                                      "The playlist list deleted permanently ❗",
                                  gravity: ToastGravity.TOP,
                                );
                                Get.back();
                              },
                              child: Text(
                                "Delete the playlist",
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            child: TextButton(
                              onPressed: () async {
                                String? newPlaylistName =
                                    await showRenameDialog(
                                        context, playlistName);

                                if (newPlaylistName!.isNotEmpty) {
                                  await dbFunctions.renamePlaylist(
                                    oldPlaylistName: playlistName,
                                    newPlaylistName: newPlaylistName,
                                  );

                                  playlistController.refreshTheApp();
                                  toastMessageWidget(
                                    message:
                                        "Playlist renamed to $newPlaylistName ✨",
                                    gravity: ToastGravity.TOP,
                                  );
                                  Get.back();
                                }
                              },
                              child: Text(
                                "Rename the playlist",
                                style: GoogleFonts.poppins(),
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
        backgroundColor: Constants.black,
        onPressed: () {
          createPlaylistDialogWidget(context, dbFunctions, playlistController);
        },
        label: Text(
          'create playlist',
          style: GoogleFonts.poppins(color: Constants.white),
        ),
      ),
    );
  }
}

Future<String?> showRenameDialog(BuildContext context, String oldName) async {
  TextEditingController newNameController = TextEditingController();

  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Rename Playlist"),
        content: TextField(
          controller: newNameController,
          decoration: InputDecoration(hintText: "Enter new name"),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(newNameController.text.trim());
            },
            child: Text("Rename"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop("");
            },
            child: Text("Cancel"),
          ),
        ],
      );
    },
  );
}

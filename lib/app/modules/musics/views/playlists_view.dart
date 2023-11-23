import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_player/app/modules/musics/controllers/playlist_controller.dart';
import 'package:mv_player/app/modules/musics/controllers/tracks_controller.dart';
import 'package:mv_player/app/modules/musics/views/playlist_details_view.dart';

import '../../../data/db_functions.dart';
import '../../../utils/constants/constants.dart';

// ignore: must_be_immutable
class PlaylistsView extends StatelessWidget {
  PlaylistsView({Key? key}) : super(key: key);

  final PlaylistController playlistController = Get.find();
  final TracksController tracksController = Get.find();
  final DbFunctions dbFunctions = DbFunctions();
  var box = Hive.box(Constants.boxName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<PlaylistController>(builder: (context) {
        return FutureBuilder<List<String>>(
          future: dbFunctions
              .getPlaylistNames(), // Assuming you have a method to get playlist names
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
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
                    'No playlists here ',
                    style: GoogleFonts.poppins(fontSize: 11),
                  ),
                ],
              );
            }

            List<String> playlistNames = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: playlistNames.length,
                itemBuilder: (context, index) {
                  String playlistName = playlistNames[index];
                  return Card(
                    child: ListTile(
                      title: Text(playlistName),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: TextButton(
                                onPressed: () async {
                                  await dbFunctions
                                      .deletePlaylist(playlistName);
                                  playlistController.refreshTheApp();
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
                                onPressed: () {},
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
                    ),
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
          showCreatePlaylistDialog(context, dbFunctions, playlistController);
        },
        label: Text(
          'create playlist',
          style: GoogleFonts.poppins(color: Constants.white),
        ),
      ),
    );
  }
}

Future<void> showCreatePlaylistDialog(BuildContext context,
    DbFunctions dbFunctions, PlaylistController playlistController) async {
  final TextEditingController playlistNameController = TextEditingController();
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Create New Playlist'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Playlist Name',
            ),
            controller: playlistNameController,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final String playlistName = playlistNameController.text.trim();
              await dbFunctions.createPlaylist(
                playlistName: playlistName,
                songs: [],
              );
              playlistNameController.clear();
              playlistController.refreshTheApp();
              Get.back();
            },
            child: const Text('Create Playlist'),
          ),
        ],
      ),
    ),
  );
}

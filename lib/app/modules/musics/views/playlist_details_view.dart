import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_player/app/data/db_functions.dart';
import 'package:mv_player/app/modules/musics/controllers/tracks_controller.dart';
import 'package:mv_player/app/modules/musics/views/music_player_view.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../common/widgets/toast_message_widget.dart';
import '../../../utils/styles/text_styles.dart';

class PlaylistDetailsView extends StatefulWidget {
  PlaylistDetailsView({
    Key? key,
    required this.playlistName,
    required this.dbFunctions,
  }) : super(key: key);

  final DbFunctions dbFunctions;
  final String playlistName;
  final TracksController tracksController = Get.find();

  @override
  // ignore: library_private_types_in_public_api
  _PlaylistDetailsViewState createState() => _PlaylistDetailsViewState();
}

class _PlaylistDetailsViewState extends State<PlaylistDetailsView> {
  late ValueNotifier<List<SongModel>> playlistNotifier;

  @override
  void initState() {
    super.initState();
    playlistNotifier = ValueNotifier<List<SongModel>>([]);
    fetchAndSetPlaylist();
  }

  Future<void> fetchAndSetPlaylist() async {
    List<SongModel> playlist =
        await widget.dbFunctions.getPlaylist(widget.playlistName);
    playlistNotifier.value = playlist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playlistName),
      ),
      body: ValueListenableBuilder<List<SongModel>>(
        valueListenable: playlistNotifier,
        builder: (context, playlist, _) {
          if (playlist.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset(Constants.emptyBoxAnimation),
                ),
                Text(
                  'No songs in the playlist.',
                  style: GoogleFonts.poppins(fontSize: 11),
                )
              ],
            );
          }

          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              SongModel song = playlist[index];
              return ListTile(
                leading: QueryArtworkWidget(
                  artworkFit: BoxFit.cover,
                  artworkQuality: FilterQuality.high,
                  artworkBorder: const BorderRadius.all(Radius.circular(15)),
                  artworkHeight: 130,
                  artworkWidth: 60,
                  id: song.id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: Container(
                    width: 60,
                    height: 130,
                    decoration: const BoxDecoration(
                      color: Constants.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: const Icon(
                      Constants.music,
                      color: Constants.white,
                    ),
                  ),
                ),
                title: Text(
                  song.title,
                  style: musicListTitleStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  song.artist == "<unknown>"
                      ? "Unknown Artist"
                      : '${song.artist}',
                  style: musicArtistStyle,
                ),
                trailing: PopupMenuButton(
                  elevation: 1,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Add to favorites",
                              style: GoogleFonts.poppins(),
                            )),
                      ),
                      PopupMenuItem(
                        child: TextButton(
                          onPressed: () async {
                            // Delete the song from the playlist
                            await widget.dbFunctions.deleteSongFromPlaylist(
                              playlistName: widget.playlistName,
                              song: song,
                            );
                            Get.back();
                            // Fetch and update the playlist
                            toastMessageWidget(
                                message:
                                    '${song.title} deleted from ${widget.playlistName}❗',
                                gravity: ToastGravity.TOP);
                            await fetchAndSetPlaylist();
                          },
                          child: Text(
                            "Delete from this playlist",
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      ),
                    ];
                  },
                ),
                onTap: () {
                  Get.to(MusicPlayerView(
                    songs: playlist,
                    index: index,
                  ));
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.black,
        onPressed: () async {
          List<SongModel> allSongs =
              await widget.tracksController.fetchAllSongs();

          Get.bottomSheet(
            backgroundColor: Constants.black,
            SizedBox(
              width: double.maxFinite,
              height: 400,
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 10),
                child: ListView.builder(
                  itemCount: allSongs.length,
                  itemBuilder: (context, index) {
                    SongModel song = allSongs[index];
                    return ListTile(
                      leading: QueryArtworkWidget(
                        artworkFit: BoxFit.cover,
                        artworkQuality: FilterQuality.high,
                        artworkBorder:
                            const BorderRadius.all(Radius.circular(15)),
                        artworkHeight: 130,
                        artworkWidth: 60,
                        id: song.id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: Container(
                          width: 60,
                          height: 130,
                          decoration: const BoxDecoration(
                            color: Constants.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: const Icon(
                            Constants.music,
                            color: Constants.black,
                          ),
                        ),
                      ),
                      title: Text(
                        song.title,
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Constants.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        song.artist == "<unknown>"
                            ? "Unknown Artist"
                            : '${song.artist}',
                        style: GoogleFonts.poppins(
                            fontSize: 9,
                            fontWeight: FontWeight.w300,
                            color: Constants.white),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          // Add the song to the playlist
                          await widget.dbFunctions.addSongToPlaylist(
                            playlistName: widget.playlistName,
                            song: song,
                          );

                          // Fetch and update the playlist
                          await fetchAndSetPlaylist();
                        },
                        icon: const Icon(Icons.add),
                      ),
                      onTap: () {
                        Get.to(MusicPlayerView(
                          songs: allSongs,
                          index: index,
                        ));
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Constants.white,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/data/db_functions.dart';
import 'package:mv_player/app/modules/musics/controllers/favourites_controller.dart';
import 'package:mv_player/app/modules/musics/controllers/tracks_controller.dart';
import 'package:mv_player/app/modules/settings/controllers/settings_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../common/widgets/toast_message_widget.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/styles/text_styles.dart';
import '../widgets/add_to_playlist_dialog_widget.dart';
import 'music_player_view.dart';

// ignore: must_be_immutable
class TracksView extends StatelessWidget {
  final TracksController tracksController = Get.find();

  final TextEditingController searchController = TextEditingController();
  final FavouritesController favouritesController = Get.find();

  final SettingsController settingsController = Get.find();

  final DbFunctions dbFunctions = DbFunctions();
  TracksView({super.key});

  late SongModel selectedSong;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Constants.scaffoldBgColor,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          controller: searchController,
          onChanged: (query) {
            tracksController.filterSongs(query);
          },
          showCursor: true,
          // cursorColor: Constants.black,
          style: GoogleFonts.poppins(
            // color: Constants.black,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: GoogleFonts.poppins(color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.close_outlined,
              color: Colors.grey,
            ),
            onPressed: () {
              tracksController.filterSongs('');
              searchController.clear();
            },
          ),
        ],
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.only(top: 12),
          child: ListView.separated(
            separatorBuilder: (context, index) =>
                const Divider(color: Colors.transparent),
            itemCount: tracksController.displayedSongs.length,
            itemBuilder: (context, index) {
              // SongModel song = tracksController.displayedSongs[index];
              return ListTile(
                leading: QueryArtworkWidget(
                  artworkFit: BoxFit.cover,
                  artworkQuality: FilterQuality.high,
                  artworkBorder: const BorderRadius.all(Radius.circular(15)),
                  artworkHeight: 130,
                  artworkWidth: 60,
                  id: tracksController.displayedSongs[index].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: Container(
                    width: 60,
                    height: 130,
                    decoration: BoxDecoration(
                      color: settingsController.isDarkMode.value
                          ? Constants.white
                          : Constants.black,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Icon(
                      Constants.music,
                      color: settingsController.isDarkMode.value
                          ? Constants.black
                          : Constants.white,
                    ),
                  ),
                ),
                title: Text(
                  tracksController.displayedSongs[index].title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  tracksController.displayedSongs[index].artist == "<unknown>"
                      ? "Unknown Artist"
                      : '${tracksController.displayedSongs[index].artist}',
                  style: musicArtistStyle,
                ),
                trailing: PopupMenuButton(
                  elevation: 1,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: TextButton(
                          onPressed: () async {
                            favouritesController.addSongToFavourites(
                                tracksController.displayedSongs[index]);
                            Get.back();
                            toastMessageWidget(
                                message:
                                    '${tracksController.displayedSongs[index].title} added to favourites ❤',
                                gravity: ToastGravity.TOP);
                          },
                          child: Text(
                            "Add to favorites",
                            style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
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
                            selectedSong =
                                tracksController.displayedSongs[index];
                            Get.back();

                            await songAddToPlaylistDialogWidget(
                                context: context,
                                dbFunctions: dbFunctions,
                                selectedSong: selectedSong);
                            Get.back();
                          },
                          child: Text(
                            "Add to Playlist",
                            style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              color: settingsController.isDarkMode.value
                                  ? Constants.black
                                  : Constants.white,
                            ),
                          ),
                        ),
                      ),
                      // PopupMenuItem(
                      //   child: TextButton(
                      //     onPressed: () {
                      //       // Delete from device functionality
                      //     },
                      //     child: Text(
                      //       "Delete from device",
                      //       style: TextStyle(
                      //         fontFamily: GoogleFonts.poppins().fontFamily,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // PopupMenuItem(
                      //   child: TextButton(
                      //     onPressed: () async {
                      //       Get.back();
                      //     },
                      //     child: Text(
                      //       "Rename",
                      //       style: TextStyle(
                      //         fontFamily: GoogleFonts.poppins().fontFamily,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ];
                  },
                ),
                onTap: () {
                  Get.to(
                    MusicPlayerView(
                      songs: tracksController.displayedSongs,
                      index: index,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

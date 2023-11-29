// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_player/app/common/widgets/toast_message_widget.dart';
import 'package:mv_player/app/modules/musics/controllers/music_player_controller.dart';
import 'package:mv_player/app/modules/musics/views/music_player_view.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/styles/text_styles.dart';
import '../controllers/favourites_controller.dart';
import '../widgets/delete_comfirmation_dialog_widget.dart';

// ignore: must_be_immutable
class FavouritesView extends StatelessWidget {
  FavouritesView({Key? key}) : super(key: key);

  final FavouritesController favouritesController = Get.find();
  final MusicPlayerController musicPlayerController = Get.find();
  late var favSongs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.black,
        actions: [
          IconButton(
              onPressed: () {
                musicPlayerController.playTheSong(
                    songmodel: favSongs, index: 0);
              },
              icon: const Icon(
                Icons.play_circle_fill_outlined,
                size: 44,
                color: Constants.white,
              )),
          const SizedBox(width: 20)
        ],
      ),
      body: GetBuilder<FavouritesController>(
        builder: (controller) {
          favSongs = controller.getFavoriteSongs();

          if (favSongs.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset(Constants.emptyBoxAnimation),
                ),
                Text(
                  'No favourite songs yet ❗',
                  style: GoogleFonts.poppins(fontSize: 11),
                ),
              ],
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.transparent,
              ),
              itemCount: favSongs.length,
              itemBuilder: (context, index) {
                var song = favSongs[index];
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
                  onTap: () {
                    Get.to(MusicPlayerView(songs: favSongs, index: index));
                  },
                  trailing: IconButton(
                    onPressed: () {
                      Get.back();
                      deleteComfirmationDialogWidget(
                          context: context,
                          deleteConfirmMessage:
                              'Are you sure you want to delete the song ${song.title} ❓',
                          onPressed: () {
                            favouritesController.removeSongFromFavorites(song);
                            Get.back();
                            toastMessageWidget(
                                message:
                                    '${song.title} deleted from favourites❗',
                                gravity: ToastGravity.TOP);
                          });
                    },
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}





// ListView.builder(
//               itemCount: favSongs.length,
//               itemBuilder: (context, index) {
//                 var song = favSongs[index];
//                 return ListTile(
//                   title: Text(song.title),
//                   subtitle: Text(song.artist.toString()),
//                   onTap: () {},
//                   trailing: IconButton(
//                     onPressed: () {
//                       controller.removeSongFromFavorites(song);
//                     },
//                     icon: const Icon(Icons.close),
//                   ),
//                 );
//               },
//             );
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/constants/constants.dart';
import '../controllers/music_player_controller.dart';
import '../controllers/playlist_controller.dart';

final PlaylistController playlistController = Get.find();

void musicPlayerBottomSheet({
  required BuildContext context,
  required MusicPlayerController musicPlayerController,
  required List<SongModel> songs,
  required int index,
}) {
  Get.bottomSheet(
    backgroundColor: Constants.black,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    )),
    enableDrag: true,
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 17, left: 5),
          child: StreamBuilder(
              stream: musicPlayerController.audioPlayer.currentIndexStream,
              builder: (context, snapshot) {
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 15, right: 12, bottom: 10),
                      child: QueryArtworkWidget(
                        nullArtworkWidget: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Constants.black,
                          ),
                          width: 50,
                          height: 50,
                          child: Lottie.asset(
                            Constants.nullArtworkWidget,
                            fit: BoxFit.cover,
                          ),
                        ),
                        artworkQuality: FilterQuality.high,
                        size: MediaQuery.sizeOf(context).width.toInt(),
                        artworkHeight: 50,
                        artworkWidth: 50,
                        artworkBorder:
                            const BorderRadius.all(Radius.circular(15)),
                        id: musicPlayerController.currentlyPlaying.id,
                        type: ArtworkType.AUDIO,
                        artworkFit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          musicPlayerController.currentlyPlaying.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Constants.white),
                        ),
                        Text(
                          songs[index].artist! == "<unknown>"
                              ? "Unknown Artist"
                              : '${musicPlayerController.currentlyPlaying.artist!}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                              fontSize: 9, color: Constants.white),
                        ),
                      ],
                    )
                  ],
                );
              }),
        ),
        const Divider(color: Constants.white, thickness: 0),
        const SizedBox(height: 15),
        ListTile(
          onTap: () {},
          leading: const Icon(
            Icons.playlist_add,
            size: 29,
            color: Constants.white,
          ),
          title: Text(
            'Add to Playlist',
            style: GoogleFonts.poppins(color: Constants.white),
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.timer_outlined,
            size: 29,
            color: Constants.white,
          ),
          title: Text(
            'Sleep timer',
            style: GoogleFonts.poppins(color: Constants.white),
          ),
        ),
        const SizedBox(height: 15),
        const Divider(color: Constants.white, thickness: 0),
        const SizedBox(height: 15),
        GetBuilder<MusicPlayerController>(builder: (controller) {
          return ListTile(
            leading: const Icon(
              Icons.volume_up_outlined,
              size: 29,
              color: Constants.white,
            ),
            title: Slider(
              inactiveColor: Colors.grey,
              activeColor: Constants.white,
              value: controller.volume.value,
              onChanged: (value) {
                controller.setVolume(value);
              },
            ),
          );
        }),
      ],
    ),
  );
}

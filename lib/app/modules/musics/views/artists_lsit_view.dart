import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_player/app/modules/home/controllers/home_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/constants/constants.dart';

class ArtistListView extends StatelessWidget {
  final HomeController homeController = Get.find();

  ArtistListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        if (controller.allArtists.isNotEmpty) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.allArtists.length,
            itemBuilder: (context, index) {
              final artist = controller.allArtists[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      maxRadius: 50,
                      child: QueryArtworkWidget(
                        nullArtworkWidget: Container(
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(300)),
                            color: Constants.black,
                          ),
                          width: 100,
                          height: 100,
                          child: Lottie.asset(Constants.nullArtworkWidget,
                              fit: BoxFit.cover),
                        ),
                        quality: 100,
                        artworkQuality: FilterQuality.high,
                        size: MediaQuery.sizeOf(context).width.toInt(),
                        artworkHeight: 100,
                        artworkWidth: 100,
                        artworkBorder:
                            const BorderRadius.all(Radius.circular(300)),
                        id: artist.id,
                        type: ArtworkType.ARTIST,
                        artworkFit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      artist.artist.toUpperCase(),
                      style: GoogleFonts.poppins(
                          fontSize: 9, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return ListView.builder(
            itemCount: controller.allArtists.length,
            itemBuilder: (context, index) {
              return const CircleAvatar(
                child: Center(
                    child: CircularProgressIndicator(
                  color: Constants.black,
                )),
              );
            },
          );
        }
      },
    );
  }
}

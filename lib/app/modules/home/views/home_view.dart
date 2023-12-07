import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/home/controllers/fetch_local_albums_controller.dart';
import 'package:mv_player/app/modules/home/widgets/a_card.dart';

import '../../../utils/constants/constants.dart';
import '../controllers/nav_bar_controller_controller.dart';
import '../widgets/recently_played_song_slider.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final FetchLocalAlbumsController fetchLocalAlbumsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Recently Played',
                      style: GoogleFonts.poppins(
                          fontSize: 22, fontWeight: FontWeight.w200),
                    ),
                  ),
                  const SizedBox(height: 10),
                  RecentlyPlayedSongSliderWidget(),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Featured Albums',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              if (fetchLocalAlbumsController.allAlbums.isEmpty)
                const Center(child: CircularProgressIndicator())
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        fetchLocalAlbumsController.allAlbums.length,
                        (index) => AlbumCard(
                          album: fetchLocalAlbumsController.allAlbums[index],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}





















              // Padding(
              //   padding: const EdgeInsets.only(
              //       right: 20, left: 30, top: 60, bottom: 20),
              //   child: Text(
              //     'Welcome to MV Player',
              //     style: GoogleFonts.poppins(
              //       fontSize: 23,
              //       fontWeight: FontWeight.w200,
              //     ),
              //   ),
              // ),













// }
// if (tracksController.allAlbums.isEmpty) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: List.generate(
//                           tracksController.allAlbums.length,
//                           (index) => AlbumCard(
//                             album: tracksController.allAlbums[index],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
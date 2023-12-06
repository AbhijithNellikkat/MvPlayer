import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/musics/controllers/tracks_controller.dart';

import '../../../utils/constants/constants.dart';
import '../controllers/nav_bar_controller_controller.dart';
import '../widgets/recently_played_song_slider.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final TracksController tracksController = Get.find();

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
                      'Welcome to Mv player',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                   RecentlyPlayedSongSliderWidget(),
                  // RecentlyPlayedViews(),
                ],
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
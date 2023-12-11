import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/nav_bar_controller_controller.dart';
import '../widgets/local_songs_suggestions_slider_widget .dart';
import '../widgets/recently_played_song_slider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                stretch: true,
                onStretchTrigger: () async {},
                stretchTriggerOffset: 300.0,
                expandedHeight: 400.0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Welcome to Mv Player 👋',
                      style: GoogleFonts.yeonSung(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  background: Image.network(
                    'https://img.freepik.com/free-vector/abstract-flat-line-with-music-note-motion-shapes-pattern-cover-design-poster-banner-decoration_460848-15092.jpg?w=740&t=st=1701967887~exp=1701968487~hmac=e139f3526c60356260c085bb6625c5f84a5477d0405a58c00c4498053aff3402',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 1,
                  (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            'Suggestions',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: LocalSongsSuggestionsSliderWidget(),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            'Recently Played',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                        RecentlyPlayedSongSliderWidget(),
                      ],
                    );
                  },
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
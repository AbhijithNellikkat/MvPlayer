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
          // backgroundColor: Colors.white,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                // backgroundColor: Colors.white,
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
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  // background: Image.asset(
                  //   Constants.homePageBgImage,
                  //   fit: BoxFit.fitWidth,
                  // ),
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

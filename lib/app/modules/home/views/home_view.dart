import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/settings/controllers/settings_controller.dart';
import 'package:mv_player/app/utils/constants/constants.dart';

import '../controllers/nav_bar_controller_controller.dart';
import '../widgets/local_songs_suggestions_slider_widget .dart';
import '../widgets/recently_played_song_slider.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final SettingsController settingsController = SettingsController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark,
                ),
                // backgroundColor: Colors.white,
                stretch: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                onStretchTrigger: () async {},
                stretchTriggerOffset: 300.0,
                expandedHeight: 400.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                            image: NetworkImage(
                              'https://img.freepik.com/free-vector/abstract-flat-line-with-music-note-motion-shapes-pattern-cover-design-poster-banner-decoration_460848-15092.jpg?w=740&t=st=1704177283~exp=1704177883~hmac=516d5676c52fb8621989346dd67175f9cbee83383865196b07351f3ef0e6415f',
                            ),
                            fit: BoxFit.cover),
                      ),
                      height: double.infinity,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Welcome to Mv Player 👋',
                              style: GoogleFonts.yeonSung(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: settingsController.isDarkMode.value
                                      ? Constants.white
                                      : Constants.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  centerTitle: true,
                  // title: Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: Text(
                  //     'Welcome to Mv Player 👋',
                  //     style: GoogleFonts.yeonSung(
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),
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

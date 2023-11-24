import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/home/controllers/home_controller.dart';
import 'package:mv_player/app/modules/musics/controllers/music_player_controller.dart';
import 'package:mv_player/app/modules/musics/controllers/tracks_controller.dart';
import 'package:mv_player/app/modules/musics/widgets/my_favourties_widget.dart';

import '../../recentlyPlayed/views/recently_played_view.dart';
import '../controllers/nav_bar_controller_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CarouselController carouselController = CarouselController();
  final HomeController homeController = Get.find();
  final TracksController tracksController = Get.find();
  final MusicPlayerController musicPlayerController = Get.find();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 30, top: 60, bottom: 20),
                  child: Text(
                    'Welcome to MV Player',
                    style: GoogleFonts.poppins(
                      fontSize: 23,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CarouselSlider(
                      items: [
                        Row(
                          children: [
                            Container(
                              height: 150,
                              width: 140,
                              decoration: BoxDecoration(color: Colors.black),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 150,
                              width: 140,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 139, 13, 13)),
                            ),
                          ],
                        ),
                      ],
                      carouselController: carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        height: 170,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const MyFavouritesWidget(),
                const SizedBox(height: 10),
                const RecentlyPlayedView(),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CarouselSlider(
                      items: [
                        Row(
                          children: [
                            Container(
                              height: 150,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 9, 193, 255)),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 150,
                              width: 140,
                              decoration: BoxDecoration(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                      carouselController: carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        height: 170,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}


// imageList
//                         .map((item) => Image.asset(
//                               item['image_path'],
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                             ))
//                         .toList()
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/musics/views/widgets/my_favourties_widget.dart';

import '../../recentlyPlayed/views/recently_played_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List imageList = [
    {"id": 1, "image_path": 'assets/images/music_onbording.jpg'},
    {"id": 2, "image_path": 'assets/images/video_onbording.jpg'},
    {"id": 3, "image_path": 'assets/images/authentication_onbording.jpg'},
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                  'Welcome Abhijith',
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              Stack(
                children: [
                  InkWell(
                    onTap: () {},
                    child: CarouselSlider(
                      items: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black,
                          ),
                          width: 310,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black,
                          ),
                          width: 310,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black,
                          ),
                          width: 310,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black,
                          ),
                          width: 310,
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
                ],
              ),
              const SizedBox(height: 10),
              MyFavouritesWidget(),
              const SizedBox(height: 10),
              RecentlyPlayedView(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


// imageList
//                         .map((item) => Image.asset(
//                               item['image_path'],
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                             ))
//                         .toList()
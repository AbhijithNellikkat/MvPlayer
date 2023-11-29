import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/data/db_functions.dart';
import 'package:mv_player/app/modules/home/controllers/home_controller.dart';
import 'package:mv_player/app/modules/musics/controllers/music_player_controller.dart';
import 'package:mv_player/app/modules/musics/controllers/tracks_controller.dart';
import 'package:mv_player/app/modules/musics/widgets/my_favourties_widget.dart';
import 'package:mv_player/app/utils/constants/constants.dart';

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

  final DbFunctions dbFunctions = DbFunctions();

  int currentIndex = 0;

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.black,
          elevation: 2,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
              // InkWell(
              //   onTap: () {},
              //   child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 30),
              //       child: FutureBuilder(
              //         future: dbFunctions.getRecentlyPlayed(),
              //         builder: (context, snapshot) {
              //           if (snapshot.connectionState ==
              //               ConnectionState.waiting) {
              //             return const CircularProgressIndicator();
              //           } else if (snapshot.hasError) {
              //             return Text('Error : ${snapshot.error}');
              //           }
              //           final recentlyPlayed = snapshot.data ?? [];
              //           return CarouselSlider(
              //             items: [
              //               GridView.builder(
              //                 itemCount: recentlyPlayed.length,
              //                 gridDelegate:
              //                     const SliverGridDelegateWithFixedCrossAxisCount(
              //                   crossAxisCount: 1,
              //                 ),
              //                 scrollDirection: Axis.horizontal,
              //                 itemBuilder: (context, index) {
              //                   final song = recentlyPlayed[index];
              //                   return QueryArtworkWidget(
              //                     artworkFit: BoxFit.cover,
              //                     artworkQuality: FilterQuality.high,
              //                     artworkBorder: const BorderRadius.all(
              //                         Radius.circular(15)),
              //                     artworkHeight: 130,
              //                     artworkWidth: 130,
              //                     id: song.id,
              //                     type: ArtworkType.AUDIO,
              //                     nullArtworkWidget: Container(
              //                       width: 60,
              //                       height: 130,
              //                       decoration: const BoxDecoration(
              //                         color: Constants.black,
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(15),
              //                         ),
              //                       ),
              //                       child: const Icon(
              //                         Constants.music,
              //                         color: Constants.white,
              //                       ),
              //                     ),
              //                   );
              //                 },
              //               ),
              //             ],
              //             carouselController: carouselController,
              //             options: CarouselOptions(
              //               scrollPhysics: const BouncingScrollPhysics(),
              //               autoPlay: true,
              //               height: 170,
              //               aspectRatio: 16 / 9,
              //               viewportFraction: 1,
              //               onPageChanged: (index, reason) {
              //                 setState(() {
              //                   currentIndex = index;
              //                 });
              //               },
              //             ),
              //           );
              //         },
              //       )),
              // ),

              const SizedBox(height: 10),
              const MyFavouritesWidget(),
              const SizedBox(height: 10),
              const RecentlyPlayedView(),
              const SizedBox(height: 20),
            ],
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
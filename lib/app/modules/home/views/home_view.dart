import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  TextEditingController textController = TextEditingController();
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AnimSearchBar(
                  rtl: true,
                  onSubmitted: (p0) {},
                  width: 400,
                  textController: textController,
                  onSuffixTap: () {},
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Text(
                  'Welcome Abhijith',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
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
                          height: 50,
                          width: 300,
                          color: Colors.black,
                        ),
                        Container(
                          height: 50,
                          width: 300,
                          color: Colors.black,
                        ),
                        Container(
                          height: 50,
                          width: 300,
                          color: Colors.black,
                        ),
                        Container(
                          height: 50,
                          width: 300,
                          color: Colors.black,
                        ),
                      ],
                      carouselController: carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 1,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),
                  )
                ],
              )
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
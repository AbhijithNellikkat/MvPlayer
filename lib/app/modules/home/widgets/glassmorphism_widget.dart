import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../data/db_functions.dart';
import '../../../utils/constants/constants.dart';

class Glassmorphism extends StatelessWidget {
  final double blur;
  final double opacity;
  final double radius;
  final Widget child;

  Glassmorphism({
    Key? key,
    required this.blur,
    required this.opacity,
    required this.radius,
    required this.child,
  }) : super(key: key);

  final DbFunctions dbFunctions = DbFunctions();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dbFunctions.getRecentlyPlayed(), // Updated function
      builder: (context, AsyncSnapshot<List<SongModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final recentlyPlayed = snapshot.data ?? [];

        if (recentlyPlayed.isNotEmpty) {
          return CarouselSlider.builder(
            itemCount: recentlyPlayed.length,
            options: CarouselOptions(
              height: 290,
              autoPlay: true,
              viewportFraction: 0.55,
              enlargeCenterPage: true,
              pageSnapping: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(seconds: 2),
            ),
            itemBuilder: (context, itemIndex, pageViewIndex) {
              final song = recentlyPlayed[itemIndex];

              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(opacity),
                      borderRadius: BorderRadius.all(Radius.circular(radius)),
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              Constants.authenticationOnboringImage,
                            ),
                            fit: BoxFit.cover),
                      ),
                      height: double.infinity,
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}

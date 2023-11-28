import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_player/app/modules/musics/widgets/my_favourties_widget.dart';

import '../../../utils/constants/constants.dart';

class FavouritesView extends GetView {
  const FavouritesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 30),
           MyFavouritesWidget(),
          const SizedBox(height: 120),
          Column(
            children: [
              Center(
                child: Lottie.asset(Constants.emptyBoxAnimation),
              ),
              Text(
                'No songs here',
                style: GoogleFonts.poppins(fontSize: 11),
              )
            ],
          )
        ],
      ),
    );
  }
}

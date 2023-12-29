import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/routes/app_pages.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:mv_player/app/utils/styles/text_styles.dart';

import '../controllers/onbording_controller.dart';

class OnbordingView extends GetView<OnbordingController> {
  const OnbordingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: OnBoardingSlider(
            centerBackground: true,
            headerBackgroundColor: Constants.white,
            finishButtonTextStyle: finishButtonTextStyle,
            onFinish: () {
              Get.offAndToNamed(Routes.BOTTOMNAVIGATIONBAR);
            },
            finishButtonText: Constants.openningScreenHeading,
            skipIcon: const Icon(
              Constants.rightArrow,
              color: Constants.white,
            ),
            finishButtonStyle: const FinishButtonStyle(
                backgroundColor: Constants.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            skipTextButton: Text(
              'Skip',
              style: GoogleFonts.poppins(
                  color: Constants.black, fontWeight: FontWeight.bold),
            ),
            pageBackgroundColor: Constants.white,
            background: [
              Image.asset(Constants.musicOnbordingImage),
              Image.asset(Constants.videoOnbordingImage),
              Image.asset(Constants.authenticationOnboringImage),
            ],
            totalPage: 3,
            speed: 1.8,
            pageBodies: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 480,
                    ),
                    Text(
                      Constants.musicsOnbordingHeading,
                      style: onbordingHeading,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      Constants.musicOnbordingDescription,
                      style: onbordingDescription,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 480,
                    ),
                    Text(
                      Constants.videoOnbordingHeading,
                      style: onbordingHeading,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      Constants.videoOnbordingDescription,
                      style: onbordingDescription,
                    ),
                  ],
                ),
              ),
              Scaffold(
                appBar: AppBar(
                  backgroundColor: Constants.white,
                ),
                backgroundColor: Constants.scaffoldBgColor,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 370,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(Constants.openningBgImage),
                        ),
                      ),
                    ),
                    Text(Constants.openningScreenHeading,
                        style: openningScreenHeading),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Center(
                        child: Text(Constants.musicOnbordingDescription,
                            style: openningScreenDescription),
                      ),
                    ),
                    const SizedBox(
                      height: 140,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/routes/app_pages.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:mv_player/app/utils/constants/images.dart';
import 'package:mv_player/app/utils/styles/text_styles.dart';

import '../controllers/onbording_controller.dart';

class OnbordingView extends GetView<OnbordingController> {
  const OnbordingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OnBoardingSlider(
        centerBackground: true,
        headerBackgroundColor: Colors.white,
        finishButtonTextStyle: const TextStyle(
          fontSize: 13,
        ),
        onFinish: () {
          Get.offAndToNamed(Routes.OPENNING);
        },
        finishButtonText: 'explore the app',
        finishButtonStyle: const FinishButtonStyle(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)))),
        skipTextButton: const Text('Skip'),
        background: [
          Image.asset(ConstantsImages.musicOnbordingImage),
          Image.asset(ConstantsImages.videoOnbordingImage),
          Image.asset(ConstantsImages.authenticationOnboringImage),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 480,
                ),
                Text(
                  Constants.musicsOnbordingHeading,
                  style: onbordingHeading,
                ),
                const Text('Build playlists tailored to your mood'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Description Text 2'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Description Text 2'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

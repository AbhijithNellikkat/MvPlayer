import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/routes/app_pages.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:mv_player/app/utils/styles/text_styles.dart';

import '../controllers/onbording_controller.dart';

class OnbordingView extends GetView<OnbordingController> {
  const OnbordingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OnBoardingSlider(
          centerBackground: true,
          headerBackgroundColor: Constants.white,
          finishButtonTextStyle: const TextStyle(fontSize: 13),
          onFinish: () {
            Get.offAndToNamed(Routes.OPENNING);
          },
          finishButtonText: 'explore the app',
          skipIcon: const Icon(
            Constants.rightArrow,
            color: Constants.white,
          ),
          finishButtonStyle: const FinishButtonStyle(
              backgroundColor: Constants.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)))),
          skipTextButton: const Text(
            'Skip',
            style:
                TextStyle(color: Constants.black, fontWeight: FontWeight.bold),
          ),
          controllerColor: Constants.black,
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 480,
                  ),
                  Text(
                    Constants.authenticaionOnbordingHeading,
                    style: onbordingHeading,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    Constants.authenticationOnbordingDescription,
                    style: onbordingDescription,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

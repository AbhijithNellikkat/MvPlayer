import 'package:flutter/material.dart';

class Constants {
  // ======================= Onbording =======================
  static const musicsOnbordingHeading = 'Enjoy Your Music Anywhere,Anytime ';
  static const musicOnbordingDescription =
      'Build playlists tailored to your mood,activities,and preferences.';

  // ======================= Create Account =======================
  static const createAccountHeading = 'Create Account';

  // ------------------- Vertical Spaces -------------------
  static const formTextFormFieldVerticalSpace = SizedBox(height: 18);
  static const firstTextFormFieldAndHeadingVerticalSpace = SizedBox(height: 40);
  static const textFormFieldAndButtonVerticalSpace = SizedBox(height: 35);
  static const formInputFieldAndLabelVerticalSpace = SizedBox(height: 10);
  static const buttonAndLoginTextVerticalSpace = SizedBox(height: 50);

  // ======================= Login =======================
  static const loginHeading = 'Hi, Welcome 👋';

  // ======================= Splash screen  =======================
  static const appSplashAnimation = "assets/animations/app_splash.json";

  static const passwordTffAndForgotPassVerticalSpace = SizedBox(height: 20);

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

import 'package:flutter/material.dart';

class Constants {
  // ======================= Onbording Screens =======================
  static const musicsOnbordingHeading = 'Enjoy Your Music Anytime ';
  static const musicOnbordingDescription =
      'Build playlists tailored to your mood,activities,and preferences.';

  static const videoOnbordingHeading = 'Create Your Own Playlists';
  static const videoOnbordingDescription =
      'Organize your favorite videos into custom playlists for easy access..';

  static const authenticaionOnbordingHeading =
      'Unlock a World of Possibilities';
  static const authenticationOnbordingDescription =
      "Secure your account to access exclusive features, playlists, and more. Let's ensure your journey is both safe and exciting!";

  // ====================== Openning Screen =======================
  static const openningScreenHeading = 'Explore the App';

  // ======================= Create Account =======================
  static const createAccountHeading = 'Create Account';
  static const alreadyAccount = 'Already have an account ?';

  // ======================= Login =======================
  static const loginHeading = 'Hi, Welcome 👋';
  static const noAccount = "Don't have an account ? ";
  static const forgotPassword = 'Forgot Password ? ';

  // ======================= Images  =======================
  static const appSplashAnimation = "assets/animations/app_splash.json";
  static const emptyBoxAnimation = 'assets/animations/emptyBox.json';

  static const musicOnbordingImage = 'assets/images/music_onbording.jpg';
  static const videoOnbordingImage = 'assets/images/video_onbording.jpg';
  static const authenticationOnboringImage =
      'assets/images/authentication_onbording.jpg';
  static const openningBgImage = 'assets/images/openning_bg_image.jpg';
  static const musicsImage = 'assets/images/musics.jpg';
  static const profileImage = 'assets/images/profile.gif';
  static const splashImage = 'assets/icons/sample logo.jpg';

  static const nullArtworkWidget =
      'assets/animations/musicplayer_nullArtwork.json';

  // ------------------- Vertical Spaces -------------------
  static const formTextFormFieldVerticalSpace = SizedBox(height: 18);
  static const firstTextFormFieldAndHeadingVerticalSpace = SizedBox(height: 40);
  static const textFormFieldAndButtonVerticalSpace = SizedBox(height: 35);
  static const formInputFieldAndLabelVerticalSpace = SizedBox(height: 10);
  static const buttonAndLoginTextVerticalSpace = SizedBox(height: 50);
  static const passwordTffAndForgotPassVerticalSpace = SizedBox(height: 20);

  // ===================== Colors =====================
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color scaffoldBgColor = Colors.white;

  // ===================== Icons =====================
  static const IconData moreVert = Icons.more_vert;
  static const IconData user = Icons.person_pin_circle_rounded;
  static const IconData rightArrow = Icons.arrow_forward;
  static const IconData musicPlayArrow = Icons.play_arrow;
  static const IconData musicPause = Icons.pause;
  static const IconData music = Icons.music_note_rounded;
  static const IconData backArrow = Icons.arrow_back_ios;
  static const IconData shuffle = Icons.shuffle;
  static const IconData shuffleOnsharp = Icons.shuffle_on_sharp;
  static const IconData skipPrevious = Icons.skip_previous;
  static const IconData skipNext = Icons.skip_next;
  static const IconData repeatRounded = Icons.repeat_rounded;
  static const IconData repeatOneOnRounded = Icons.repeat_one_on_rounded;
  static const IconData repeatOnRounded = Icons.repeat_on_rounded;
}

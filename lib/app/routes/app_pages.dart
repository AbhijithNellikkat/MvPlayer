import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/bottom_navbar_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/musics/bindings/musics_binding.dart';
import '../modules/musics/views/favourites_view.dart';
import '../modules/musics/views/music_player_view.dart';
import '../modules/musics/views/musics_view.dart';
import '../modules/onbording/bindings/onbording_binding.dart';
import '../modules/onbording/views/onbording_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile/views/update_profile_view.dart';
import '../modules/recentlyPlayed/bindings/recently_played_binding.dart';
import '../modules/recentlyPlayed/views/recently_played_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/videos/bindings/videos_binding.dart';
import '../modules/videos/views/videos_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBORDING,
      page: () => const OnbordingView(),
      binding: OnbordingBinding(),
    ),
    GetPage(
      name: _Paths.MUSICS,
      page: () => MusicsView(),
      binding: MusicsBinding(),
    ),
    GetPage(
      name: _Paths.VIDEOS,
      page: () => const VideosView(),
      binding: VideosBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOMNAVIGATIONBAR,
      page: () => BottomNavbarView(),
      binding: HomeBinding(),
    ),
   
    GetPage(
      name: _Paths.FAVOURITES,
      page: () => FavouritesView(),
      binding: MusicsBinding(),
    ),
    GetPage(
      name: _Paths.UPDATEPROFILE,
      page: () => UpdateProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.RECENTLY_PLAYED,
      page: () => const RecentlyPlayedView(),
      binding: RecentlyPlayedBinding(),
    ),
    
  ];
}

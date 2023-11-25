import 'package:flutter/material.dart';
import 'package:mv_player/app/utils/constants/constants.dart';

class AppThemes {
  static final darkTheme = ThemeData(
    primaryColor: Constants.black,
    scaffoldBackgroundColor: Constants.black,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: Constants.white,
      backgroundColor: Constants.black,
    ),
  );

  static final lightTheme = ThemeData(
    primaryColor: Constants.white,
    scaffoldBackgroundColor: Constants.white,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: Constants.black,
      backgroundColor: Constants.white,
    ),
  );
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mv_player/app/utils/themes/theme_colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: ThemeColors.primaryColor,
    hintColor: ThemeColors.accentColor,
    backgroundColor: ThemeColors.backgroundColorLight,
    scaffoldBackgroundColor: ThemeColors.backgroundColorLight,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: ThemeColors.textColorLight),
      bodyText2: TextStyle(color: ThemeColors.textColorLight),
      
      
    ),
    // Add more customizations as needed
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: ThemeColors.primaryColor,
    hintColor: ThemeColors.accentColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: ThemeColors.backgroundColorDark,
    scaffoldBackgroundColor: ThemeColors.backgroundColorDark,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: ThemeColors.textColorDark),
      bodyText2: TextStyle(color: ThemeColors.textColorDark),
    ),
    // Add more customizations as needed
  );
}

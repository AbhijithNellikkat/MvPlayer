// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../constants/constants.dart';

class AppThemes {
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      backgroundColor: Constants.white,
      scaffoldBackgroundColor: Constants.white,
      cardTheme: const CardTheme(
        color: Constants.white,
        elevation: 2,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Constants.black,
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Constants.white),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      backgroundColor: Constants.black,
      scaffoldBackgroundColor: Constants.black,
      cardTheme: const CardTheme(
        color: Constants.black,
        elevation: 2,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Constants.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Constants.black,
      ),
    );
  }
}

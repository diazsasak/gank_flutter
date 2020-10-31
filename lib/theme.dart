import 'package:flutter/material.dart';

final mainColor = const Color(0xFF1D2129);

final theme = ThemeData(
  appBarTheme: AppBarTheme(
      color: mainColor,
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      centerTitle: true,
      textTheme: TextTheme(
          headline6: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ))),
  cardColor: const Color(0xFF373B5C),
  primaryColorDark: mainColor,
  primaryColorLight: mainColor,
  backgroundColor: mainColor,
  bottomAppBarColor: mainColor,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: mainColor,
    unselectedItemColor: Colors.white,
  ),
  buttonColor: const Color(0xFF40466A),
  primaryColor: const Color(0xFFB7F331),
  accentColor: const Color(0xFF009688),
  textTheme: TextTheme(
    headline1: TextStyle(
        color: Colors.white, fontSize: 72.0, fontWeight: FontWeight.bold),
    headline2: TextStyle(
        color: Colors.white, fontSize: 30.0, fontStyle: FontStyle.italic),
    headline6: TextStyle(
        color: Colors.white, fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyText1: TextStyle(
        color: Color(0xFFB7F331), fontSize: 10.0, fontWeight: FontWeight.bold),
    bodyText2: TextStyle(
        color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.bold),
  ),
  scaffoldBackgroundColor: const Color(0xFFE0F2F1),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);

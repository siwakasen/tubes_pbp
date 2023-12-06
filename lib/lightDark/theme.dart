import 'package:flutter/material.dart';

class CustomTheme {
  static const lightGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: const [
      0.9,
      0.96,
      0.97,
      0.98,
      0.985,
      0.99,
      0.995,
      0.998,
      1.0,
    ],
    colors: const [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 255, 245, 180),
      Color.fromARGB(255, 253, 230, 170),
      Color.fromARGB(255, 240, 235, 160),
      Color.fromARGB(255, 251, 230, 150),
      Color.fromARGB(255, 252, 225, 145),
      Color.fromARGB(255, 255, 220, 130),
      Color.fromARGB(255, 248, 215, 135),
      Color.fromARGB(255, 254, 210, 130),
    ],
  );

  static const darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: const [
      0.9,
      0.96,
      0.97,
      0.98,
      0.985,
      0.99,
      0.995,
      0.998,
      1.0,
    ],
    colors: const [
      Color.fromARGB(255, 28, 30, 77),
      Color.fromARGB(255, 38, 40, 87),
      Color.fromARGB(255, 48, 50, 97),
      Color.fromARGB(255, 58, 60, 107),
      Color.fromARGB(255, 68, 70, 117),
      Color.fromARGB(255, 78, 80, 127),
      Color.fromARGB(255, 88, 90, 137),
      Color.fromARGB(255, 98, 100, 147),
      Color.fromARGB(255, 108, 110, 157),
    ],
  );
}

ThemeData lightMode = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  cardColor: Colors.white,
);

ThemeData darkMode = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  cardColor: Colors.black,
);

import 'package:flutter/material.dart';
import 'package:ugd2_pbp/lib_tubes/lightDark/theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;

  ThemeData get themeData =>
      isDarkMode ? darkMode : lightMode; // Check for the theme mode

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners(); // Notify listeners to update the theme
  }
}

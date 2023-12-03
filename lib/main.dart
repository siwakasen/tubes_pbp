import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd2_pbp/view/userView/dashboard.dart';
import 'package:ugd2_pbp/view/userView/homeBottom.dart';
import 'package:ugd2_pbp/view/userView/homeUpper.dart';

void main() {
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: HomeViewStf(initialSelectedIndex: 0),
        ),
      ),
    );
  }
}

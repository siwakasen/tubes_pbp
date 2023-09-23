import 'package:flutter/material.dart';
// import 'package:ugd2_pbp/grid.dart';
import 'package:ugd2_pbp/home.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
       home:HomeView(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ugd2_pbp/lib_tubes/LoginNew/loginNew.dart';
import 'package:ugd2_pbp/lib_tubes/lightDark/theme_provider.dart';
import 'package:ugd2_pbp/lib_tubes/order_review_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          home: LoginNew(),
          theme: themeProvider.themeData,
        );
      },
    );
  }
}

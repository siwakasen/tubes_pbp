import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd2_pbp/lib_tubes/history_order_page.dart';
import 'package:ugd2_pbp/lib_tubes/order_complete_page.dart';
import 'package:ugd2_pbp/lib_tubes/order_progress_page.dart';
// import 'package:ugd2_pbp/view/login/login.dart';
import 'package:ugd2_pbp/lib_tubes/order_review_page.dart';
import 'package:ugd2_pbp/lib_tubes/order_note_page.dart';
import 'package:ugd2_pbp/lib_tubes/subscription_page.dart';
import 'package:ugd2_pbp/view/delivery/beli_makan.dart';
import 'package:ugd2_pbp/view/login/login.dart';
import 'package:ugd2_pbp/view/userView/homeBottom.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SubscriptionView(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd2_pbp/lib_tubes/history_order.dart';
import 'package:ugd2_pbp/lib_tubes/order_complete.dart';
import 'package:ugd2_pbp/lib_tubes/order_progress.dart';
// import 'package:ugd2_pbp/view/login/login.dart';
import 'package:ugd2_pbp/lib_tubes/order_review.dart';
import 'package:ugd2_pbp/lib_tubes/order_summary.dart';
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
      home: OrderReviewView(),
    );
  }
}

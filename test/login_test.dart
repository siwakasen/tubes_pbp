import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd2_pbp/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd2_pbp/view/login/login.dart';
import 'package:ugd2_pbp/view/userView/homeBottom.dart';

void main() {
  testWidgets('MainApp displays LoginView', (WidgetTester tester) async {
    print('Before pumpWidget');
    await tester.pumpWidget(MainApp());
    await tester.enterText(find.byType(TextFormField).first, 'riksi');
    await tester.enterText(find.byType(TextFormField).last, 'riksi123');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    await Future.delayed(Duration(seconds: 5));
  });
}

import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/userView/dashboard.dart';
import 'package:ugd2_pbp/view/adminView/addMenu.dart';
import 'package:ugd2_pbp/model/user.dart';
import 'package:ugd2_pbp/view/profile/profile_edit.dart';
import 'package:ugd2_pbp/view/userView/homeUpper.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;
import 'package:ugd2_pbp/view/profile/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // int _currentIndex = 0;
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget widgetSetting() {
    if (selectedIndex == 0) {
      return Home1View();
    }
    if (selectedIndex == 1) {
      return ProfileView(id: widget.id);
    }
    return Text("error cuy");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: globals.isDarkMode ? Colors.white : Colors.white,
          brightness: globals.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: 'Profile'),
            ],
            currentIndex: selectedIndex,
            onTap: onItemTapped,
          ),
          body: widgetSetting(),
        ));
  }
}

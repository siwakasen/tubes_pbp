import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/maps/map.dart';
import 'package:ugd2_pbp/view/userView/homeUpper.dart';
import 'package:ugd2_pbp/view/ratings/list_rating.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;
import 'package:ugd2_pbp/view/profile/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, this.index});
  final int? index;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget widgetSetting() {
    if (widget.index != null) {
      selectedIndex = widget.index!;
    }
    if (selectedIndex == 0) {
      return Home1View();
    }
    if (selectedIndex == 1) {
      return RatingView();
    }
    if (selectedIndex == 2) {
      return OpenMap();
    }
    if (selectedIndex == 3) {
      return ProfileView();
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
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Review',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Map',
              ),
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

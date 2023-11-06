import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/maps/map.dart';
import 'package:ugd2_pbp/view/userView/homeUpper.dart';
import 'package:ugd2_pbp/view/ratings/list_rating.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;
import 'package:ugd2_pbp/view/profile/profile_view.dart';

class HomeViewStf extends StatefulWidget {
  final int initialSelectedIndex;

  HomeViewStf({super.key, this.initialSelectedIndex = 0});

  @override
  State<HomeViewStf> createState() => _HomeViewStfState();
}

int selectedIndex = 0;

class _HomeViewStfState extends State<HomeViewStf> {
  static List<Widget> widgetOptions = <Widget>[
    Home1View(),
    RatingView(),
    OpenMap(),
    ProfileView(),
  ];

  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
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
          body: Center(
            child: widgetOptions.elementAt(selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.amber[800],
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
            onTap: _onItemTapped,
          ),
        ));
  }

  void _onItemTapped(int index) {
    setSelectedIndex(index);
  }
}

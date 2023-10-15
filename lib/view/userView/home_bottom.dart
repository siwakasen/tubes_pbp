import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/userView/home_upper.dart';
import 'package:ugd2_pbp/component/dark_mode_state.dart' as globals;
import 'package:ugd2_pbp/view/profile/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

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
      return const Home1View();
    }
    if (selectedIndex == 1) {
      return const ProfileView();
    }
    return const Text("error cuy");
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

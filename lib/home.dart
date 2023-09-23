import 'package:flutter/material.dart';
import 'package:ugd2_pbp/grid.dart';
import 'package:ugd2_pbp/midscreen.dart';
import 'package:ugd2_pbp/profile.dart';
import 'package:ugd2_pbp/home1.dart';



class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  // int _currentIndex = 0;
  int selectedIndex = 0;

  void onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  static const List<Widget> widgetOptions = <Widget>[
      Home1View(),
      ProfileView()
      
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home,), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person,), label: 'Profile'),
        ],
          currentIndex: selectedIndex,
          onTap: onItemTapped,
        ),
        body: widgetOptions.elementAt(selectedIndex),
      // ),
        
    );
  }
}
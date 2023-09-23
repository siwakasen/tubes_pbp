import 'package:flutter/material.dart';
import 'package:ugd2_pbp/profkel9/profile1.dart';
import 'package:ugd2_pbp/profkel9/profile2.dart';
import 'package:ugd2_pbp/profkel9/profile3.dart';
import 'package:ugd2_pbp/profkel9/profile4.dart';
import 'package:ugd2_pbp/profkel9/profile5.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int _currentIndex = 0;
  // int selectedIndex = 0;

  List<Widget> _tabs = [
    Profile1View(),
    Profile2View(),
    Profile3View(),
    Profile4View(),
    Profile5View(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: globals.isDarkMode ? Colors.white : Colors.white,
            brightness:
                globals.isDarkMode ? Brightness.dark : Brightness.light),
        home: DefaultTabController(
          length: _tabs.length,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.amber[600],
                title: Text('Kelompok 9'),
                bottom: TabBar(
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.person), text: 'Riksi'),
                    Tab(icon: Icon(Icons.person), text: 'Deby'),
                    Tab(icon: Icon(Icons.person), text: 'Raihan'),
                    Tab(icon: Icon(Icons.person), text: 'Alfa'),
                    Tab(icon: Icon(Icons.person), text: 'Davan'),
                  ],
                ),
              ),
              body: TabBarView(
                children: _tabs,
              )),
        ));
  }
}

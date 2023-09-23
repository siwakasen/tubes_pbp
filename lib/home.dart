import 'package:flutter/material.dart';
import 'package:ugd2_pbp/grid.dart';
import 'package:ugd2_pbp/midscreen.dart';
import 'package:ugd2_pbp/profile.dart';



class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  // int _currentIndex = 0;

  final List<Widget> _tabs = [
    GriddView(),
    MidView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[600],
          title: Text('Restoran'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.grid_3x3_outlined), text: 'Fitur1'),
              Tab(icon: Icon(Icons.person), text: 'Profile'),
            ],
          ),
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ),
    );
  }
}
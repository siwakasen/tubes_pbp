import 'package:flutter/material.dart';
import 'package:ugd2_pbp/grid.dart';
import 'package:ugd2_pbp/midscreen.dart';
import 'package:ugd2_pbp/profile.dart';



class Home1View extends StatefulWidget {
  const Home1View({super.key});

  @override
  State<Home1View> createState() => _Home1ViewState();
}

class _Home1ViewState extends State<Home1View> {

  int _currentIndex = 0;
  // int selectedIndex = 0;

  List<Widget> _tabs = [
    GriddView(),
    MidView(),
    MidView(),
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
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.grid_3x3_outlined), text: 'Fitur1'),
              Tab(icon: Icon(Icons.grid_3x3_outlined), text: 'Fitur2'),
            ],
          ),
        ),
        body: TabBarView(
          children: _tabs,)

      ),
    );
  }
}
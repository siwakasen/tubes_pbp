import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/BaruRehan/home_view.dart';
import 'package:ugd2_pbp/view/BaruRehan/maps.dart';
import 'package:ugd2_pbp/view/BaruRehan/ListRestaurant.dart';
import 'package:ugd2_pbp/view/login/login.dart';
import 'package:ugd2_pbp/view/profile/profile_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bottom Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 3) {
        // Show bottom sheet for "More" button
        _showMoreBottomSheet(context);
      }
    });
  }

  void _showMoreBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  // Handle Profile button tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileView(),
                    ),
                  ); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Logout'),
                onTap: () {
                  // Handle Settings button tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ),
                  ); // Close the bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red, // Selected icon color
        unselectedItemColor: Colors.white, // Unselected icon color
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Restaurant',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining),
            label: 'Delivery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return MapsView();
      case 2:
        return Center(child: Text('Order Page'));
      default:
        return Container(); // Placeholder for the "More" page
    }
  }
}

import 'package:flutter/material.dart';
import 'package:ugd2_pbp/lib_tubes/LoginNew/loginNew.dart';
import 'package:ugd2_pbp/lib_tubes/LoginNew/profileViewNew.dart';
import 'package:ugd2_pbp/lib_tubes/home_view.dart';
import 'package:ugd2_pbp/lib_tubes/maps.dart';
// import 'package:ugd2_pbp/view/delivery/beli_makan.dart';

class HomeBottomView extends StatefulWidget {
  final int initialSelectedIndex;
  int lastKnownIndex;
  @override
  HomeBottomView(
      {super.key,
      required this.initialSelectedIndex,
      required this.lastKnownIndex});

  State<HomeBottomView> createState() => _HomeBottomViewState();
}

class _HomeBottomViewState extends State<HomeBottomView> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      widget.lastKnownIndex = _currentIndex;
      _currentIndex = index;
      if (index == 3) {
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
                      builder: (context) => ProfileViewNew(),
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
                      builder: (context) => LoginNew(),
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
      body: _getPage(_currentIndex, widget.lastKnownIndex),
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

  Widget _getPage(int index, lastKnownIndex) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return MapsView();
      case 2:
      // return BeliMakanView();
      case 3:
        {
          if (lastKnownIndex == 0) {
            return HomeView();
          } else if (lastKnownIndex == 1) {
            return MapsView();
          } else if (lastKnownIndex == 2) {
            // return BeliMakanView();
            return Container();
          } else {
            return ProfileViewNew();
          }
        }
      default:
        return Container();
    }
  }
}

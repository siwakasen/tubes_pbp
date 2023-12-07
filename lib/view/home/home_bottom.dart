import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ugd2_pbp/view/delivery/beli_makan.dart';
import 'package:ugd2_pbp/view/login_register/loginNew.dart';
import 'package:ugd2_pbp/view/profile/profileViewNew.dart';
import 'package:ugd2_pbp/view/home/home_view.dart';
import 'package:ugd2_pbp/view/restaurant/ListRestaurant.dart';
import 'package:ugd2_pbp/view/restaurant/maps.dart';
import 'package:ugd2_pbp/view/subscription/subscription_page.dart';

class HomeBottomView extends StatefulWidget {
  int initialSelectedIndex;
  @override
  HomeBottomView({
    super.key,
    required this.initialSelectedIndex,
  });

  State<HomeBottomView> createState() => _HomeBottomViewState();
}

class _HomeBottomViewState extends State<HomeBottomView> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      if (index == 3) {
        _showMoreBottomSheet(context);
      } else {
        _currentIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(widget.initialSelectedIndex != 0
          ? widget.initialSelectedIndex
          : _currentIndex == 3
              ? 6
              : _currentIndex),
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

  void _showMoreBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.subscriptions_sharp),
                title: Text('Subscription'),
                onTap: () {
                  // Handle Profile button tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubscriptionView(),
                    ),
                  ); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  // Handle Profile button tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HomeBottomView(initialSelectedIndex: 6),
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

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return MapsView();
      case 2:
        return BeliMakanView(
          type: 0,
        );
      case 3:
        return ProfileViewNew();
      case 4:
        return RestaurantList();
      case 5:
        //delivery
        return Container();
      case 6:
        //profile
        setState(() {
          widget.initialSelectedIndex = 0;
          _currentIndex = 3;
        });
        return ProfileViewNew();
      default:
        return Container();
    }
  }
}

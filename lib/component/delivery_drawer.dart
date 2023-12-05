import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/userView/homeBottom.dart';

Drawer delivery(BuildContext context) {
  return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.amber,
        ),
        child: Text('Delivery'),
      ),
      ListTile(
        leading: const Icon(Icons.shopping_bag),
        title: const Text('Order'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.alarm),
        title: const Text('History'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => HomeViewStf(
                      initialSelectedIndex: 5,
                    )),
          );
        },
      ),
    ],
  ));
}

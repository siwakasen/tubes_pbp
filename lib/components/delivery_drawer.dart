import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/home/home_bottom.dart';
import 'package:ugd2_pbp/view/order/history_page.dart';
import 'package:ugd2_pbp/view/order/order_progress_page.dart';

Drawer delivery(BuildContext context) {
  return Drawer(
      backgroundColor: Colors.grey[800],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[800],
              ),
              child: Text(
                'Delivery',
                style: TextStyle(
                    color: Colors.white, fontSize: 34, fontFamily: "Poppins"),
              ),
            ),
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.shopping_bag_outlined,
                color: Colors.white, size: 30),
            title: const Text(
              'Order',
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: "Poppins"),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrderProcessView()),
              );
            },
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading:
                const Icon(Icons.lock_clock, color: Colors.white, size: 30),
            title: const Text('History',
                style: TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: "Poppins")),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryOrderView()),
              );
            },
          ),
        ],
      ));
}

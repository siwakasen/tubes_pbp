import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/userView/dashboard.dart';
import 'package:ugd2_pbp/component/dark_mode_state.dart' as globals;
import 'package:ugd2_pbp/view/adminView/list_food.dart';

class Home1View extends StatefulWidget {
  const Home1View({super.key});

  @override
  State<Home1View> createState() => _Home1ViewState();
}

class _Home1ViewState extends State<Home1View> {
  // int selectedIndex = 0;

  final List<Widget> _tabs = [
    const DashboardView(),
    const ListFoodView(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: globals.isDarkMode ? Colors.white : Colors.white,
          brightness: globals.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        home: DefaultTabController(
          length: _tabs.length,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.amber[600],
                title: const Text(
                  'Restoran',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                bottom: const TabBar(
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.dashboard), text: 'Dashboard'),
                    Tab(
                        icon: Icon(Icons.food_bank_sharp),
                        text: 'Add New Menu'),
                  ],
                ),
              ),
              body: TabBarView(
                children: _tabs,
              )),
        ));
  }
}

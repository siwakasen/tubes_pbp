import 'package:flutter/material.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;

class Profile3View extends StatefulWidget {
  const Profile3View({super.key});

  @override
  State<Profile3View> createState() => _Profile3ViewState();
}

class _Profile3ViewState extends State<Profile3View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      Container(
        margin: EdgeInsets.only(top: 20),
        width: 400,
        height: 400,
        child: Column(
          children: [
            CircleAvatar(
                radius: 100, backgroundImage: AssetImage('images/raihan.jpeg')),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('RAIHAN DWI FEBRIAN',
                      style: TextStyle(
                        fontFamily: 'Oswald',
                        fontSize: 30,
                        color: globals.isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('210711440',
                      style: TextStyle(
                        fontFamily: 'Oswald',
                        fontSize: 30,
                        color: globals.isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    ])));
  }
}

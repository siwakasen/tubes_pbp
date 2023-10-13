import 'package:flutter/material.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;

class Profile4View extends StatefulWidget {
  const Profile4View({super.key});

  @override
  State<Profile4View> createState() => _Profile4ViewState();
}

class _Profile4ViewState extends State<Profile4View> {
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
                radius: 100, backgroundImage: AssetImage('images/alfa.jpeg')),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ALFA NADA YULASWARA',
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
                  Text('210711378',
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

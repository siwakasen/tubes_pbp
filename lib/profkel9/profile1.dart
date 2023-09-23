import 'package:flutter/material.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;

class Profile1View extends StatefulWidget {
  const Profile1View({super.key});

  @override
  State<Profile1View> createState() => _Profile1ViewState();
}

class _Profile1ViewState extends State<Profile1View> {
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
                radius: 100, backgroundImage: AssetImage('images/riksi.jpeg')),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('MADE RIKSI PURNAMA',
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
                  Text('210711396',
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

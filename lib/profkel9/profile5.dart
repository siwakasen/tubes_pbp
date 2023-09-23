import 'package:flutter/material.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;

class Profile5View extends StatefulWidget {
  const Profile5View({super.key});

  @override
  State<Profile5View> createState() => _Profile5ViewState();
}

class _Profile5ViewState extends State<Profile5View> {
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
                radius: 100, backgroundImage: AssetImage('images/davan.jpeg')),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DAVAN KHADAFI',
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
                  Text('210711384',
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

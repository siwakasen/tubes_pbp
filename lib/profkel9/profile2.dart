import 'package:flutter/material.dart';

class Profile2View extends StatefulWidget {
  const Profile2View({super.key});

  @override
  State<Profile2View> createState() => _Profile2ViewState();
}

class _Profile2ViewState extends State<Profile2View> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top:20),
              width: 400,
              height: 400,
              child: Column(
                children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('images/deby.jpeg')),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('DEBY JUWITA', style: TextStyle( fontFamily: 'Oswald', fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1,)),
                      
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('210711041', style: TextStyle( fontFamily: 'Oswald', fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1,)),
                      
                    ],
                  ),
                )
              ],
              ),
            ),
          ]
      )
    )
    );
  }
}
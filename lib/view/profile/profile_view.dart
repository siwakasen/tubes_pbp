import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ugd2_pbp/client/userClient.dart';
import 'package:ugd2_pbp/database/sql_helper.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;
import 'package:ugd2_pbp/entity/userEntity.dart';
import 'package:ugd2_pbp/view/profile/profile_edit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_pbp/view/profile/profileCamera.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  DateTime date = DateTime.now();

  @override
  void initState() {
    refresh();
    super.initState();
  }

  List<Map<String, dynamic>> users = [];

  User user = User(
      id: -1,
      username: '',
      email: '',
      password: '',
      name: '',
      address: '',
      bornDate: '',
      phoneNumber: '',
      photo: '');
  late int userId;

  void refresh() async {
    userId = await getIntValuesSF();
    print(userId);
    final data = await UserClient.find(userId);
    setState(() {
      user = data;
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Stack(
              children: [
                if (user.photo == "-") ...[
                  const CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage("images/riksi.jpeg")),
                ] else ...[
                  CircleAvatar(
                      radius: 70,
                      backgroundImage: MemoryImage(
                          const Base64Decoder().convert(user.photo))),
                ],
                // CircleAvatar(
                //     radius: 70,
                //     backgroundImage:
                //         MemoryImage(const Base64Decoder().convert(user.photo))),
                // // CircleAvatar(
                // //     radius: 70,
                // //     backgroundImage: AssetImage("images/riksi.jpeg")),
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: InkWell(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => profileCameraView()))
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: Colors.white,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              50,
                            ),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(2, 4),
                              color: Colors.black.withOpacity(
                                0.3,
                              ),
                              blurRadius: 3,
                            ),
                          ]),
                      child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Icon(Icons.add_a_photo, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            itemProfile('Name', user.name, const Icon(Icons.face)),
            const SizedBox(height: 10),
            itemProfile('Username', user.username, const Icon(Icons.person)),
            const SizedBox(height: 10),
            itemProfile('Phone', user.phoneNumber, const Icon(Icons.phone)),
            const SizedBox(height: 10),
            itemProfile('Address', user.address, const Icon(Icons.home)),
            const SizedBox(height: 10),
            itemProfile('Email', user.email, const Icon(Icons.email)),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    pushEditView(context, widget);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Edit Profile')),
            )
          ],
        ),
      ),
    );
  }

  void pushEditView(BuildContext context, ProfileView widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileEdit(),
      ),
    );
  }

  //profile function
  itemProfile(String title, String subtitle, Icon icon) {
    return Container(
      decoration: BoxDecoration(
          color: globals.isDarkMode ? Colors.black12 : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 1),
                color: globals.isDarkMode ? Colors.black54 : Colors.amber[600]!,
                spreadRadius: 2,
                blurRadius: 2)
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: icon,
        tileColor: globals.isDarkMode ? Colors.black54 : Colors.white,
      ),
    );
  }

  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt('intValue') ?? 0;
    return intValue;
  }
}

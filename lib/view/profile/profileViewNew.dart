import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ugd2_pbp/client/userClient.dart';
import 'package:ugd2_pbp/entity/userEntity.dart';
import 'package:ugd2_pbp/view/profile/editProfileNew.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_pbp/view/profile/profileCamera.dart';

class ProfileViewNew extends StatefulWidget {
  const ProfileViewNew({
    super.key,
  });

  @override
  State<ProfileViewNew> createState() => _ProfileViewNewState();
}

class _ProfileViewNewState extends State<ProfileViewNew> {
  // DateTime date = DateTime.now();

  @override
  void initState() {
    refresh();
    super.initState();
  }

  // List<Map<String, dynamic>> users = [];

  User user = User(
      id: -1,
      username: '',
      email: '',
      password: '',
      name: '',
      address: '',
      bornDate: '',
      phoneNumber: '',
      photo: '',
      idRestaurant: -1);
  late int userId;
  late Response response;
  String imageLink = '-';

  void refresh() async {
    clearMemoryImageCache();
    clearDiskCachedImages();
    userId = await getIntValuesSF();
    print(userId);
    final data = await UserClient.find(userId);

    response = await UserClient.getImageUser(data.photo);
    setState(() {
      imageLink = json.decode(response.body)['data'];
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 40,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  if (user.photo == "-") ...[
                    const CircleAvatar(radius: 70, backgroundImage: null),
                  ] else ...[
                    CircleAvatar(
                      radius: 70,
                      backgroundImage:
                          imageLink != '-' ? NetworkImage(imageLink) : null,
                    )
                  ],
                ],
              ),
              const SizedBox(height: 5),
              Text(user.username,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins')),
              Text(user.email,
                  style: TextStyle(fontSize: 20, fontFamily: 'Poppins')),
              const SizedBox(height: 20),
              itemProfile('Name : ' + user.name),
              const SizedBox(height: 10),
              itemProfile('Username : ' + user.username),
              const SizedBox(height: 10),
              itemProfile('Email : ' + user.email),
              const SizedBox(height: 10),
              itemProfile('Password : ' + user.password),
              const SizedBox(height: 10),
              itemProfile('Address : ' + user.address),
              const SizedBox(height: 10),
              itemProfile('Phone Number : ' + user.phoneNumber),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 180,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 132, 0),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () {
                        pushEditView(context, widget);
                      },
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      )))
            ],
          ),
        ),
      ),
    );
  }

  void pushCameraView(BuildContext context, ProfileViewNew widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => profileCameraView(),
      ),
    ).then((value) => refresh());
  }

  void pushEditView(BuildContext context, ProfileViewNew widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfileNew(),
      ),
    ).then((value) => refresh());
  }

  itemProfile(String title) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 214, 0),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'),
        ),
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

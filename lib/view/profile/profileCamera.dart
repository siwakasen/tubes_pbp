// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_pbp/database/sql_helper.dart';
import 'package:ugd2_pbp/model/user.dart';

import 'package:ugd2_pbp/view/adminView/Utility.dart';
import 'package:ugd2_pbp/view/userView/homeBottom.dart';
import 'package:flutter/material.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class profileCameraView extends StatefulWidget {
  profileCameraView({
    super.key,
  });

  @override
  State<profileCameraView> createState() => _profileCameraViewState();

  final String title = "Profile Picture";
}

class _profileCameraViewState extends State<profileCameraView> {
  String? imgString = '';
  final _formKey = GlobalKey<FormState>();
  XFile? xFile;
  Future<File?>? imageFile;
  Image? imageFromPreferences;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  List<Map<String, dynamic>> users = [];
  User user = User();
  late int userId;
  void refresh() async {
    final data = await SQLHelper.getuser();
    userId = await getIntValuesSF();
    setState(() {
      users = data;
      for (var tempUser in users) {
        if (userId == tempUser['id']) {
          user.username = tempUser['username'];
          user.email = tempUser['email'];
          user.password = tempUser['password'];
          user.name = tempUser['name'];
          user.address = tempUser['address'];
          user.phoneNumber = tempUser['phoneNumber'];
          user.bornDate = tempUser['bornDate'];
          user.photo = tempUser['photo'];
        }
      }
    });
  }

  pickImageFromGallery(ImageSource source) async {
    xFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25);

    if (xFile != null) {
      final image = File(xFile!.path);
      setState(() {
        imageFile = Future.value(image);
      });
    }
  }

  Widget imageFromGallery() {
    return FutureBuilder<File?>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          final imgBytes = snapshot.data!.readAsBytesSync();
          imgString = Utility.base64String(imgBytes);

          Utility.saveImageToPreferences(
              Utility.base64String(snapshot.data!.readAsBytesSync()));
          return CircleAvatar(
            radius: 70,
            backgroundImage: FileImage(
              snapshot.data!,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Wat',
            textAlign: TextAlign.center,
          );
        } else if (imgString != "") {
          return CircleAvatar(
              radius: 70,
              backgroundImage: MemoryImage(
                const Base64Decoder().convert(imgString as String),
              ));
        } else {
          return const CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage("images/riksi.jpeg"),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    imgString = user.photo;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                imageFromGallery(),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 132,
                          0), //background color of button //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(horizontal: 20)),
                  child: const Text(
                    'Ubah Gambar',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    pickImageFromGallery(ImageSource.gallery);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 132,
                          0), //background color of button //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(horizontal: 20)),
                  onPressed: () {
                    globals.setRefresh = 1;
                    SQLHelper.editphoto(userId, imgString!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => HomeViewStf(initialSelectedIndex: 3)),
                    );
                  },
                  child: const Text(
                    'Konfirmasi',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
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

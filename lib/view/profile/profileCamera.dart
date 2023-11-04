import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_pbp/database/sql_helper.dart';
import 'package:ugd2_pbp/model/user.dart';

import 'package:ugd2_pbp/view/adminView/Utility.dart';
import 'package:ugd2_pbp/view/profile/profile_view.dart';
import 'package:ugd2_pbp/view/userView/homeBottom.dart';
import 'package:ugd2_pbp/view/userView/homeUpper.dart';
import 'package:flutter/material.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:ugd2_pbp/database/sql_helperMakanan.dart';
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
  String? ImgString = '';
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
          ImgString = Utility.base64String(imgBytes);

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
        } else if (ImgString != "") {
          return CircleAvatar(
              radius: 70,
              backgroundImage: MemoryImage(
                Base64Decoder().convert(ImgString as String),
              ));
        } else {
          return CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage("images/riksi.jpeg"),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ImgString = user.photo;

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
                SizedBox(
                  height: 20.0,
                ),
                imageFromGallery(),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 132,
                          0), //background color of button //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.only(
                          left: 60, right: 60) //content padding inside button
                      ),
                  child: const Text(
                    'Ubah Gambar',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    pickImageFromGallery(ImageSource.gallery);
                    setState(() {});
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 132,
                          0), //background color of button //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.only(
                          left: 60, right: 60) //content padding inside button
                      ),
                  onPressed: () {
                    globals.setRefresh = 1;
                    SQLHelper.editphoto(userId, ImgString!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeView(),
                      ),
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
    int intValue = await prefs.getInt('intValue') ?? 0;
    return intValue;
  }
}

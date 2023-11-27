// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables

import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_pbp/client/userClient.dart';
import 'package:ugd2_pbp/model/user.dart';

import 'package:ugd2_pbp/view/adminView/Utility.dart';
import 'package:ugd2_pbp/view/userView/homeBottom.dart';
import 'package:flutter/material.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;
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
  String uploadingMessage = '';
  String? imgString = '';
  final _formKey = GlobalKey<FormState>();
  late XFile xFile;
  Future<File?>? imageFile;
  Image? imageFromPreferences;
  File? imageInput;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  User user = User();
  late int userId;
  void refresh() async {
    userId = await getIntValuesSF();
    setState(() {});
  }

  pickImageFromGallery(ImageSource source) async {
    xFile = (await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25))!;

    final image = File(xFile.path);
    imageInput = image;

    setState(() {
      imageFile = Future.value(image);
    });
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
          return Image.memory(
            Base64Decoder().convert(imgString as String),
            fit: BoxFit.cover,
            width: 300,
            height: 200,
          );
        } else {
          return const CircleAvatar(
            radius: 70,
            backgroundImage: null,
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
                //SHOWING IMAGE IS HERE
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
                    //TAKING IMAGE FROM GALERY
                    pickImageFromGallery(ImageSource.gallery);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),

                //Saving image here
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 132, 0),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.only(left: 60, right: 60),
                  ),
                  onPressed: () async {
                    setState(() {
                      uploadingMessage = 'Uploading Image...';
                    });
                    globals.setRefresh = 1;
                    await UserClient.updateImageUser(
                        File(xFile.path), userId, xFile.name);

                    await Future.delayed(Duration(seconds: 1));

                    setState(() {
                      uploadingMessage = 'Success';
                    });
                    await Future.delayed(Duration(milliseconds: 20));
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeViewStf(initialSelectedIndex: 3),
                      ),
                    );
                  },
                  child: const Column(
                    children: [
                      Text(
                        'Konfirmasi',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
                Text(uploadingMessage),
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

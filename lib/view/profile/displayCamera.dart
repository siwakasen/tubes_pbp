// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:ugd2_pbp/database/sql_helper.dart';
// import 'dart:io';
// import 'package:ugd2_pbp/view/adminView/Utility.dart';

// import 'package:ugd2_pbp/utils/logging_utils.dart';
// import 'package:ugd2_pbp/utils/logging_utils.dart';

// class DisplayPictureScreen extends StatefulWidget {
//   final String imagePath;
//   final CameraController cameraController;

//   const DisplayPictureScreen(
//       {Key? key, required this.imagePath, required this.cameraController})
//       : super(key: key);

//   @override
//   State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
// }

// class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
//   File? fileResult;

//   void initState() {
//     fileResult = File(widget.imagePath);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     LoggingUtils.logStartFunction("Build DisplayPictureScreen");
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Display the Picture"),
//       ),
//       body: WillPopScope(
//         onWillPop: () async {
//           widget.cameraController.resumePreview();
//           return true;
//         },
//         child: Image.file(fileResult!),
//       ),
//     );
//   }

//   addImgToSF(File gambar) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('stringValue', base64String(gambar.readAsBytesSync()));
//   }
// }

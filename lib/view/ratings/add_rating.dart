// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, use_build_context_synchronously

import 'dart:io';
import 'package:ugd2_pbp/database/sql_helperRating.dart';
import 'package:ugd2_pbp/view/adminView/Utility.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class InputRating extends StatefulWidget {
  const InputRating(
      {super.key, this.id, this.rateStar, this.textReview, this.namaFoto});
  final String? textReview, namaFoto, rateStar;
  final int? id;

  final String title = "Add New Rating";

  @override
  State<InputRating> createState() => _InputRatingState();
}

class _InputRatingState extends State<InputRating> {
  TextEditingController rateStarController = TextEditingController();
  TextEditingController textReviewController = TextEditingController();
  String? imgString = '';
  final _formKey = GlobalKey<FormState>();
  XFile? xFile;
  Future<File?>? imageFile;
  Image? imageFromPreferences;
  List<Map<String, dynamic>> rating = [];
  void refresh() async {
    final data = await SQLMakanan.getRating();
    setState(() {
      rating = data;
    });
  }

  pickImageFromGallery(ImageSource source) async {
    xFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (xFile != null) {
      final image = File(xFile!.path);
      // String imgString = Utility.base64String(image.readAsBytesSync());
      setState(() {
        imageFile = Future.value(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      rateStarController.text = widget.rateStar!;
      textReviewController.text = widget.textReview!;
      imgString = widget.namaFoto!;
    } else {
      rateStarController.text = '';
      textReviewController.text = '';
      imgString = null;
    }

    Widget imageFromGallery() {
      return FutureBuilder<File?>(
        future: imageFile,
        builder: (BuildContext context, AsyncSnapshot<File?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              null != snapshot.data) {
            final imgBytes = snapshot.data!.readAsBytesSync();
            imgString = Utility.base64String(imgBytes);
            // print(snapshot.data?.path);
            Utility.saveImageToPreferences(
                Utility.base64String(snapshot.data!.readAsBytesSync()));
            return Image.file(
              snapshot.data!,
              fit: BoxFit.cover,
              width: 300,
              height: 200,
            );
          } else if (null != snapshot.error) {
            return const Text(
              'Wat',
              textAlign: TextAlign.center,
            );
          } else if (imgString != null) {
            return Container(
                child: Image.memory(
              const Base64Decoder().convert(imgString as String),
              fit: BoxFit.cover,
              width: 300,
              height: 200,
            ));
          } else {
            return Container(
              width: 300,
              height: 200,
              child: Image.asset('images/placeholder_image.png'),
            );
          }
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: const <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      padding: const EdgeInsets.only(
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
                const SizedBox(height: 20),
                DefaultTextStyle.merge(
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  child: const Center(
                    child: Text('How was the foods?'),
                  ),
                ),
                RatingBar.builder(
                  initialRating: widget.id != null
                      ? double.parse(rateStarController.text)
                      : 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    rateStarController.text = rating.toInt().toString();
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: textReviewController,
                  decoration: const InputDecoration(
                    labelText: 'Tell us more (Optional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.id == null && xFile == null) {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: const Text('Gambar harus ada!'),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () => Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(),
                                        child: const Text('OK')),
                                  ],
                                ));
                      } else if (rateStarController.text == '') {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title:
                                      const Text('Mohon Berikan Rating Anda!'),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () => Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(),
                                        child: const Text('OK')),
                                  ],
                                ));
                      } else {
                        if (widget.id == null) {
                          await SQLMakanan.addRating(rateStarController.text,
                              textReviewController.text, imgString!);
                        } else {
                          await SQLMakanan.editRating(
                              widget.id!,
                              rateStarController.text,
                              textReviewController.text,
                              imgString!);
                        }
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: const Text(
                    'Input',
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
}

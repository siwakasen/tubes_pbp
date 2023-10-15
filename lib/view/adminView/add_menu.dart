import 'dart:io';

import 'package:ugd2_pbp/view/adminView/utility.dart';
import 'package:ugd2_pbp/view/userView/home_upper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:ugd2_pbp/database/sql_helper_makanan.dart';
import 'package:image_picker/image_picker.dart';

class InputMakanan extends StatefulWidget {
  const InputMakanan(
      {super.key, this.id, this.namaMakanan, this.hargaMakanan, this.namaFoto});
  final String? namaMakanan, hargaMakanan, namaFoto;
  final int? id;

  final String title = "Add New Menu";

  @override
  State<InputMakanan> createState() => _InputMakananState();
}

class _InputMakananState extends State<InputMakanan> {
  TextEditingController namaMakananController = TextEditingController();
  TextEditingController hargaMakananController = TextEditingController();
  String? imgString = '';
  final _formKey = GlobalKey<FormState>();
  XFile? xFile;
  Future<File?>? imageFile;
  Image? imageFromPreferences;
  List<Map<String, dynamic>> makanan = [];
  void refresh() async {
    final data = await SQLMakanan.getmakanan();
    setState(() {
      makanan = data;
    });
  }

  pickImageFromGallery(ImageSource source) async {
    xFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      final image = File(xFile!.path);
      // String imgString = Utility.base64String(image.readAsBytesSync());
      setState(() {
        imageFile = Future.value(image);
      });
    }
  }

  // loadImageFromPreferences() {
  //   Utility.getImageFromPreferences().then((img) {
  //     if (null == img) {
  //       return;
  //     }
  //     setState(() {
  //       imageFromPreferences = Utility.imageFromBase64String(img);
  //     });
  //   });
  // }

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
          // ignore: avoid_unnecessary_containers
          return Container(
              child: Image.memory(
            const Base64Decoder().convert(imgString as String),
            fit: BoxFit.cover,
            width: 300,
            height: 200,
          ));
        } else {
          return SizedBox(
            width: 300,
            height: 200,
            child: Image.asset('images/placeholder_image.png'),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      namaMakananController.text = widget.namaMakanan!;
      hargaMakananController.text = widget.hargaMakanan!;
      imgString = widget.namaFoto!;
    } else {
      namaMakananController.text = '';
      hargaMakananController.text = '';
      imgString = null;
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
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                TextFormField(
                    controller: namaMakananController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lunch_dining),
                      labelText: 'Food\'s name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Food\'s name can\'t be empty';
                      } else if (value.length > 12) {
                        return 'Food\'s name can\'t have more than 12 words';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 20),
                TextFormField(
                    controller: hargaMakananController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money_outlined),
                      labelText: 'Price',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Price can\'t be empty';
                      } else {
                        return null;
                      }
                    }),
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
                      } else {
                        if (widget.id == null) {
                          await SQLMakanan.addmakanan(
                              namaMakananController.text,
                              hargaMakananController.text,
                              imgString!);
                        } else {
                          await SQLMakanan.editmakanan(
                              widget.id!,
                              namaMakananController.text,
                              hargaMakananController.text,
                              imgString!);
                        }
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home1View(),
                            ));
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

import 'dart:io';

import 'package:http/http.dart';
import 'package:ugd2_pbp/client/makananClient.dart';
import 'package:ugd2_pbp/entity/makananEntity.dart';
import 'package:ugd2_pbp/view/adminView/Utility.dart';
import 'package:ugd2_pbp/view/userView/homeUpper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
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
  String imgLink = '';
  final _formKey = GlobalKey<FormState>();
  late XFile xFile;
  Future<File?>? imageFile;
  Image? imageFromPreferences;
  late Response response;
  String message = '';
  bool isChoosingImage = false;

  @override
  void initState() {
    getImageLink();
    super.initState();
  }

  void getImageLink() async {
    if (widget.id != null) {
      response = await MakananClient.getImageMakanan(widget.namaFoto!);
      imgLink = json.decode(response.body)['data'];
    }
    setState(() {});
  }

  pickImageFromGallery(ImageSource source) async {
    xFile = (await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25))!;
    final image = File(xFile.path);
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
          print("baru masuk");
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
          print("baru masuk 2");
          return Container(
              child: imgLink == ''
                  ? null
                  : Image.network(
                      imgLink,
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
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                imageFromGallery(),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 132,
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
                    setState(() {
                      isChoosingImage = true;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                    controller: namaMakananController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lunch_dining),
                      labelText: 'Food\'s name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Food\'s name can\'t be empty';
                      } else if (value.length > 20) {
                        return 'Food\'s name can\'t have more than 12 words';
                      } else {
                        return null;
                      }
                    }),
                SizedBox(height: 20),
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.id == null) {
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
                          await MakananClient.create(
                              Makanan(
                                  namaMakanan: namaMakananController.text,
                                  hargaMakanan:
                                      int.parse(hargaMakananController.text),
                                  namaFoto: ''),
                              File(xFile.path));
                        } else {
                          if (isChoosingImage) {
                            await MakananClient.update(
                                Makanan(
                                    namaMakanan: namaMakananController.text,
                                    hargaMakanan:
                                        int.parse(hargaMakananController.text),
                                    namaFoto: ''),
                                widget.id!,
                                File(xFile.path));
                          } else {
                            await MakananClient.updateWithoutImage(
                                Makanan(
                                    namaMakanan: namaMakananController.text,
                                    hargaMakanan:
                                        int.parse(hargaMakananController.text),
                                    namaFoto: ''),
                                widget.id!);
                          }
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home1View(),
                            ));
                      }
                    }
                  },
                  child: const Text(
                    'Input',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text(message),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

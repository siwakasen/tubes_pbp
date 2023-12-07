import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_pbp/client/userClient.dart';
import 'package:ugd2_pbp/view/profile/profileViewNew.dart';
import 'package:ugd2_pbp/theme/theme.dart';
import 'package:ugd2_pbp/theme/theme_provider.dart';

import '../../entity/userEntity.dart';

class EditProfileNew extends StatefulWidget {
  EditProfileNew({
    super.key,
  });

  @override
  State<EditProfileNew> createState() => _EditProfileNewState();
}

class _EditProfileNewState extends State<EditProfileNew> {
  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();

  bool? isChecked = false;
  bool isPasswordVisible = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController bornController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    refresh();
    super.initState();
  }

  late int userId;
  late String photo = "-";
  void refresh() async {
    userId = await getIntValuesSF();
    print(userId);
    final data = await UserClient.find(userId);
    setState(() {
      usernameController.text = data.username;
      emailController.text = data.email;
      passwordController.text = data.password;
      nameController.text = data.name;
      addressController.text = data.address;
      phoneController.text = data.phoneNumber;
      bornController.text = data.bornDate;
      photo = data.photo;
    });
  }

  String uploadingMessage = '';
  String? imgString = '';

  late XFile xFile;
  Future<File?>? imageFile;
  Image? imageFromPreferences;
  File? imageInput;
  pickImageFromGallery(ImageSource source) async {
    xFile = (await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25))!;

    final image = File(xFile.path);
    imageInput = image;

    setState(() {
      imageFile = Future.value(image);
    });
  }

  pickImageFromCamera(ImageSource source) async {
    xFile = (await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25))!;

    final image = File(xFile.path);
    imageInput = image;

    setState(() {
      imageFile = Future.value(image);
    });
  }

  late String username, name, password, email, phoneNumber, address, bornDate;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final gradient = themeProvider.isDarkMode
        ? CustomTheme.darkGradient
        : CustomTheme.lightGradient;
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Stack(
              children: [
                if (photo == "-") ...[
                  const CircleAvatar(radius: 70, backgroundImage: null),
                ] else ...[
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: photo != '-' ? NetworkImage(photo) : null,
                  )
                ],
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: InkWell(
                    onTap: () => _showBottomSheet(context),
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
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Icon(Icons.create_rounded, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text("nickname",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins')),
            Text("aku@gmail.com",
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins')),
            Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.black),
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black, // Change text color
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'Name can\'t be empty';
                        } else if (value!.length <= 1) {
                          return 'Name length must be greater than 1';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.black),
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black, // Change text color
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'Username can\'t be empty';
                        } else if (value!.contains(RegExp(r'\s'))) {
                          return 'Username cant contain space';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color:
                                isPasswordVisible ? Colors.black : Colors.grey,
                          ),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'Password can\'t be empty';
                        } else if (value!.length < 8) {
                          return 'Password length must be greater than 8';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Colors.black),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        cursorColor: Colors.black,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value == '') {
                            return 'Email can\'t be empty';
                          } else if (!value!.contains('@')) {
                            return 'Email must contain @';
                          } else {
                            return null;
                          }
                        }),
                    TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone, color: Colors.black),
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        cursorColor: Colors.black,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value == '') {
                            return 'Phone number can\'t be empty';
                          } else if (value!.length < 10 || value.length > 13) {
                            return 'Phone number must be between 10 - 13';
                          } else {
                            return null;
                          }
                        }),
                    TextFormField(
                        controller: addressController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.home, color: Colors.black),
                          labelText: 'Address',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        cursorColor: Colors.black,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value == '') {
                            return 'Address can\'t be empty';
                          } else if (value!.startsWith(RegExp(r'\s'))) {
                            return 'Address can\'t be start with space';
                          } else {
                            return null;
                          }
                        }),
                    TextFormField(
                        controller: bornController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.calendar_month_outlined,
                              color: Colors.black),
                          suffixIcon:
                              Icon(Icons.calendar_today, color: Colors.black),
                          labelText: 'Born Date',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        readOnly: true,
                        cursorColor: Colors.black,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                        onTap: () async {
                          DateTime? pickDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1500),
                            lastDate: DateTime(2500),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor:
                                      const Color.fromARGB(255, 255, 136, 26),
                                  hintColor:
                                      const Color.fromARGB(255, 255, 136, 26),
                                  colorScheme: const ColorScheme.light(
                                    primary: Color.fromARGB(255, 255, 136, 26),
                                  ),
                                  buttonTheme: const ButtonThemeData(
                                    textTheme: ButtonTextTheme.primary,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (pickDate != null) {
                            String formatDate =
                                DateFormat('yyyy-MM-dd').format(pickDate);
                            bornController.text = formatDate;
                          }
                        },
                        validator: (value) {
                          if (value == '' || value == null) {
                            return 'Date of birth can\'t be empty';
                          } else if (DateFormat('yyyy-MM-dd')
                              .parse(value)
                              .isAfter(DateTime.now())) {
                            return 'Date of birth can\'t be greater than today';
                          }
                          return null;
                        }),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 132, 0),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.only(left: 60, right: 60)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> formData = {};
                          formData['username'] = usernameController.text;
                          formData['email'] = emailController.text;
                          formData['password'] = passwordController.text;
                          formData['name'] = nameController.text;
                          formData['address'] = addressController.text;
                          formData['phoneNumber'] = phoneController.text;
                          formData['borndate'] = bornController.text;
                          UserClient.update(
                              User(
                                id: userId,
                                username: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                address: addressController.text,
                                phoneNumber: phoneController.text,
                                bornDate: bornController.text,
                                photo: photo,
                                id_restaurant: -1,
                              ),
                              userId);
                          Navigator.pop(
                            context,
                            MaterialPageRoute(builder: (_) => ProfileViewNew()),
                          );
                          // }
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 10),
                child: Text(
                  'Change Profile Picture',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                leading: Icon(Icons.camera_alt),
                title: Text('Open Camera'),
                onTap: () {
                  Navigator.pop(context);
                  pickImageFromCamera(ImageSource.camera);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                leading: Icon(Icons.image),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  pickImageFromGallery(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int intValue = prefs.getInt('intValue') ?? 0;
    return intValue;
  }
}

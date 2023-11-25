import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_pbp/client/userClient.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;
import 'package:ugd2_pbp/view/userView/homeBottom.dart';

import '../../entity/userEntity.dart';

class ProfileEdit extends StatefulWidget {
  ProfileEdit({
    super.key,
  });

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
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
  late String photo;
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

  late String username, name, password, email, phoneNumber, address, bornDate;

  // int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    globals.setRefresh = 1;
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: globals.isDarkMode ? Colors.white : Colors.white,
          brightness: globals.isDarkMode ? Brightness.dark : Brightness.light),
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ListTile(
                    title: Text(
                      "Profile",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                    contentPadding: const EdgeInsets.only(top: 50),
                  ),
                  TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'Name can\'t be empty';
                        } else if (value!.length <= 1) {
                          return 'Name length must be greater than 1';
                        } else {
                          return null;
                        }
                      }),
                  TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'Username can\'t be empty';
                        } else if (value!.contains(RegExp(r'\s'))) {
                          return 'Username cant contain space';
                        } else {
                          return null;
                        }
                      }),
                  TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
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
                                  isPasswordVisible ? Colors.blue : Colors.grey,
                            ),
                          )),
                      obscureText: !isPasswordVisible,
                      validator: (value) {
                        if (value == '') {
                          return 'Password can\'t be empty';
                        } else if (value!.length < 5) {
                          return 'Password length must be greater than 8';
                        } else {
                          return null;
                        }
                      }),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == '') {
                        return 'Email can\'t be empty';
                      } else if (!value!.contains('@')) {
                        return 'Email must contain @';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: 'Phone Number',
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
                        prefixIcon: Icon(Icons.home),
                        labelText: 'Address',
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
                          prefixIcon: Icon(Icons.calendar_month_outlined),
                          labelText: 'Born Date',
                          suffixIcon: Icon(Icons.calendar_today)),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1500),
                            lastDate: DateTime(2500));

                        if (pickDate != null) {
                          String formatDate =
                              DateFormat('dd-MM-yyyy').format(pickDate);
                          bornController.text = formatDate;
                        }
                      },
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Date of birth can\'t be empty';
                        } else if (DateFormat('dd-MM-yyyy')
                            .parse(value)
                            .isAfter(DateTime.now())) {
                          return 'Date of birth can\'t be greater than today';
                        }
                        return null;
                      }),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 132,
                            0), //background color of button //border width and color
                        elevation: 3, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.only(
                            left: 60, right: 60) //content padding inside button
                        ),
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
                                photo: photo),
                            userId);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  HomeViewStf(initialSelectedIndex: 3)),
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
              )),
        ),
      ),
    );
  }

  // bool isSameEmail(String email, User userLog) {
  //   for (var user in users) {
  //     if (email == user['email'] && email != userLog.email) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // bool isSameUsername(String username, User userLog) {
  //   for (var user in users) {
  //     if (username == user['username'] && username != userLog.username) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt('intValue') ?? 0;
    return intValue;
  }
}

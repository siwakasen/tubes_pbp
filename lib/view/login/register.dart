import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ugd2_pbp/view/login/login.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;
import 'package:intl/intl.dart';
import 'package:ugd2_pbp/database/sql_helper.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

enum SingingCharacter { male, female }

class _RegisterViewState extends State<RegisterView> {
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

  List<Map<String, dynamic>> users = [];

  void refresh() async {
    final data = await SQLHelper.getuser();
    setState(() {
      users = data;
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool? checkboxIconFormFieldValue = false;
    return MaterialApp(
        theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: globals.isDarkMode ? Colors.white : Colors.white,
            brightness:
                globals.isDarkMode ? Brightness.dark : Brightness.light),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: IconButton(
                        color: const Color(0xFF323232),
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      title: const Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
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
                                color: isPasswordVisible
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            )),
                        obscureText: !isPasswordVisible,
                        validator: (value) {
                          if (value == '') {
                            return 'Password can\'t be empty';
                          } else if (value!.length < 8) {
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
                            print(formatDate);
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
                        }),
                    const SizedBox(height: 30),
                    CheckboxListTileFormField(
                      title: Text("I Agree with terms & condition"),
                      validator: (value) {
                        if (!(value!)) {
                          return 'Must be checked!';
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 132,
                              0), //background color of button //border width and color
                          elevation: 3, //elevation of button
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.only(
                              left: 60,
                              right: 60) //content padding inside button
                          ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> formData = {};
                          formData['username'] = usernameController.text;
                          String user = usernameController.text;
                          formData['email'] = emailController.text;
                          String email = usernameController.text;
                          formData['password'] = passwordController.text;
                          String pass = passwordController.text;
                          formData['name'] = nameController.text;
                          String name = nameController.text;
                          formData['address'] = addressController.text;
                          String address = addressController.text;
                          formData['phoneNumber'] = phoneController.text;
                          String notelp = phoneController.text;
                          formData['borndate'] = bornController.text;
                          String borndate = bornController.text;
                          String photo = "";
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: const Text(
                                        'Apakah sudah yakin data yang diinputkan benar?'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'No'),
                                          child: const Text('No')),
                                      TextButton(
                                        onPressed: () {
                                          if (isSameUsername(
                                              usernameController.text)) {
                                            Navigator.pop(context);
                                            showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                      title: const Text(
                                                          'Username tidak tersedia!'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context,
                                                                    'OK'),
                                                            child: const Text(
                                                                'OK')),
                                                      ],
                                                    ));
                                          } else if (isSameEmail(
                                              emailController.text)) {
                                            Navigator.pop(context);
                                            showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                      title: const Text(
                                                          'Email terdaftar dalam sistem!'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context,
                                                                    'OK'),
                                                            child: const Text(
                                                                'OK')),
                                                      ],
                                                    ));
                                          } else {
                                            SQLHelper.adduser(
                                                usernameController.text,
                                                emailController.text,
                                                passwordController.text,
                                                nameController.text,
                                                addressController.text,
                                                phoneController.text,
                                                bornController.text,
                                                photo);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => LoginView(
                                                          data: formData,
                                                        )));
                                          }
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  ));
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                )),
          ),
        ));
  }

  bool isSameEmail(String email) {
    for (var user in users) {
      if (email == user['email']) {
        return true;
      }
    }
    return false;
  }

  bool isSameUsername(String username) {
    for (var user in users) {
      if (username == user['username']) {
        return true;
      }
    }
    return false;
  }
}

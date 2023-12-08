import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_pbp/client/userClient.dart';
import 'package:ugd2_pbp/entity/userEntity.dart';
import 'package:ugd2_pbp/view/login_register/loginNew.dart';

class RegisterViewNew extends StatefulWidget {
  const RegisterViewNew({super.key});

  @override
  State<RegisterViewNew> createState() => _RegisterViewNewState();
}

class _RegisterViewNewState extends State<RegisterViewNew> {
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
  Widget build(BuildContext context) {
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
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 214, 0),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(70),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topCenter,
                color: Colors.transparent,
                child: const CircleAvatar(
                  radius: 60,
                  backgroundColor: Color.fromARGB(255, 255, 136, 26),
                  backgroundImage: AssetImage("images/profilregis.png"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.black, // Add this line
                ),
              ),
              const SizedBox(height: 5),
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: Column(children: [
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
                                isPasswordVisible ? Colors.black : Colors.black,
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
                        color: Colors.black, // Change text color
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
                          color: Colors.black, // Change text color
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
                          color: Colors.black, // Change text color
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
                          color: Colors.black, // Change text color
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
                          color: Colors.black, // Change text color
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
                    const SizedBox(height: 10),
                    CheckboxListTileFormField(
                      title: const Text(
                        "I Agree with terms & condition*",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black, // Add this line
                        ),
                      ),
                      validator: (value) {
                        if (!(value!)) {
                          return 'Must be checked!';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controlAffinity: ListTileControlAffinity.leading,
                      checkColor: Colors.white,
                      activeColor: Colors.black,
                    ),
                    const SizedBox(height: 10),
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
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: const Text(
                                      'Are you sure the data was already correct?',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black, // Add this line
                                      ),
                                    ),
                                    actions: <Widget>[
                                      InkWell(
                                        onTap: () =>
                                            Navigator.pop(context, 'No'),
                                        onHover: (value) {},
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              right: 20,
                                              left: 20,
                                              top: 5,
                                              bottom: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            border: Border.all(
                                                color:
                                                    Colors.red), // Border color
                                            borderRadius: BorderRadius.circular(
                                                30), // Border radius
                                          ),
                                          child: Text(
                                            'No',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins'),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => LoginNew(),
                                            ),
                                          );
                                        },
                                        onHover: (value) {
                                          BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.red));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              right: 20,
                                              left: 20,
                                              top: 5,
                                              bottom: 5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    Colors.red), // Border color
                                            borderRadius: BorderRadius.circular(
                                                30), // Border radius
                                          ),
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                          UserClient.create(User(
                              id: 0,
                              username: usernameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              address: addressController.text,
                              bornDate: bornController.text,
                              phoneNumber: phoneController.text,
                              photo: "-"));
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

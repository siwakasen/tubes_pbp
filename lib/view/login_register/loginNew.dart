import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_pbp/client/userClient.dart';
import 'package:ugd2_pbp/entity/userEntity.dart';
import 'package:ugd2_pbp/view/login_register/registerNew.dart';
import 'package:ugd2_pbp/view/home/home_bottom.dart';
import 'package:ugd2_pbp/view/home/home_view.dart';
import 'package:ugd2_pbp/theme/theme.dart';
import 'package:ugd2_pbp/view/login_register/forgot_password.dart';
import '../../theme/theme_provider.dart';

class LoginNew extends StatefulWidget {
  const LoginNew({super.key});

  @override
  State<LoginNew> createState() => _LoginNewState();
}

class _LoginNewState extends State<LoginNew> {
  bool isPasswordVisible = false;
  Future<User> onLogin() async {
    try {
      User user = await UserClient.login(
          usernameController.text, passwordController.text);
      return user;
    } catch (e) {
      print(e.toString());
    }
    return User(
      id: -1,
      username: '',
      email: '',
      password: '',
      name: '',
      address: '',
      bornDate: '',
      phoneNumber: '',
      photo: '',
      idRestaurant: null,
    );
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final gradient = themeProvider.isDarkMode
        ? CustomTheme.darkGradient
        : CustomTheme.lightGradient;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Container(
                height: 900,
                decoration: BoxDecoration(
                  gradient: gradient,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'images/login.png',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 214, 0),
                          borderRadius: BorderRadius.circular(50.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0.2,
                              blurRadius: 3,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Login Account",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 25.0),
                                      child: Text(
                                        "Username",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextFormField(
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                      errorStyle: const TextStyle(
                                        fontSize: 12.0,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.red,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 12.0,
                                        horizontal: 16.0,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Username cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 25.0),
                                      child: Text(
                                        "Password",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: !isPasswordVisible,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isPasswordVisible =
                                                !isPasswordVisible;
                                          });
                                        },
                                        icon: Icon(
                                          isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: isPasswordVisible
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 12.0,
                                        horizontal: 16.0,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const ForgotPasswordView()),
                                          );
                                        },
                                        child: const Text(
                                          "forgot password?",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 105.0, right: 25),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const RegisterViewNew()),
                                            );
                                          },
                                          child: const Text(
                                            "Sign Up",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 245, 110, 73),
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 40, bottom: 8, top: 8),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      User a = await onLogin();
                                      print(a.id);
                                      if (a.id != -1) {
                                        int userId = a.id;
                                        Fluttertoast.showToast(
                                          msg: 'Login Successful!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: const Color.fromARGB(
                                              255, 245, 110, 73),
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                        addIntToSF(userId);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => HomeBottomView(
                                                    initialSelectedIndex: 0,
                                                  )),
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: 'Username/Password may be wrong',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: const Color.fromARGB(
                                              255, 245, 110, 73),
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 20,
              right: 5,
              child: Switch(
                value: themeProvider.isDarkMode,
                activeColor: Colors.grey[300],
                inactiveThumbColor: Colors.yellow[700],
                inactiveTrackColor: Colors.blue[200],
                activeTrackColor: Colors.black,
                onChanged: (bool value) {
                  themeProvider.toggleTheme();
                },
              ))
        ],
      ),
    );
  }
}

addIntToSF(int userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('intValue', userId);
}

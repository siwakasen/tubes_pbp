import 'package:flutter/material.dart';
import 'package:ugd2_pbp/database/sql_helper.dart';
import 'package:ugd2_pbp/view/login/register.dart';
import 'package:ugd2_pbp/component/form_component.dart';
import 'package:ugd2_pbp/home.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;

// class DarkThemePreference {
//   static const THEME_STATUS = "THEMESTATUS";

//   setDarkTheme(bool value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool(THEME_STATUS, value);
//   }

//   Future<bool> getTheme() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(THEME_STATUS) ?? false;
//   }
// }

// class DarkThemeProvider with ChangeNotifier {
//   DarkThemePreference darkThemePreference = DarkThemePreference();
//   bool _darkTheme = false;

//   bool get darkTheme => _darkTheme;

//   set darkTheme(bool value) {
//     _darkTheme = value;
//     darkThemePreference.setDarkTheme(value);
//     notifyListeners();
//   }
// }

class LoginView extends StatefulWidget {
  final Map? data;

  const LoginView({Key? key, this.data}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _passwordVisible = false;
  Color appBarColor = Colors.orange;
  Color bodyColor = Colors.white;
  Color fontColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: globals.isDarkMode ? Colors.white : Colors.white,
          brightness: globals.isDarkMode ? Brightness.dark : Brightness.light),
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                globals.isDarkMode = !globals.isDarkMode;
              });
            },
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            child: globals.isDarkMode
                ? Icon(Icons
                    .wb_sunny_outlined) // Mode gelap, tampilkan ikon matahari
                : Icon(Icons.nightlight_round)),
        body: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                // color: Color.fromARGB(255, 255, 187, 0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              constraints: BoxConstraints(maxWidth: 300.0, maxHeight: 400.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('LOGIN'),
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "username kosong";
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        // icon: Icon(Icons.password),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "password kosong";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (cekUser(usernameController.text,
                                  passwordController.text)) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const HomeView()),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Password salah'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('Login'),
                        ),
                        TextButton(
                          onPressed: () {
                            Map<String, dynamic> FormData = {};
                            FormData['username'] = usernameController.text;
                            FormData['password'] = passwordController.text;
                            pushRegister(context);
                          },
                          child: Text(
                            'Belum punya akun?',
                            style: TextStyle(
                                color: globals.isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool cekUser(String username, String password) {
    return false;
  }

  void pushRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterView(),
      ),
    );
  }
}

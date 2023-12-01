// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ugd2_pbp/client/userClient.dart';
import 'package:ugd2_pbp/database/sql_helper.dart';
import 'package:ugd2_pbp/entity/userEntity.dart';
import 'package:ugd2_pbp/view/login/register.dart';
import 'package:ugd2_pbp/view/userView/homeBottom.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd2_pbp/view/login/forgot_password.dart';

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

  Future<User> onLogin() async {
    try {
      print("TEST");
      User user = await UserClient.login(
          usernameController.text, passwordController.text);
      print(user.id);
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
        photo: '');
  }

  @override
  Widget build(BuildContext context) {
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
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              User a = await onLogin();
                              if (a.id != -1) {
                                int userId = a.id;
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          title: const Text('Login Success'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                globals.setRefresh = 1;
                                                addIntToSF(userId);
                                                print(userId);
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => HomeViewStf(
                                                          initialSelectedIndex:
                                                              0)),
                                                );
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ));
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text(
                                        'Username or Password may not correct'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK')),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const ForgotPasswordView()),
                                          );
                                        },
                                        child: const Text('Forgot Password'),
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

  int getUserId(String username, String password) {
    refresh();

    for (var user in users) {
      if (username == user['username'] && password == user['password']) {
        return user['id'];
      }
    }
    return 0;
  }

  bool cekUser(String username, String password) {
    for (var user in users) {
      if (username == user['username'] && password == user['password']) {
        return true;
      }
    }
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

  addIntToSF(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('intValue', userId);
  }

  void showSnackBar(BuildContext context, String msg, Color bg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: bg,
      action: SnackBarAction(
          label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
    ));
  }
}

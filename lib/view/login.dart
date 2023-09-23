import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/home.dart';
import 'package:ugd2_pbp/view/register.dart';
import 'package:ugd2_pbp/component/form_component.dart';

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  Color appBarColor = Colors.blue;
  Color bodyColor = Colors.white;
  Color fontColor = Colors.black;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Map? dataForm = widget.data;
    return MaterialApp(
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: appBarColor,
        scaffoldBackgroundColor: bodyColor,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: fontColor,
          ),
          bodyText2: TextStyle(
            color: fontColor,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          actions: [
            IconButton(
              icon: isDarkMode
                  ? Icon(Icons.wb_sunny_outlined) // Mode gelap, tampilkan ikon matahari
                  : Icon(Icons.nightlight_round), // Mode terang, tampilkan ikon bulan
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                  if (isDarkMode) {
                    appBarColor = Colors.black;
                    bodyColor = const Color.fromARGB(115, 93, 93, 93);
                    fontColor = Colors.white;
                  } else {
                    appBarColor = Colors.blue;
                    bodyColor = Colors.white;
                    fontColor = Colors.black;
                  }
                });
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //* username
                inputForm((p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "username tidak boleh kosong";
                  }
                  return null;
                },
                    controller: usernameController,
                    hintTxt: "Username",
                    helperTxt: "Inputkan User yang telah didaftar",
                    iconData: Icons.person),
                //* password
                inputForm((p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "password kosong";
                  }
                  return null;
                },
                    password: true,
                    controller: passwordController,
                    hintTxt: "Password",
                    helperTxt: "Inputkan Password",
                    iconData: Icons.password),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (dataForm!['username'] ==
                                    usernameController.text &&
                                dataForm['password'] == passwordController.text) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const HomeView()));
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Password Salah'),
                                  content: TextButton(
                                      onPressed: () => pushRegister(context),
                                      child: const Text('Daftar Disini !!')),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
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
                        child: const Text('Login')),
                    TextButton(
                        onPressed: () {
                          Map<String, dynamic> formData = {};
                          formData['username'] = usernameController.text;
                          formData['password'] = passwordController.text;
                          pushRegister(context);
                        },
                        child: const Text('Belum punya akun?')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

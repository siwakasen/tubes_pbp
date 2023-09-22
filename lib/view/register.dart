import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/login.dart';
import 'package:ugd2_pbp/component/form_component.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData.light(), // Tema light mode
      darkTheme: ThemeData.dark(), // Tema dark mode
      home: RegisterView(),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  
  Color appBarColor = Colors.blue;
  Color bodyColor = Colors.white;
  Color fontColor = Colors.black;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: appBarColor,
        scaffoldBackgroundColor: bodyColor,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          bodyText2: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          actions: [
            IconButton(
              icon: isDarkMode
                  ? Icon(Icons.wb_sunny_outlined) // Mode gelap, ikon matahari
                  : Icon(Icons.nightlight_round), // Mode terang, ikon bulan
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
                inputForm(
                  (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Username Tidak Boleh Kosong';
                    }
                    if (p0.toLowerCase() == 'anjing') {
                      return 'Tidak Boleh Menggunakan kata Kasar';
                    }
                    return null;
                  },
                  controller: usernameController,
                  hintTxt: "Username",
                  helperTxt: "Ucup Surucup",
                  iconData: Icons.person,
                ),
                inputForm(
                  ((p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    if (!p0.contains('@')) {
                      return 'Email harus menggunakan @';
                    }
                    return null;
                  }),
                  controller: emailController,
                  hintTxt: "Email",
                  helperTxt: "ucup@gmail.com",
                  iconData: Icons.email,
                ),
                inputForm(
                  ((p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    if (p0.length < 5) {
                      return 'Password minimal 5 digit';
                    }
                    return null;
                  }),
                  controller: passwordController,
                  hintTxt: "Password",
                  helperTxt: "xxxxxxx",
                  iconData: Icons.password,
                  password: true,
                ),
                inputForm(
                  ((p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Nomor telepon tidak boleh kosong';
                    }
                    return null;
                  }),
                  controller: notelpController,
                  hintTxt: "No telp",
                  helperTxt: "082123456789",
                  iconData: Icons.phone_android,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> formData = {};
                      formData['username'] = usernameController.text;
                      formData['password'] = passwordController.text;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginView(data: formData),
                        ),
                      );
                    }
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

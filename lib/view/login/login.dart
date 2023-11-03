import 'package:flutter/material.dart';
import 'package:ugd2_pbp/database/sql_helper.dart';
import 'package:ugd2_pbp/view/login/register.dart';
import 'package:ugd2_pbp/view/userView/home_bottom.dart';
import 'package:ugd2_pbp/component/dark_mode_state.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

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

  final SpeechToText _speechToText = SpeechToText();

  String _lastWords = '';

  bool _passwordVisible = false;

  Color appBarColor = Colors.orange;
  Color bodyColor = Colors.white;
  Color fontColor = Colors.black;

  List<Map<String, dynamic>> users = [];

  void refresh() async {
    final data = await SQLHelper.getuser();
    _initSpeech();
    setState(() {
      users = data;
    });
  }

  bool _speechEnabled = false;

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  void initState() {
    refresh();

    super.initState();
    _initSpeech();
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
                ? const Icon(Icons
                    .wb_sunny_outlined) // Mode gelap, tampilkan ikon matahari
                : const Icon(Icons.nightlight_round)),
        body: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                // color: Color.fromARGB(255, 255, 187, 0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              constraints:
                  const BoxConstraints(maxWidth: 300.0, maxHeight: 400.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('LOGIN'),
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: _lastWords,
                        suffixIcon: IconButton(
                            icon: Icon(
                              _speechToText.isListening
                                  ? Icons.mic_rounded
                                  : Icons.mic_off_rounded,
                            ),
                            onPressed: _speechToText.isNotListening
                                ? _startListening
                                : _stopListening),
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
                              if (cekUser(usernameController.text,
                                  passwordController.text)) {
                                int userId = getUserId(usernameController.text,
                                    passwordController.text);
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          title: const Text('Login Success'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                addIntToSF(userId);

                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          const HomeView()),
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
                                                onPressed: () => Navigator.pop(
                                                    context, 'OK'),
                                                child: const Text('OK')),
                                          ],
                                        ));
                              }
                            }
                          },
                          child: const Text('Login'),
                        ),
                        TextButton(
                          onPressed: () {
                            Map<String, dynamic> formData = {};
                            formData['username'] = usernameController.text;
                            formData['password'] = passwordController.text;
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
}

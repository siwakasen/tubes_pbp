import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/login/register.dart';
import 'package:ugd2_pbp/view/login/InputField.dart';
import 'package:ugd2_pbp/view/login/FormButton.dart';
import 'package:ugd2_pbp/view/login/register.dart';

class SimpleLoginScreen extends StatefulWidget {
  final Function(String? username, String? password)? onSubmitted;

  const SimpleLoginScreen({this.onSubmitted, Key? key}) : super(key: key);
  @override
  State<SimpleLoginScreen> createState() => _SimpleLoginScreenState();
}

class _SimpleLoginScreenState extends State<SimpleLoginScreen> {
  late String username, password;
  String? usernameError, passwordError;
  Function(String? username, String? password)? get onSubmitted =>
      widget.onSubmitted;

  @override
  void initState() {
    super.initState();
    username = '';
    password = '';

    usernameError = null;
    passwordError = null;
  }

  void resetErrorText() {
    setState(() {
      usernameError = null;
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    bool isValid = true;
    if (username.isEmpty) {
      setState(() {
        usernameError = 'Username is invalid';
      });
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = 'Please enter a password';
      });
      isValid = false;
    }

    return isValid;
  }

  void submit() {
    if (validate()) {
      if (onSubmitted != null) {
        onSubmitted!(username, password);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: screenHeight * .05),
              Container(
                width: 300,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 214, 0, 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * .01),
                    Text(
                      'Sign in to continue!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black.withOpacity(.6),
                      ),
                    ),
                    SizedBox(height: screenHeight * .12),
                    InputField(
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                      labelText: 'Username',
                      errorText: usernameError,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      autoFocus: true,
                    ),
                    SizedBox(height: screenHeight * .025),
                    InputField(
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      onSubmitted: (val) => submit(),
                      labelText: 'Password',
                      errorText: passwordError,
                      isPassword: true,
                      textInputAction: TextInputAction.next,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .075,
                    ),
                    FormButton(
                      text: 'Log In',
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterView(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * .15,
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisterView(),
                  ),
                ),
                child: RichText(
                  text: const TextSpan(
                    text: "I'm a new user, ",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Register',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/login/SimpleRegisterScreen.dart';
import 'package:ugd2_pbp/view/login/InputField.dart';
import 'package:ugd2_pbp/view/login/FormButton.dart';

class SimpleLoginScreen extends StatefulWidget {
  final Function(String? email, String? password)? onSubmitted;

  const SimpleLoginScreen({this.onSubmitted, Key? key}) : super(key: key);
  @override
  State<SimpleLoginScreen> createState() => _SimpleLoginScreenState();
}

class _SimpleLoginScreenState extends State<SimpleLoginScreen> {
  late String email, password;
  String? emailError, passwordError;
  Function(String? email, String? password)? get onSubmitted =>
      widget.onSubmitted;

  @override
  void initState() {
    super.initState();
    email = '';
    password = '';

    emailError = null;
    passwordError = null;
  }

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;
    if (email.isEmpty || !emailExp.hasMatch(email)) {
      setState(() {
        emailError = 'Email is invalid';
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
        onSubmitted!(email, password);
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
                        email = value;
                      });
                    },
                    labelText: 'Email',
                    errorText: emailError,
                    keyboardType: TextInputType.emailAddress,
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
                    onPressed: submit,
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
                  builder: (_) => const SimpleRegisterScreen(),
                ),
              ),
              child: RichText(
                text: const TextSpan(
                  text: "I'm a new user, ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
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




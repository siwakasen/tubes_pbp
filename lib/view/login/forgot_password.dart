import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ugd2_pbp/client/userClient.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final passwordValidateController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void onSubmit() async {
      if (!_formKey.currentState!.validate()) return;
      if (passwordController.text != passwordValidateController.text) {
        showSnackBar(context, 'Password tidak sama', Colors.red);
        return;
      }
      try {
        Response res = await UserClient.updatePassword(
            passwordController.text, emailController.text);
        String message = json.decode(res.body)['message'];
        if (res.statusCode == 404) {
          showSnackBar(context, message, Colors.red);
          return;
        }
        showSnackBar(context, "Berhasil Mengubah Password", Colors.green);
        Navigator.pop(context);
      } catch (err) {
        showSnackBar(context, err.toString(), Colors.red);
        Navigator.pop(context);
      }
    }

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
        title: Text(
          'Forgot Password',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
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
                          labelText: 'Enter New Password'),
                      controller: passwordController,
                      cursorColor: Colors.black,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
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
                          labelText: 'Enter Validate New Password'),
                      controller: passwordValidateController,
                      cursorColor: Colors.black,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
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
                          labelText: 'Your Email'),
                      controller: emailController,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black, // Change text color
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: ElevatedButton(
                        onPressed: onSubmit,
                        child: Text('Change Password'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 132, 0),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            padding:
                                const EdgeInsets.only(left: 60, right: 60))),
                  )
                ],
              ))),
    );
  }
}

void showSnackBar(BuildContext context, String msg, Color bg) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: bg,
    action:
        SnackBarAction(label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
  ));
}

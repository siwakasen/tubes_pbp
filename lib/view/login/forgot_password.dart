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
        title: Text('Forgot Password'),
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
                          labelText: 'Masukkan Password Baru'),
                      controller: passwordController,
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
                          labelText: 'Masukkan Validasi Password Baru'),
                      controller: passwordValidateController,
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
                          labelText: 'Masukkan Email'),
                      controller: emailController,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: ElevatedButton(
                        onPressed: onSubmit, child: Text('Simpan')),
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

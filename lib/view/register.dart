import 'package:flutter/material.dart';

import 'package:ugd2_pbp/component/inputForm.dart';
import 'package:ugd2_pbp/view/login.dart';

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

  bool visibilityToggler = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              inputForm((p0) {
                if (p0 == null || p0.isEmpty) {
                  return "Username Tidak Boleh Kosong";
                }
                if (p0.toLowerCase() == "anjing") {
                  return "Tidak Boleh menggunakan kata kasar";
                }
                return null;
              },
                  controller: usernameController,
                  hintTxt: "Username",
                  helperTxt: "Uccup Serucup",
                  iconData: Icons.person),
              inputForm((p0) {
                if (p0 == null || p0.isEmpty) {
                  return "Email Tidak Boleh Kosong";
                }
                if (!p0.contains('@')) {
                  return "Email Harus menggunakan @";
                }
                return null;
              },
                  controller: emailController,
                  hintTxt: "Email",
                  helperTxt: "Ucup@gmail.com",
                  iconData: Icons.email),
              Row(
                children: [
                  inputForm((p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "password Tidak Boleh Kosong";
                    }
                    if (p0.length < 5) {
                      return "password minimal 5 digit";
                    }
                    return null;
                  },
                      controller: passwordController,
                      hintTxt: "password",
                      helperTxt: "xxxxxxx",
                      iconData: Icons.password,
                      password: visibilityToggler),
                  IconButton(
                    icon: Icon(visibilityToggler
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        visibilityToggler = !visibilityToggler;
                      });
                    },
                  )
                ],
              ),
              inputForm(
                (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "Nomor Telepon Tidak Boleh Kosong";
                  }

                  return null;
                },
                controller: notelpController,
                hintTxt: "No Telp",
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
                            builder: (_) => LoginView(data: formData)));
                  }
                },
                child: const Text("Register"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

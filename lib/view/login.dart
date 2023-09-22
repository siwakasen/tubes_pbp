import 'package:flutter/material.dart';
import 'package:ugd2_pbp/component/inputForm.dart';

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool visibilityToggler = true;

    Map? dataForm = widget.data;

    return Scaffold(
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                inputForm((p0) => null,
                    controller: usernameController,
                    hintTxt: "Username",
                    helperTxt: "Input Username",
                    iconData: Icons.person,
                    password: visibilityToggler, onTap: () {
                  setState(() {
                    visibilityToggler = !visibilityToggler;
                  });
                })
              ],
            )),
      ),
    );
  }
}

// void pushRegister(BuildContext context) {
//   Navigator.push(
//       context, MaterialPageRoute(builder: (_) => const RegisterView()));
// }

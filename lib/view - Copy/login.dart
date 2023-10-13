import 'package:flutter/material.dart';
import 'package:ugd2_pbp/component/inputForm.dart';
import 'package:ugd2_pbp/view/register.dart';

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  late bool visibilityToggler;
  @override
  void initState() {
    visibilityToggler = false;
  }

  void toggle() {
    setState(() {
      visibilityToggler = !visibilityToggler;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Map? dataForm = widget.data;

    return Scaffold(
      body: SafeArea(
        child: Card(
          color: Colors.yellow,
          margin: EdgeInsets.all(12),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "username tidak boleh kosong";
                      }
                      return null;
                    },
                    controller: usernameController,
                    hintTxt: "Username",
                    helperTxt: "Inputkan User yang telah didaftar",
                    iconData: Icons.person,
                  ),
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "password kosong";
                      }
                      return null;
                    },
                    password: true,
                    controller: passwordController,
                    hintTxt: "Password",
                    helperTxt: "Inputkan Password",
                    iconData: Icons.password,
                    toggler: toggle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (dataForm != null &&
                                  dataForm['username'] ==
                                      usernameController.text &&
                                  dataForm['password'] ==
                                      passwordController.text) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const RegisterView()),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Password Salah'),
                                    content: TextButton(
                                      onPressed: () => pushRegister(context),
                                      child: const Text('Daftar Disini !!'),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, "Cancel"),
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, "Ok"),
                                        child: const Text("Ok"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text("Login")),
                      TextButton(
                        onPressed: () {
                          Map<String, dynamic> formData = {};
                          formData['username'] = usernameController.text;
                          formData['password'] = passwordController.text;
                          pushRegister(context);
                        },
                        child: const Text("Belum punya akun ?"),
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}

void pushRegister(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (_) => const RegisterView()));
}

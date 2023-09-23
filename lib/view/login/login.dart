import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/login/register.dart';
import 'package:ugd2_pbp/component/form_component.dart';

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

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(12.0),
            ),
            constraints: BoxConstraints(maxWidth: 300.0, maxHeight: 300.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  inputForm((p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "username tidak boleh kosong";
                    }
                    return null;
                  }, controller: usernameController, labelTxt: "Username"),
                  TextFormField(
                    controller: passwordController,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      labelText: 'password',
                      hintText: 'Inputkan Password',
                      helperText: 'Inputkan Password',
                      icon: Icon(Icons.password),
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
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (dataForm!['username'] ==
                                    usernameController.text &&
                                dataForm['password'] ==
                                    passwordController.text) {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (_) => const HomeView()),
                              // );
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Password salah'),
                                  content: TextButton(
                                    onPressed: () => pushRegister(context),
                                    child: const Text('Daftar Disini !!'),
                                  ),
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
                        child: const Text('Login'),
                      ),
                      TextButton(
                        onPressed: () {
                          Map<String, dynamic> FormData = {};
                          FormData['username'] = usernameController.text;
                          FormData['password'] = passwordController.text;
                          pushRegister(context);
                        },
                        child: const Text('Belum punya akun?'),
                      ),
                    ],
                  )
                ],
              ),
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

import 'package:flutter/material.dart';
// import 'package:guidedlayout2_1396/View/login.dart';
import 'package:ugd2_pbp/component/form_component.dart';
import 'package:ugd2_pbp/view/login/login.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

enum SingingCharacter { male, female }

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  String? gender;
  bool? isChecked = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: IconButton(
                        color: const Color(0xFF323232),
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      title: const Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      contentPadding: const EdgeInsets.only(top: 50),
                    ),
                    inputForm(
                      (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Nama Tidak Boleh Kosong';
                        }
                        return null;
                      },
                      controller: nameController,
                      labelTxt: "Name",
                    ),
                    inputForm((p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Username Tidak Boleh Kosong';
                      }
                      return null;
                    }, controller: usernameController, labelTxt: "Username"),
                    inputForm(((p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      if (p0.length < 5) {
                        return 'Password minimal 5 digit';
                      }
                      return null;
                    }),
                        controller: passwordController,
                        labelTxt: "Password",
                        password: true),
                    const ListTile(
                      title: Text(
                        "Gender",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: 400,
                      child: Column(
                        children: [
                          RadioListTile(
                            title: Text("Male"),
                            value: "male",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Female"),
                            value: "female",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          onTap: () async {
                            DateTime? _picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            if (_picked != null) {
                              setState(() {
                                dateController.text =
                                    _picked.toString().split(" ")[0];
                              });
                            }
                          },
                          controller: dateController,
                          decoration: InputDecoration(
                              labelText: 'Date',
                              filled: true,
                              prefixIcon: Icon(Icons.calendar_today),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue))),
                          readOnly: true,
                        ),
                      ),
                    ),
                    CheckboxListTile(
                      title: Text("I Agree with terms & condition"),
                      value: isChecked,
                      activeColor: Colors.blue,
                      onChanged: (newBool) {
                        setState(() {
                          isChecked = newBool;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 255, 132,
                              0), //background color of button //border width and color
                          elevation: 3, //elevation of button
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.only(
                              left: 60,
                              right: 60) //content padding inside button
                          ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> formData = {};
                          formData['username'] = usernameController.text;
                          String user = usernameController.text;
                          formData['password'] = passwordController.text;
                          String pass = passwordController.text;

                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: const Text(
                                        'Apakah sudah yakin data yang diinputkan benar?'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'No'),
                                          child: const Text('No')),
                                      TextButton(
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => LoginView(
                                                      data: formData,
                                                    ))),
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  ));
                        }
                      },
                      child: const Text('Register'),
                    )
                  ],
                )),
          ),
        ));
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (_picked != null) {
      setState(() {
        dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:ugd2_pbp/component/darkModeState.dart' as globals;

Padding inputForm(Function(String?) validasi,
    {required TextEditingController controller,
    required String labelTxt,
    bool password = false}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, top: 20),
    child: SizedBox(
      width: 350,
      child: TextFormField(
        style:
            TextStyle(color: globals.isDarkMode ? Colors.white : Colors.black),
        validator: (value) => validasi(value),
        autofocus: false,
        controller: controller,
        obscureText: password,
        decoration: InputDecoration(
          labelText: labelTxt,
          border: const UnderlineInputBorder(),
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';

Padding inputForm(Function(String?) validasi,
    {required TextEditingController controller,
    required String hintTxt,
    required String helperTxt,
    required IconData iconData,
    bool password = false,
    required Function onTap}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, top: 10),
    child: SizedBox(
      width: 310,
      child: TextFormField(
        validator: (value) => validasi(value),
        autofocus: true,
        controller: controller,
        obscureText: password,
        decoration: InputDecoration(
            hintText: hintTxt,
            border: const OutlineInputBorder(),
            helperText: helperTxt,
            prefixIcon: Icon(iconData),
            suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  password ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
                onPressed: onTap())),
      ),
    ),
  );
}

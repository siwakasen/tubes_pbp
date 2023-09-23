import 'package:flutter/material.dart';
import 'package:ugd2_pbp/view/SimpleLoginScreen.dart';
import 'package:ugd2_pbp/view/SimpleRegisterScreen.dart';
import 'package:ugd2_pbp/view/FormButton.dart';

class InputField extends StatefulWidget {
  final String? labelText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autoFocus;
  final bool isPassword; // Tambahkan properti ini untuk menandakan apakah input adalah password

  const InputField({
    this.labelText,
    this.onChanged,
    this.onSubmitted,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.autoFocus = false,
    this.isPassword = false, // Defaultnya adalah bukan password
    Key? key,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _passwordVisible = false; // Variabel untuk mengontrol visibilitas kata sandi

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: widget.autoFocus,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.isPassword ? !_passwordVisible : false, // Gunakan _passwordVisible hanya jika ini adalah input kata sandi
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.errorText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true, // Mengisi latar belakang input
        fillColor: Colors.white, // Warna latar belakang putih
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        // Tombol mata (eye toggle) hanya jika ini adalah input kata sandi
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                child: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null, // Tambahkan null jika ini bukan input kata sandi
      ),
    );
  }
}






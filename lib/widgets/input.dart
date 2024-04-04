import 'package:flutter/material.dart';

Widget myInput({
  bool readOnly = true,
  bool obscureText = false,
  Widget? suffixIcon,
  required String prefixText,
  required TextEditingController controller,
  String? Function(String?)? validator,
  void Function(String?)? onSaved,
}) {
  return TextFormField(
    controller: controller,
   readOnly: readOnly,
    obscureText: obscureText,
    decoration: InputDecoration(
      prefixText: '',
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      filled: true,
      fillColor: Colors.white,
      errorStyle: const TextStyle(
        color: Colors.red,
        fontSize: 12,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
    ),
    keyboardType: obscureText ? TextInputType.text : TextInputType.emailAddress,
    validator: validator,
    onSaved: onSaved,
  );
}

import 'package:flutter/material.dart';

ButtonStyle buttonStyle = ElevatedButton.styleFrom(
  backgroundColor: const Color.fromARGB(255, 135, 143, 250),
  foregroundColor: Colors.white,
  shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5)),
  fixedSize: const Size(double.infinity, 50),
);

InputDecoration inputDecoration(String labelText, IconData icon) {
  return InputDecoration(
    enabled: true,
    labelText: labelText, //'Email',
    floatingLabelStyle: const TextStyle(
      color: Color.fromARGB(255, 226, 228, 230),
    ),
    labelStyle: const TextStyle(
      color: Color.fromARGB(255, 226, 228, 230),
    ),
    filled: true,
    fillColor: Color.fromARGB(6, 255, 255, 255),
    prefixIcon: Icon(
      icon,
      color: const Color.fromARGB(255, 226, 228, 230),
      size: 25,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  );
}

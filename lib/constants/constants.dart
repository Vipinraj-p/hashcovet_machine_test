import 'package:flutter/material.dart';
import 'package:hashcovet_machine_test/constants/customColors.dart';
import 'package:hashcovet_machine_test/constants/customColors.dart';
import 'package:hashcovet_machine_test/dashboard.dart';

ButtonStyle buttonStyle = ElevatedButton.styleFrom(
  backgroundColor: customButtonColor,
  foregroundColor: customWhiteColor,
  shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5)),
  fixedSize: const Size(double.infinity, 50),
);
MaterialPageRoute navigatorToDashboard =
    MaterialPageRoute(builder: (context) => const Dashboard());

InputDecoration inputDecoration(String labelText, IconData icon) {
  return InputDecoration(
    enabled: true,
    labelText: labelText, //'Email',
    floatingLabelStyle: TextStyle(
      color: customWhiteColor,
    ),
    labelStyle: TextStyle(
      color: customWhiteColor,
    ),
    filled: true,
    fillColor: Color.fromARGB(6, 255, 255, 255),
    prefixIcon: Icon(
      icon,
      color: customWhiteColor,
      size: 25,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  );
}

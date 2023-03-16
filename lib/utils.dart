import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(
      String? text, ScaffoldMessengerState scaffoldMessengerState) {
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red);

    scaffoldMessengerState
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
